//
//  WCReuseObject.m
//  AstonMartin
//
//  Created by 丁治文 on 16/11/28.
//  Copyright © 2016年 WeiChe. All rights reserved.
//

#import "WCReuseObject.h"

@interface WCReuseObject ()

@property (strong, nonatomic) NSMutableDictionary *mapperDict;
@property (strong, nonatomic) NSMutableDictionary *queueDict;
@property (strong, nonatomic) NSMutableDictionary *useViewDict;
@property (strong, nonatomic) NSMutableIndexSet   *needsRemoveIndexSet;

@end

@implementation WCReuseObject

- (void)registerClass:(Class)viewClass forViewReuseIdentifier:(NSString *)identifier {
    if (viewClass && identifier) {
        [self.mapperDict setObject:viewClass forKey:identifier];
    }
}

- (void)enqueueReusableView:(UIView *)view {
    if (view && view.reuseIdentifier) {
        NSMutableSet *set = self.queueDict[view.reuseIdentifier];
        if (set == nil) {
            set = [NSMutableSet set];
            [self.queueDict setObject:set forKey:view.reuseIdentifier];
        }
        [set addObject:view];
    }
}

- (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier {
    NSMutableSet *set = self.queueDict[identifier];
    UIView *view = set.anyObject;
    if (view == nil) {
        Class cClass = self.mapperDict[identifier];
        if (cClass) {
            view = [[cClass alloc] initWithReuseIdentifier:identifier];
        }
    } else {
        [set removeObject:view];
    }
    return view;
}

- (void)clearQueueWithIdentifier:(NSString *)identifier {
    if (identifier && (identifier.length > 0)) {
        NSMutableSet *set = self.queueDict[identifier];
        if (set) {
            [set removeAllObjects];
        }
    } else {
        [self.queueDict removeAllObjects];
    }
}


- (void)addUseView:(UIView *)view atIndex:(NSInteger)index {
    if (view) {
        NSString *key = [NSString stringWithFormat:@"%zi", index];
        [self.useViewDict setObject:view forKey:key];
    }
}

- (void)removeAllUseViewAndRemoveSuperView:(BOOL)removeSuperView {
    NSMutableIndexSet *allIndexSet = [NSMutableIndexSet indexSet];
    for (NSString *key in self.useViewDict.allKeys) {
        [allIndexSet addIndex:key.integerValue];
    }
    [self removeUseViewAtIndexSet:allIndexSet andRemoveSuperView:removeSuperView];
}

- (void)removeUseViewAtIndexSet:(NSIndexSet *)indexSet andRemoveSuperView:(BOOL)removeSuperView {
    if (!indexSet) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf removeUseViewAtIndex:idx removeSuperview:removeSuperView];
    }];
}

- (UIView *)removeUseViewAtIndex:(NSInteger)index removeSuperview:(BOOL)removeSuperview {
    NSString *key = [NSString stringWithFormat:@"%zi", index];
    UIView *view = self.useViewDict[key];
    if (removeSuperview) {
        [view removeFromSuperview];
    }
    [self.useViewDict removeObjectForKey:key];
    return view;
}

- (UIView *)useViewAtIndex:(NSInteger)index {
    NSString *key = [NSString stringWithFormat:@"%zi", index];
    UIView *view = self.useViewDict[key];
    return view;
}

- (BOOL)existUseViewAtIndex:(NSInteger)index {
    NSString *key = [NSString stringWithFormat:@"%zi", index];
    BOOL exist = [self.useViewDict.allKeys containsObject:key];
    return exist;
}

- (void)setNeedsRemoveIndex:(NSInteger)index {
    [self.needsRemoveIndexSet addIndex:index];
}

- (void)cancelNeedsRemoveIndex:(NSInteger)index {
    [self.needsRemoveIndexSet removeIndex:index];
}

- (void)removeNeedsIndexesAndRemoveSuperView:(BOOL)removeSuperView {
    __weak typeof(self) weakSelf = self;
    [self.needsRemoveIndexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf removeUseViewAtIndex:idx removeSuperview:removeSuperView];
        [weakSelf.needsRemoveIndexSet removeIndex:idx];
    }];
}

/// 2.0
- (void)addUseView:(UIView *)view atSuperView:(UIView *)superView atIndex:(NSInteger)index {
    if (!view) {
        return;
    }
    if (!superView) {
        return;
    }
    
    if (![superView.subviews containsObject:view]) {
        [self removeUseViewAtIndex:index removeSuperview:YES];
        [superView addSubview:view];
        [self addUseView:view atIndex:index];
    }
}

- (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier afterEnqueueFromUseViewWithVisibleIndexSet:(NSIndexSet *)indexSet {
    NSMutableIndexSet *allIndexSet = [NSMutableIndexSet indexSet];
    for (NSString *key in self.useViewDict.allKeys) {
        [allIndexSet addIndex:key.integerValue];
    }
    
    [allIndexSet removeIndexes:indexSet];
    
    if (allIndexSet.count > 0) {
        // 取出最后一个放入队列中
        NSInteger anyIndex = allIndexSet.lastIndex;
        [self enqueueReusableView:[self useViewAtIndex:anyIndex]];
        // 移除其它不用的
        [self removeUseViewAtIndexSet:allIndexSet andRemoveSuperView:YES];
    }
    return [self dequeueReusableViewWithIdentifier:identifier];
}

#pragma mark - Getters/Setters
- (NSMutableDictionary *)queueDict {
    if (_queueDict == nil) {
        _queueDict = [NSMutableDictionary dictionary];
    }
    return _queueDict;
}

- (NSMutableDictionary *)mapperDict {
    if (_mapperDict == nil) {
        _mapperDict = [NSMutableDictionary dictionary];
    }
    return _mapperDict;
}

- (NSMutableDictionary *)useViewDict {
    if (_useViewDict == nil) {
        _useViewDict = [NSMutableDictionary dictionary];
    }
    return _useViewDict;
}

- (NSMutableIndexSet *)needsRemoveIndexSet {
    if (_needsRemoveIndexSet == nil) {
        _needsRemoveIndexSet = [NSMutableIndexSet indexSet];
    }
    return _needsRemoveIndexSet;
}

@end
