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

- (UIViewController *)featchViewControllerWithIdentifier:(NSString *)identifier;
- (UIView *)featchViewWithIdentifier:(NSString *)identifier;

@end

/// 交互协议
@protocol DOResponseProtocol <NSObject>

- (BOOL)shouldResponseWithIdentifier:(NSString *)identifier;
- (void)responseWithIdentifier:(NSString *)identifier;

@end

/// 动画协议
@protocol DOAnimationProtocol <NSObject>

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
DOAnimationProtocol,
DODataProtocol>

- (void)addDObject:(id<DOProtocol>)dobject;

@end
