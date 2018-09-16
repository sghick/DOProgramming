//
//  DONavigationRoot.m
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/16.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DONavigationRoot.h"

@interface DONavigationRoot ()

@property (strong, nonatomic) DORoot *rootDObject;

@end

@implementation DONavigationRoot

- (void)makeKeyAndVisibleInWindow:(UIWindow *)window {
    UIViewController *controller = [self.rootDObject featchViewControllerWithIdentifier:nil];
    UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:controller];
    window.rootViewController = root;
    [super makeKeyAndVisibleInWindow:window];
}

- (void)addDObject:(id<DOProtocol>)dobject {
    _rootDObject = dobject;
}

@end
