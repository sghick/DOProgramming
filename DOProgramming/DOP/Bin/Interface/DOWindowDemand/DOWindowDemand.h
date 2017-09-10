//
//  DOWindowDemand.h
//  DOProgramming
//
//  Created by 丁治文 on 17/9/9.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import "DOObject.h"
#import <UIKit/UIKit.h>

@interface DOWindowDemand : DOObject

@property (weak  , nonatomic, readonly) UIWindow *window;

- (instancetype)initWithWindow:(UIWindow *)window;

@end
