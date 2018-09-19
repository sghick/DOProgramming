//
//  DOObject.h
//  DOProgramming
//
//  Created by 丁治文 on 2017/9/7.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 需求协议
@protocol DOProtocol <NSObject>

@property (copy  , nonatomic) NSString *identifier;
@property (copy  , nonatomic) NSString *path;
@property (strong, nonatomic) NSMutableDictionary<NSString *, id<DOProtocol>> *dobjectMappers;

+ (instancetype)demand;
+ (instancetype)demandWithIdentifier:(NSString *)identifier;

- (id<DOProtocol>)dobjectWithIdentifier:(NSString *)identifier;
- (void)addDObject:(id<DOProtocol>)dobject;

@end

@interface DOObject : NSObject<DOProtocol>

@end
