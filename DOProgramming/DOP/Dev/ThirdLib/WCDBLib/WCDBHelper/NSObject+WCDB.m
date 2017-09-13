//
//  NSObject+WCDB.m
//  LotteryTry
//
//  Created by 丁治文 on 2017/5/10.
//  Copyright © 2017年 丁治文. All rights reserved.
//

#import "NSObject+WCDB.h"
#import "WCDBOptionConfig.h"
#import "WCDBGroupOption.h"
#import "WCDBSqlOption.h"
#import "WCDBInsertOption.h"
#import "WCDBDeleteOption.h"
#import "WCDBUpdateOption.h"
#import "WCDBSelectOption.h"

@implementation NSObject (WCDB)

#pragma mark - DefaultTableName
+ (NSString *)tableName {
    return NSStringFromClass([self class]);
}

+ (BOOL)insertOrReplace:(NSArray *)objs {
    return [self insertOrReplace:objs fromTable:[self tableName]];
}
+ (BOOL)insertOrReplace:(NSArray *)objs generalParam:(NSDictionary *)generalParam {
    return [self insertOrReplace:objs fromTable:[self tableName]];
}
+ (BOOL)insertOrReplace:(NSArray *)objs primaryKeys:(NSArray *)primaryKeys {
    return [self insertOrReplace:objs primaryKeys:primaryKeys fromTable:[self tableName]];
}
+ (BOOL)insertOrReplace:(NSArray *)objs generalParam:(NSDictionary *)generalParam primaryKeys:(NSArray *)primaryKeys {
    return [self insertOrReplace:objs generalParam:generalParam primaryKeys:primaryKeys fromTable:[self tableName]];
}

+ (NSArray *)selectAll {
    return [self selectAllFromTable:[self tableName]];
}
+ (NSArray *)selectWhere:(NSString *)where {
    return [self selectWhere:where fromTable:[self tableName]];
}
+ (NSArray *)selectWhere:(NSString *)where paramsArray:(NSArray *)params {
    return [self selectWhere:where paramsArray:params fromTable:[self tableName]];
}
+ (__kindof NSObject *)selectFirstObjectWhere:(NSString *)where {
    return [self selectFirstObjectWhere:where fromTable:[self tableName]];
}
+ (__kindof NSObject *)selectFirstObjectWhere:(NSString *)where paramsArray:(NSArray *)params {
    return [self selectFirstObjectWhere:where paramsArray:params fromTable:[self tableName]];
}
+ (NSArray *)selectSql:(NSString *)sql paramsArray:(NSArray *)params {
    return [self selectSql:sql paramsArray:params fromTable:[self tableName]];
}

+ (BOOL)update:(NSObject *)obj where:(NSString *)where {
    return [self update:obj where:where fromTable:[self tableName]];
}

+ (BOOL)deleteAll {
    return [self deleteAllFromTable:[self tableName]];
}
+ (BOOL)deleteWhere:(NSString *)where {
    return [self deleteWhere:where fromTable:[self tableName]];
}
+ (BOOL)deleteWhere:(NSString *)where paramsArray:(NSArray *)params {
    return [self deleteWhere:where paramsArray:params fromTable:[self tableName]];
}

#pragma mark - OtherTableName

+ (BOOL)insertOrReplace:(NSArray *)objs fromTable:(NSString *)tableName {
    return [self insertOrReplace:objs generalParam:nil primaryKeys:nil fromTable:tableName];
}
+ (BOOL)insertOrReplace:(NSArray *)objs generalParam:(NSDictionary *)generalParam fromTable:(NSString *)tableName {
    return [self insertOrReplace:objs generalParam:generalParam primaryKeys:nil fromTable:tableName];
}
+ (BOOL)insertOrReplace:(NSArray *)objs primaryKeys:(NSArray *)primaryKeys fromTable:(NSString *)tableName {
    return [self insertOrReplace:objs generalParam:nil primaryKeys:primaryKeys fromTable:tableName];
}
/**
 插入数据

 @param objs 数据源
 @param generalParam 每条数据共同的参数(有则替换)
 @param primaryKeys 主键
 @param tableName 表名
 @return 插入成功
 */
+ (BOOL)insertOrReplace:(NSArray *)objs generalParam:(NSDictionary *)generalParam primaryKeys:(NSArray *)primaryKeys fromTable:(NSString *)tableName {
    WCDBInsertOption *option = [[WCDBInsertOption alloc] initWithObjects:objs];
    option.tableName = tableName;
    option.primaryKeys = primaryKeys;
    option.generalParam = generalParam;
    return [option excute];
}
+ (BOOL)insertOrIgnore:(NSArray *)objs generalParam:(NSDictionary *)generalParam primaryKeys:(NSArray *)primaryKeys fromTable:(NSString *)tableName {
    WCDBInsertOption *option = [[WCDBInsertOption alloc] initWithObjects:objs];
    option.insertType = WCDBInsertOptionTypeInsertOrIgnore;
    option.tableName = tableName;
    option.primaryKeys = primaryKeys;
    option.generalParam = generalParam;
    return [option excute];
}

+ (NSArray *)selectAllFromTable:(NSString *)tableName {
    return [self selectWhere:nil fromTable:tableName];
}
+ (NSArray *)selectWhere:(NSString *)where fromTable:(NSString *)tableName {
    return [self selectWhere:where paramsArray:nil fromTable:tableName];
}
+ (NSArray *)selectWhere:(NSString *)where paramsArray:(NSArray *)params fromTable:(NSString *)tableName {
    WCDBSelectOption *option = [[WCDBSelectOption alloc] initWithModelClass:[self class]];
    option.tableName = tableName;
    option.where = where;
    option.paramsArray = params;
    return [option query];
}
+ (__kindof NSObject *)selectFirstObjectWhere:(NSString *)where fromTable:(NSString *)tableName {
    return [self selectFirstObjectWhere:where paramsArray:nil fromTable:tableName];
}
+ (__kindof NSObject *)selectFirstObjectWhere:(NSString *)where paramsArray:(NSArray *)params fromTable:(NSString *)tableName {
    return [self selectWhere:where paramsArray:params fromTable:tableName].firstObject;
}
+ (NSArray *)selectSql:(NSString *)sql paramsArray:(NSArray *)params fromTable:(NSString *)tableName {
    WCDBSqlOption *option = [[WCDBSqlOption alloc] init];
    option.sql = sql;
    option.paramsArray = params;
    NSArray *results = [option query];
    return [option parserResultsToModel:results withModelClass:[self class]];
}

+ (BOOL)update:(NSObject *)obj where:(NSString *)where fromTable:(NSString *)tableName {
    WCDBUpdateOption *option = [[WCDBUpdateOption alloc] initWithObject:obj];
    option.tableName = tableName;
    option.where = where;
    return [option excute];
}

+ (BOOL)deleteAllFromTable:(NSString *)tableName {
    return [self deleteWhere:nil fromTable:tableName];
}
+ (BOOL)deleteWhere:(NSString *)where fromTable:(NSString *)tableName {
    return [self deleteWhere:where paramsArray:nil fromTable:tableName];
}
+ (BOOL)deleteWhere:(NSString *)where paramsArray:(NSArray *)params fromTable:(NSString *)tableName {
    WCDBDeleteOption *option = [[WCDBDeleteOption alloc] initWithModelClass:[self class]];
    option.tableName = tableName;
    option.where = where;
    option.paramsArray = params;
    return [option excute];
}

@end
