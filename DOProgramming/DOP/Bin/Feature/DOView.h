//
//  DOView.h
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/19.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DOObject.h"

/// 视图协议
@class DOView;
@class DOData;
@class DOResponse;
@protocol DOViewProtocol <NSObject>

@property (strong, nonatomic) DOView *childView;
@property (strong, nonatomic) DOData *data;
@property (strong, nonatomic) DOResponse *response;

@end

@interface DOView : DOObject<DOViewProtocol>

@end
