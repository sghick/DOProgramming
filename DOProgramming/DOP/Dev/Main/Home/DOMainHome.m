//
//  DOMainHome.m
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/16.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DOMainHome.h"
#import "DOMainHomeController.h"
#import "DOMainView.h"
#import "DOMainData.h"
#import "DOMainResponse.h"

@implementation DOMainHome

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addDObject:[DOMainView demand]];
        [self addDObject:[DOMainData demand]];
        [self addDObject:[DOMainResponse demand]];
    }
    return self;
}

- (UIViewController *)featchViewControllerWithIdentifier:(NSString *)identifier {
    DOMainHomeController *controller = [[DOMainHomeController alloc] init];
    return controller;
}

@end
