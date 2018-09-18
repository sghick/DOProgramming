//
//  DOTabBarRoot.m
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/16.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DOTabBarRoot.h"

@implementation DOTabBarRoot

- (void)makeKeyAndVisibleInWindow:(UIWindow *)window {
    NSMutableArray *controllers = [NSMutableArray array];
    for (id<DOProtocol> dobj in self.dobjects) {
        UIViewController *vc = [dobj featchViewControllerWithIdentifier:nil];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:nav];
    }
    UITabBarController *root = [[UITabBarController alloc] init];
    root.viewControllers = controllers;
    window.rootViewController = root;
    [super makeKeyAndVisibleInWindow:window];
}

@end
