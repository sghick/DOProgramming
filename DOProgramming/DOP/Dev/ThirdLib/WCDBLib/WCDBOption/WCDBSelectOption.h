//
//  WCDBSelectOption.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/17.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBOption.h"

@interface WCDBSelectOption : WCDBOption

/**
 Optional,表名
 default:NSStringFromClass(modelClass)
 */
@property (copy  , nonatomic) NSString  *tableName;

/**
 Optional,类名,指定查询的表名
 default:nil
 如果modelClass没有值,查询结果将返回一个字典
 */
@property (assign, nonatomic) Class     modelClass;

/**
 Optional,查询结果中处理成对象的子对象映射
 default:nil
 */
@property (copy  , nonatomic) NSArray   *classMappers;

/**
 Optional,为sql添加条件
 default:nil
 如:
 where ...
 limit ...
 order by ...
 参数写成 key=:keyname,并在params中传入
 */
@property (copy  , nonatomic) NSString  *where;

/**
 Optional,sql语句中的sql参数,如果paramsArray==nil,使用paramsDict参数
 */
@property (copy  , nonatomic) NSDictionary *paramsDict;

/**
 Optional,sql语句中的sql参数,如果paramsArray!=nil,使用paramsArray参数
 */
@property (copy  , nonatomic) NSArray *paramsArray;


/**
 初始化方法

 @param modelClass 查询结果的类或表名
 @return SelectOption
 */
- (instancetype)initWithModelClass:(Class)modelClass;

/**
 初始化方法

 @param tableName 查询的表名
 @return SelectOption
 */
- (instancetype)initWithTableName:(NSString *)tableName;

@end
