//
//  WCReuseObject.h
//  AstonMartin
//
//  Created by 丁治文 on 16/11/28.
//  Copyright © 2016年 WeiChe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+WCReuseObject.h"

/*
 快速写复用步骤
 1.在要使用复用的view中把本对象保存为全局变量
 2.在reloadData时调用[self removeAllUseViewAndRemoveSuperView:YES]移除多余的view
 3.在添加利用cell时使用[self addUseView:cell atSuperView:superView atIndex:index]
 4.实现WCReuseObjectDelegate中的2个方法
 5.出队方法使用[self dequeueReusableViewWithIdentifier:identifier afterEnqueueFromUseViewWithVisibleIndexSet:indexSet]
 
 */

@interface WCReuseObject : NSObject

- (void)registerClass:(Class)viewClass forViewReuseIdentifier:(NSString *)identifier;
- (void)enqueueReusableView:(UIView *)view;
- (__kindof UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier;
- (void)clearQueueWithIdentifier:(NSString *)identifier;// identifier==nil,清除全部

- (void)addUseView:(UIView *)view atIndex:(NSInteger)index;
- (void)removeAllUseViewAndRemoveSuperView:(BOOL)removeSuperView;
- (void)removeUseViewAtIndexSet:(NSIndexSet *)indexSet andRemoveSuperView:(BOOL)removeSuperView;
- (UIView *)removeUseViewAtIndex:(NSInteger)index removeSuperview:(BOOL)removeSuperview;
- (UIView *)useViewAtIndex:(NSInteger)index;
- (BOOL)existUseViewAtIndex:(NSInteger)index;

- (void)setNeedsRemoveIndex:(NSInteger)index;// 标记为需要删除的
- (void)cancelNeedsRemoveIndex:(NSInteger)index;// 取消标记为需要删除的
- (void)removeNeedsIndexesAndRemoveSuperView:(BOOL)removeSuperView;// 将被标记为需要删除的都删除掉

/// 2.0
/// 使用此方法来把要复用的view添加到superView上,
/// 会自动把原index位置的view移除
/// 如果该view已经在superView上,则不会移除
/// 避免index位置重复添加view
- (void)addUseView:(UIView *)view atSuperView:(UIView *)superView atIndex:(NSInteger)index;
- (__kindof UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier afterEnqueueFromUseViewWithVisibleIndexSet:(NSIndexSet *)indexSet;

@end
