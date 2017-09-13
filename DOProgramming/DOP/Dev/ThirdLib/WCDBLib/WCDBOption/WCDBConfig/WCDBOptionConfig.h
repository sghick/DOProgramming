//
//  WCDBOptionConfig.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/4/20.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCDataBase.h"
#import "WCDBParser.h"

@interface WCDBOptionConfig : NSObject

@property (nonatomic, strong) id<WCDataBaseDelegate> dbManager; ///< 基本数据库,不可空
@property (nonatomic, strong) id<WCDBParserDelegate> dbParser;  ///< 可以设置解析数据,否则将使用默认解析器

+ (instancetype)shareInstance;

@end
