//
//  DONavigationViewDemand.m
//  DOProgramming
//
//  Created by 丁治文 on 2017/9/8.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import "DONavigationViewDemand.h"
#import "DOMainHomeDemand.h"

@interface DONavigationViewDemand ()

@end

@implementation DONavigationViewDemand

- (DOResponse *)excuteWithTarget:(DOObject *)target {
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBar;
    
    UIViewController *mainHome = [DOMainHomeDemand viewController];
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:mainHome];
    
    tabBar.viewControllers = @[navHome];
    
    [self.window makeKeyAndVisible];
    return nil;
}

@end
