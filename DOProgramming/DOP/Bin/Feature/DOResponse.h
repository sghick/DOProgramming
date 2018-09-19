//
//  DOResponse.h
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/19.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DOObject.h"

/// 交互协议
@class DOResponse;
@protocol DOResponseProtocol <NSObject>

@property (strong, nonatomic) DOResponse *childResponse;

@end

@interface DOResponse : DOObject<DOResponseProtocol>

@end
