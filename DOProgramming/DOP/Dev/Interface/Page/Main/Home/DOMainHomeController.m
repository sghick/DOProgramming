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

@property (strong, nonatomic) UITextField *textFiled;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation DOMainHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textFiled];
    [self.view addSubview:self.label];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.button];
    
    self.textFiled.frame = CGRectMake(50, 100, 300, 100);
    self.label.frame = CGRectMake(50, 200, 300, 100);
    self.imageView.frame = CGRectMake(50, 300, 150, 150);
    self.button.frame = CGRectMake(50, 450, 300, 100);
}

#pragma mark - Actions

- (void)buttonAction:(UIButton *)button {
    [self.mainHomeDemand respondsButton:button textFiled:self.textFiled label:self.label imageView:self.imageView];
}

#pragma mark - Getters

- (UITextField *)textFiled {
    if (_textFiled == nil) {
        UITextField *textFiled = [[UITextField alloc] init];
        textFiled.layer.borderColor = [UIColor blackColor].CGColor;
        textFiled.layer.cornerRadius = 5;
        textFiled.layer.borderWidth = 1;
        _textFiled = textFiled;
    }
    return _textFiled;
}

- (UIButton *)button {
    if (_button == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor greenColor];
        [button setTitle:@"获取网络图片" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _button = button;
    }
    return _button;
}

- (UILabel *)label {
    if (_label == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        _label = label;
    }
    return _label;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
    }
    return _imageView;
}

- (DOMainHomeDemand *)mainHomeDemand {
    if (_mainHomeDemand == nil) {
        DOMainHomeDemand *demand = [[DOMainHomeDemand alloc] init];
        _mainHomeDemand = demand;
    }
    return _mainHomeDemand;
}

@end
