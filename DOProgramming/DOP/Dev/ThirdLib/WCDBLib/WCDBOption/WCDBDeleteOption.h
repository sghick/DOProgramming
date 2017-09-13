//
//  WCDBDeleteOption.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/17.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBOption.h"

@interface WCDBDeleteOption : WCDBOption

/**
 Optional,表名
 default:NSStringFromClass(modelClass)
 */
@property (copy  , nonatomic) NSString  *tableName;

/**
 Optional,类名,指定删除的表名
 default:NULL
 */
@property (assign, nonatomic) Class     modelClass;

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
 
 @param modelClass 要删除的类/表名
 @return DeleteOption
 */
- (instancetype)initWithModelClass:(Class)modelClass;

/**
 初始化方法
 
 @param tableName 要删除的表名
 @return DeleteOption
 */
- (instancetype)initWithTableName:(NSString *)tableName;

@end
