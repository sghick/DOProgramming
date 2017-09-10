//
//  DOMainHomeController.m
//  DOProgramming
//
//  Created by 丁治文 on 2017/9/8.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import "DOMainHomeController.h"

@interface DOMainHomeController ()

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
    [self.view addSubview:self.button];
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.imageView];
}

#pragma mark - Getters

- (UITextField *)textFiled {
    if (_textFiled == nil) {
        UITextField *textFiled = [[UITextField alloc] init];
        _textFiled = textFiled;
    }
    return _textFiled;
}

- (UIButton *)button {
    if (_button == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _button = button;
    }
    return _button;
}

- (UILabel *)label {
    if (_label == nil) {
        UILabel *label = [[UILabel alloc] init];
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

@end
