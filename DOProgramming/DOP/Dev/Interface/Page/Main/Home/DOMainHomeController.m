//
//  DOMainHomeController.m
//  DOProgramming
//
//  Created by 丁治文 on 2017/9/8.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import "DOMainHomeController.h"
#import "DOMainHomeDemand.h"

@interface DOMainHomeController ()

@property (strong, nonatomic) DOMainHomeDemand *mainHomeDemand;

@end

@implementation DOMainHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Actions

#pragma mark - Getters

- (DOMainHomeDemand *)mainHomeDemand {
    if (_mainHomeDemand == nil) {
        DOMainHomeDemand *demand = [[DOMainHomeDemand alloc] init];
        _mainHomeDemand = demand;
    }
    return _mainHomeDemand;
}

@end
