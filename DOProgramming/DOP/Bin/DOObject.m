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

- (instancetype)init {
    self = [super init];
    if (self) {
        _uuid = [NSUUID UUID].UUIDString;
    }
    return self;
}

#pragma mark - DOObject
- (DOResponse *)excute {
    return nil;
}

- (DOResponse *)excuteWithTarget:(DOObject *)target {
    return nil;
}

@end

@implementation DOResponse

@end
