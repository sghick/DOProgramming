//
//  DONavigationDemand.m
//  DOProgramming
//
//  Created by 丁治文 on 17/9/9.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import "DONavigationDemand.h"
#import "DOMainHomeDemand.h"

@implementation DONavigationDemand

- (DOResponse *)excuteWithTarget:(DOObject *)target {
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBar;
    
    // custom
    DOMainHomeDemand *mainHome = [[DOMainHomeDemand alloc] init];
    UIViewController *mainHomeVC = [[[mainHome classOfController] alloc] init];
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:mainHomeVC];
    tabBar.viewControllers = @[navHome];
    
    [self.window makeKeyAndVisible];
    return nil;
}

@end
