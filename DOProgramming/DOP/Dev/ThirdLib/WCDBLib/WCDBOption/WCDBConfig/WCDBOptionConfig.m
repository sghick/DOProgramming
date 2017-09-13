//
//  WCDBOptionConfig.m
//  WCDBLib
//
//  Created by 丁治文 on 2017/4/20.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBOptionConfig.h"

@implementation WCDBOptionConfig

static WCDBOptionConfig *_shareDBOptionConfig;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        WCDBParser *parser = [[WCDBParser alloc] init];
        _shareDBOptionConfig = [[WCDBOptionConfig alloc] init];
        _shareDBOptionConfig.dbParser = parser;
    });
    return _shareDBOptionConfig;
}

@end
