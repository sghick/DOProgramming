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

- (UIViewController *)featchViewControllerWithIdentifier:(NSString *)identifier {
    DOMainHomeController *controller = [[DOMainHomeController alloc] init];
    return controller;
}

@end
