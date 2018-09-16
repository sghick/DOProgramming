//
//  DOMainMe.m
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/16.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DOMainMe.h"
#import "DOMainMeController.h"

@implementation DOMainMe

- (UIViewController *)featchViewControllerWithIdentifier:(NSString *)identifier {
    DOMainMeController *controller = [[DOMainMeController alloc] init];
    return controller;
}

@end
