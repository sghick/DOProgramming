//
//  WCDBSqlOption.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/20.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBOption.h"

@interface WCDBSqlOption : WCDBOption

/**
 sql语句
 */
@property (copy  , nonatomic) NSString  *sql;

/**
 Optional,sql语句中的sql参数,如果paramsArray==nil,使用paramsDict参数
 */
@property (copy  , nonatomic) NSDictionary *paramsDict;

/**
 Optional,sql语句中的sql参数,如果paramsArray!=nil,使用paramsArray参数
 */
@property (copy  , nonatomic) NSArray *paramsArray;

@end
