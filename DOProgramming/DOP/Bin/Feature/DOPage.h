//
//  DOPage.h
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/19.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DOObject.h"

/// 页面协议
@class DOPage;
@class DOView;
@class DOData;
@class DOResponse;
@protocol DOPageProtocol <NSObject>

@property (strong, nonatomic) DOPage *childPage;
@property (strong, nonatomic) DOView *view;
@property (strong, nonatomic) DOData *data;
@property (strong, nonatomic) DOResponse *response;

@property (strong, nonatomic) UIViewController *controller;

@end

@interface DOPage : DOObject <DOPageProtocol>

@end
