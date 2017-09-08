//
//  DOObject.h
//  DOProgramming
//
//  Created by 丁治文 on 2017/9/7.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DOResponse;
@class DOObject;
@protocol DOObject <NSObject>

/// 执行需求
- (DOResponse *)excute;
/// 执行需求
- (DOResponse *)excuteWithTarget:(DOObject *)target;

@end

@interface DOObject : NSObject<DOObject>

@property (copy  , nonatomic, readonly) NSString *uuid;
@property (copy  , nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger tag;

@end

@interface DOResponse : DOObject

@end
