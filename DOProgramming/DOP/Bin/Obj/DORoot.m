//
//  DORoot.m
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/16.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DORoot.h"

@implementation DORoot

- (void)makeKeyAndVisibleInWindow:(UIWindow *)window {
    if (!window || ![window isKindOfClass:[UIWindow class]]) {
        return;
    }
    [window makeKeyAndVisible];
}

@end
