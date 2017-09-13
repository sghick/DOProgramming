//
//  FZRefreshCircleAnimateHeader.h
//  MJRefreshExample
//
//  Created by FangZhou on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "FZRefreshCircleAnimateHeader.h"

@implementation FZRefreshCircleAnimateHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    // 设置高度
    self.mj_h = [FZRefreshCircleAnimateHeader maxHeaderHeight];
}

+ (CGFloat)maxHeaderHeight {
    return 85;
}

@end
