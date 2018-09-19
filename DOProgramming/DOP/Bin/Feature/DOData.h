//
//  DOData.h
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/19.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DOObject.h"

/// 数据处理协议
@class DOData;
@protocol DODataProtocol <NSObject>

@property (strong, nonatomic) DOData *childData;

@end

@interface DOData : DOObject<DODataProtocol>

@end
