//
//  NSObject+WCDB.h
//  LotteryTry
//
//  Created by 丁治文 on 2017/5/10.
//  Copyright © 2017年 丁治文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WCDB)

#pragma mark - DefaultTableName
+ (NSString *)tableName;

+ (BOOL)insertOrReplace:(NSArray *)objs;
+ (BOOL)insertOrReplace:(NSArray *)objs generalParam:(NSDictionary *)generalParam;
+ (BOOL)insertOrReplace:(NSArray *)objs primaryKeys:(NSArray *)primaryKeys;
+ (BOOL)insertOrReplace:(NSArray *)objs generalParam:(NSDictionary *)generalParam primaryKeys:(NSArray *)primaryKeys;

+ (NSArray *)selectAll;
+ (NSArray *)selectWhere:(NSString *)where;
+ (NSArray *)selectWhere:(NSString *)where paramsArray:(NSArray *)params;
+ (__kindof NSObject *)selectFirstObjectWhere:(NSString *)where;
+ (__kindof NSObject *)selectFirstObjectWhere:(NSString *)where paramsArray:(NSArray *)params;
+ (NSArray *)selectSql:(NSString *)sql paramsArray:(NSArray *)params;

+ (BOOL)update:(NSObject *)obj where:(NSString *)where;

+ (BOOL)deleteAll;
+ (BOOL)deleteWhere:(NSString *)where;
+ (BOOL)deleteWhere:(NSString *)where paramsArray:(NSArray *)params;

#pragma mark - OtherTableName
+ (BOOL)insertOrReplace:(NSArray *)objs fromTable:(NSString *)tableName;
+ (BOOL)insertOrReplace:(NSArray *)objs generalParam:(NSDictionary *)generalParam fromTable:(NSString *)tableName;
+ (BOOL)insertOrReplace:(NSArray *)objs primaryKeys:(NSArray *)primaryKeys fromTable:(NSString *)tableName;
+ (BOOL)insertOrReplace:(NSArray *)objs generalParam:(NSDictionary *)generalParam primaryKeys:(NSArray *)primaryKeys fromTable:(NSString *)tableName;
+ (BOOL)insertOrIgnore:(NSArray *)objs generalParam:(NSDictionary *)generalParam primaryKeys:(NSArray *)primaryKeys fromTable:(NSString *)tableName;

+ (NSArray *)selectAllFromTable:(NSString *)tableName;
+ (NSArray *)selectWhere:(NSString *)where fromTable:(NSString *)tableName;
+ (NSArray *)selectWhere:(NSString *)where paramsArray:(NSArray *)params fromTable:(NSString *)tableName;
+ (__kindof NSObject *)selectFirstObjectWhere:(NSString *)where fromTable:(NSString *)tableName;
+ (__kindof NSObject *)selectFirstObjectWhere:(NSString *)where paramsArray:(NSArray *)params fromTable:(NSString *)tableName;
+ (NSArray *)selectSql:(NSString *)sql paramsArray:(NSArray *)params fromTable:(NSString *)tableName;

+ (BOOL)update:(NSObject *)obj where:(NSString *)where fromTable:(NSString *)tableName;

+ (BOOL)deleteAllFromTable:(NSString *)tableName;
+ (BOOL)deleteWhere:(NSString *)where fromTable:(NSString *)tableName;
+ (BOOL)deleteWhere:(NSString *)where paramsArray:(NSArray *)params fromTable:(NSString *)tableName;

@end
