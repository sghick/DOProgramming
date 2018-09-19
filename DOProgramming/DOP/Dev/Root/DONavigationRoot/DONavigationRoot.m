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

- (UIViewController *)controller {
    if (![super controller]) {
        UIViewController *controller = [(DOPage *)self.dobjectMappers.allValues.lastObject controller];
        UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:controller];
        [super setController:root];
        return root;
    }
    return [super controller];
}

@end
