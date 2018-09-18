//
//  DOObject.m
//  DOProgramming
//
//  Created by 丁治文 on 2017/9/7.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import "DOObject.h"

@interface DOObject ()

@end

@implementation DOObject

@synthesize dobjects = _dobjects;

- (void)dealloc {
    NSLog(@"释放了Demand:<%@,%p>", [self class], self);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _uuid = [NSUUID UUID].UUIDString;
    }
    return self;
}

+ (instancetype)demand {
    DOObject *obj = [[self alloc] init];
    return obj;
}
#pragma mark - DOViewProtocol

- (UIViewController *)featchViewControllerWithIdentifier:(NSString *)identifier {
    return nil;
}
- (UIView *)featchViewWithIdentifier:(NSString *)identifier {
    return nil;
}

#pragma mark - DOResponseProtocol

- (BOOL)shouldResponseWithIdentifier:(NSString *)identifier {
    return YES;
}
- (void)responseWithIdentifier:(NSString *)identifier {
    ///
}

#pragma mark - DOAnimationProtocol

- (void)animatedWithIdentifier:(NSString *)identifier {
    ///
}

#pragma mark - DODataProtocol

- (id)featchDataWithIdentifier:(NSString *)identifier {
    return nil;
}
- (id)fillData:(id)data withIdentifier:(NSString *)identifier {
    return nil;
}

#pragma mark - DOProtocol

- (void)addDObject:(id<DOProtocol>)dobject {
    if (!dobject) {
        return;
    }
    [self.dobjects addObject:dobject];;
}

- (void)removeDObjects {
    [self.dobjects removeAllObjects];
}

- (NSMutableArray *)dobjects {
    if (!_dobjects) {
        _dobjects = [NSMutableArray array];
    }
    return _dobjects;
}

@end
