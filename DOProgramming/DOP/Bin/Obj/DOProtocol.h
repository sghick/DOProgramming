//
//  DOProtocol.h
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/16.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 视图协议
@protocol DOViewProtocol <NSObject>

- (void)makeKeyAndVisibleInWindow:(UIWindow *)window;
- (UIViewController *)featchViewControllerWithIdentifier:(NSString *)identifier;
- (UIView *)featchViewWithIdentifier:(NSString *)identifier;

@end

/// 交互协议
@protocol DOResponseProtocol <NSObject>

- (BOOL)shouldResponseWithIdentifier:(NSString *)identifier;
- (void)responseWithIdentifier:(NSString *)identifier;
- (void)animatedWithIdentifier:(NSString *)identifier;

@end


/// 数据处理协议
@protocol DODataProtocol <NSObject>

- (id)featchDataWithIdentifier:(NSString *)identifier;
- (id)fillData:(id)data withIdentifier:(NSString *)identifier;

@end

/// 需求协议
@protocol DOProtocol <
NSObject,
DOViewProtocol,
DOResponseProtocol,
DODataProtocol>

@property (copy  , nonatomic) NSString *name;
@property (copy  , nonatomic) NSString *path;
@property (strong, nonatomic) NSMutableArray *dobjects;

+ (instancetype)demand;
+ (instancetype)demandWithName:(NSString *)name;

- (void)addDObject:(id<DOProtocol>)dobject;
- (void)removeDObjects;

@end
