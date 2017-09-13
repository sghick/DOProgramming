//
//  WCDBInsertOption.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/17.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBOption.h"

typedef NS_ENUM(NSInteger, WCDBInsertOptionType) {
    WCDBInsertOptionTypeInsert,             // 普通插入
    WCDBInsertOptionTypeInsertOrReplace,    // 需要结合主键，如果不存在就插入，存在就更新 (default)
    WCDBInsertOptionTypeInsertOrIgnore,     // 需要结合主键，如果不存在就插入，存在就忽略
};

@interface WCDBInsertOption : WCDBOption

/**
 Optional,表名
 default:objs.firstObject.class
 */
@property (copy  , nonatomic) NSString  *tableName;

/**
 Optional,创建表时指定的主键
 default:nil
 */
@property (strong, nonatomic) NSArray   *primaryKeys;

/**
 要被插入的数据源
 */
@property (strong, nonatomic) NSArray   *objects;

/**
 通用参数,每条数据的相应字段都使用相同的值,格式为:@{param1:value1, param2:value2}
 如果没有相应字段,则无效
 */
@property (strong, nonatomic) NSDictionary  *generalParam;

/**
 Optional,插入操作类型
 default:WCDBInsertOptionTypeInsertOrReplace
 */
@property (assign, nonatomic) WCDBInsertOptionType insertType;

/**
 初始化方法

 @param objs 要插入的models
 @return InsertOption对象
 */
- (instancetype)initWithObjects:(NSArray *)objs;

@end
