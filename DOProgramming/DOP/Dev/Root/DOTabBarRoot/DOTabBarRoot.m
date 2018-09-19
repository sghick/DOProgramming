//
//  DOTabBarRoot.m
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/16.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DOTabBarRoot.h"

@implementation DOTabBarRoot

- (UIViewController *)controller {
    if (![super controller]) {
        NSMutableArray *controllers = [NSMutableArray array];
        for (DOPage *dobj in self.dobjectMappers.allValues) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dobj.controller];
            [controllers addObject:nav];
        }
        UITabBarController *root = [[UITabBarController alloc] init];
        root.viewControllers = controllers;
        [super setController:root];
        return root;
    }
    return [super controller];
}

@end
