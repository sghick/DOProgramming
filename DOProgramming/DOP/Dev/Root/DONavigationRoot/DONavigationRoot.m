//
//  DONavigationRoot.m
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/16.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DONavigationRoot.h"

@interface DONavigationRoot ()

@end

@implementation DONavigationRoot

- (void)makeKeyAndVisibleInWindow:(UIWindow *)window {
    UIViewController *controller = [self.dobjects.lastObject featchViewControllerWithIdentifier:nil];
    UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:controller];
    window.rootViewController = root;
    [super makeKeyAndVisibleInWindow:window];
}

@end
