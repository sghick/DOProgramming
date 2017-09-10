//
//  DOWindowDemand.m
//  DOProgramming
//
//  Created by 丁治文 on 17/9/9.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import "DOWindowDemand.h"

@implementation DOWindowDemand

- (instancetype)initWithWindow:(UIWindow *)window {
    self = [super init];
    if (self) {
        _window = window;
    }
    return self;
}

- (DOResponse *)excuteWithTarget:(DOObject *)target {
    UIViewController *controller = [[UIViewController alloc] init];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    return nil;
}

@end
