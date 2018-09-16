//
//  DOTabBarRoot.m
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/16.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DOTabBarRoot.h"

@interface DOTabBarRoot ()

@property (strong, nonatomic) NSMutableArray *rootDObects;

@end

@implementation DOTabBarRoot

- (void)makeKeyAndVisibleInWindow:(UIWindow *)window {
    NSMutableArray *controllers = [NSMutableArray array];
    for (id<DOProtocol> dobj in self.rootDObects) {
        UIViewController *vc = [dobj featchViewControllerWithIdentifier:nil];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:nav];
    }
    UITabBarController *root = [[UITabBarController alloc] init];
    root.viewControllers = controllers;
    window.rootViewController = root;
    [super makeKeyAndVisibleInWindow:window];
}

- (void)addDObject:(id<DOProtocol>)dobject {
    if (!dobject) {
        return;
    }
    [self.rootDObects addObject:dobject];;
}

- (void)resetRoot {
    _rootDObects = nil;
}

- (NSMutableArray *)rootDObects {
    if (!_rootDObects) {
        _rootDObects = [NSMutableArray array];
    }
    return _rootDObects;
}

@end
