//
//  DOMainHome.m
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/16.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DOMainHome.h"
#import "DOMainHomeController.h"

@implementation DOMainHome

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (UIViewController *)controller {
    DOMainHomeController *controller = [[DOMainHomeController alloc] init];
    return controller;
}

@end
