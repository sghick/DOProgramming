//
//  DORoot.m
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/19.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DORoot.h"

@implementation DORoot
@synthesize window = _window;

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _window;
}

- (void)makeKeyAndVisible {
    self.window.rootViewController = self.controller;
    [self.window makeKeyAndVisible];
}

@end
