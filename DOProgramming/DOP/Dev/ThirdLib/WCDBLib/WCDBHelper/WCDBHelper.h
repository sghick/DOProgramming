//
//  WCDBHelper.h
//  WCDBLib
//
//  Created by WuBo on 16/3/31.
//  Copyright © 2016年 WeiChe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "FMDB.h"
#import "WCDBModel.h"

extern NSString * const kDBTableName;

@interface WCDBHelper : NSObject

#pragma mark - Select Operations

/**
 *  根据Key值从__config表中查询记录
 *
 *  @param key        key值，基本规则为:"父对象_id.字段名", key支持通配符%
 *
 *  @return 返回查询结果列表，列表中为单个插入的数据类型，字段名为key值
 */
+ (NSArray *)selectItemsFromConfigTableByKey:(NSString *)key;

/**
 *  根据Model的类查询对应表中的所有记录
 *
 *  @param modelClass 要查询Model对象的类，主要用来找到对应的表
 *
 *  @return 返回查询结果列表，列表中为Dictionary，字段名为key值
 */
+ (NSArray *)selectAllItemsByModelClass:(Class)modelClass;

/**
 *  根据Model的类查询对应表中满足查询条件的所有记录，注意SQL中的表名，使用":class_model"代替，当ModelClass传nil时直接返回字典对象，不为Nil时则解析为对应的对象类型
 *
 *  @param sql        查询的SQL语句
 *  @param params     参数列表
 *  @param modelClass 要查询Model对象的类，主要用来找到对应的表
 *
 *  @return 返回查询结果列表，列表中为Dictionary，字段名为key值
 */
+ (NSArray *)selectItemsBySQL:(NSString *)sql
                       params:(NSArray *)params
                andModelClass:(Class)modelClass;

#pragma mark - Insert Operations

/**
 *  插入或替换__config表中的记录，如果是相同key值，其对应数据会被替换，不存在key会插入
 *
 *  @param key   记录的key值，也是主键, key支持通配符%
 *  @param value 插入或替换的数据，只支持文本
 *
 *  @return 返回插入结果，成功为YES，失败为NO
 */
+ (BOOL)insertOrReplaceItemToConfigTableByKey:(NSString *)key
                                     andValue:(NSString *)value;

/**
 *  插入或替换Model对应表的记录,插入时需要用WCDBModel进行一次封装，约定好主键
 *
 *  @param model 用来封装的model对象，包括要插入的model对象和主键
 *
 *  @return 返回插入结果，当结果与model.objects.count相等的时候代表所有对象都插入成功，失败则返回0
 */
+ (int)insertOrReplaceItemByDBModel:(WCDBModel *)model;


#pragma mark - Update Operations

/**
 *  执行更新SQL，注意SQL中的表名，使用":class_model"代替
 *
 *  @param sql          Update SQL语句
 *  @param params       参数列表
 *  @param modelClass   model对象对应的类
 *
 *  @return 返回更新结果，成功为YES，失败为NO
 */
+ (BOOL)updateItemsBySQL:(NSString *)sql
                  params:(NSArray *)params
           andModelClass:(Class)modelClass;

#pragma mark - Delete Operations

/**
 *  从__config表中删除记录
 *
 *  @param key key值, key支持通配符%
 *
 *  @return 返回删除结果，成功为YES， 失败为NO
 */
+ (BOOL)deleteItemsFromConfigTableByKey:(NSString *)key;

/**
 *  从Model对应的表中删除所有记录
 *
 *  @param modelClass Model对象对应的类
 *
 *  @return 返回删除结果，成功为YES， 失败为NO
 */
+ (BOOL)deleteAllItemsByModelClass:(Class)modelClass;

/**
 *  通过执行SQL语句删除记录
 *
 *  @param sql        SQL语句
 *  @param params     参数列表
 *  @param modleClass Model对象对应的类
 *
 *  @return 返回删除结果，成功为YES， 失败为NO
 */
+ (BOOL)deleteItemBySQL:(NSString *)sql
                 params:(NSArray *)params
          andModelClass:(Class)modelClass;

#pragma mark - Table Utils

/**
 *  根据表名判断是否已经在数据库中存在此表
 *
 *  @param tableName 表名
 *
 *  @return 如果存在返回YES，不存在返回NO
 */
+ (BOOL)ifTableExistWithName:(NSString *)tableName;

/**
 *  根据表名删除表
 *
 *  @param tableName 表名
 *
 *  @return 删除成功返回YES，失败返回NO
 */
+ (BOOL)dropTableWithName:(NSString *)tableName;

/**
 *  查询当前数据库中已经存在的表名称
 *
 *  @return 返回结果列表
 */
+ (NSArray *)selectExistedTablesNames;

/**
 *  慎用，此方法会删除所有表的记录
 *
 *  @return 返回删除结果，成功为YES， 失败为NO
 */
+ (BOOL)deleteAllTablesData;

/**
 *  根据Model类得到对应的表名
 *
 *  @param modelClass Model对象对应的类
 *
 *  @return 返回对应的表名
 */
+ (NSString *)tableNameFromModelClass:(Class)modelClass;

@end
