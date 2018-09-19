//
//  DORoot.h
//  DOProgramming
//
//  Created by 丁治文 on 2018/9/19.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "DOPage.h"

/// 根页面协议
@protocol DORootProtocol <NSObject>

@property (strong, nonatomic) UIWindow *window;

- (void)makeKeyAndVisible;

@end

@interface DORoot : DOPage<DORootProtocol>

@end
