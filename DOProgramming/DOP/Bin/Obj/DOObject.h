//
//  DOObject.h
//  DOProgramming
//
//  Created by 丁治文 on 2017/9/7.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import "DOProtocol.h"

@interface DOObject : NSObject<DOProtocol>

@property (copy  , nonatomic, readonly) NSString *uuid;
@property (copy  , nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger tag;

+ (instancetype)demand;

@end
