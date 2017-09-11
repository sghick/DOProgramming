//
//  DOMainHomeDemand.m
//  DOProgramming
//
//  Created by 丁治文 on 2017/9/8.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import "DOMainHomeDemand.h"
#import "DOMainHomeController.h"

@implementation DOMainHomeDemand

// auto created
- (Class)classOfController {
    return [DOMainHomeController class];
}

- (void)respondsButton:(UIButton *)button textFiled:(UITextField *)textFiled label:(UILabel *)label imageView:(UIImageView *)imageView {
    NSString *input = textFiled.text;
    textFiled.placeholder = @"请输入内容";
    if (!input) {
        label.text = @"请输入内容";
        [textFiled becomeFirstResponder];
        return;
    } else {
        label.text = input;
        NSString *imagePath = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4161690382,602654580&fm=27&gp=0.jpg";
        dispatch_async(dispatch_queue_create("cn.com.test.demand.dop", NULL), ^{
            NSError *error = [[NSError alloc] init];
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath] options:NSDataReadingUncached error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = [UIImage imageWithData:imgData];
            });
        });
    }
}

@end
