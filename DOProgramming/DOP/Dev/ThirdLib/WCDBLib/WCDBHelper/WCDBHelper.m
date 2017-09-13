//
//  WCDBHelper.m
//  WCDBLib
//
//  Created by WuBo on 16/3/31.
//  Copyright © 2016年 WeiChe. All rights reserved.
//

#import "WCDBHelper.h"
#import "WCDBGroupOption.h"
#import "WCDBSqlOption.h"
#import "WCDBInsertOption.h"
#import "WCDBDeleteOption.h"
#import "WCDBUpdateOption.h"
#import "WCDBSelectOption.h"
#import "WCDBUtilOption.h"

NSString * const kDBTableName = @":class_model";

// 此model为专门存储key-value形式
NSString * const kConfigTableName = @"__config";
@interface WCDBHelper_Config : NSObject

@property (copy , nonatomic) NSString   *key;
@property (copy , nonatomic) NSString   *value;
@property (copy , nonatomic) NSString   *valueClass;

@end

@implementation WCDBHelper_Config

@end

@implementation WCDBHelper

#pragma mark - Select Operations

+ (NSArray *)selectItemsFromConfigTableByKey:(NSString *)key {
    if (key == nil || key.length <= 0) {
        return nil;
    }
    
    WCDBSelectOption *option = [[WCDBSelectOption alloc] initWithTableName:kConfigTableName];
    option.modelClass = [WCDBHelper_Config class];
    option.where = @"WHERE key LIKE (?)";
    option.paramsArray = @[key];
    NSMutableArray *result = [NSMutableArray array];
    NSArray *queryResult = [option query];
    for (WCDBHelper_Config *config in queryResult) {
        if (config.value) {
            [result addObject:config.value];
            /*
            NSError *err;
            id obj = [NSJSONSerialization JSONObjectWithData:config.value options:NSJSONReadingMutableContainers error:&err];
            if (obj && config.valueClass && (config.valueClass.length > 0)) {
                id value = [option parserResultsToModel:@[config.value] withModelClass:NSClassFromString(config.valueClass)];
                [result addObject:value?value:config.value];
            } else {
                [result addObject:config.value];
            }
             */
        }
    }
    return [result copy];
}

+ (NSArray *)selectAllItemsByModelClass:(Class)modelClass {
    if (modelClass == nil) {
        return nil;
    }
    NSArray *result = nil;
    WCDBSelectOption *option = [[WCDBSelectOption alloc] initWithModelClass:modelClass];
    result = [option query];
    return result;
}

+ (NSArray *)selectItemsBySQL:(NSString *)sql
                       params:(NSArray *)params
                andModelClass:(Class)modelClass {
    if (!sql || !sql.length) {
        return nil;
    }
    WCDBSqlOption *option = [[WCDBSqlOption alloc] init];
    option.sql = [self sqlForTableNameFilterReplaceOriginalSQL:sql
                                                  byModelClass:modelClass];
    option.paramsArray = params;
    NSArray *result = [option query];
    result = [option parserResultsToModel:result withModelClass:modelClass];
    return result;
}

#pragma mark - Insert Operations

+ (BOOL)insertOrReplaceItemToConfigTableByKey:(NSString *)key
                                     andValue:(NSString *)value {
    if (key == nil || key.length <= 0) {
        return NO;
    }
    
    if (value == nil) {
        return NO;
    }
    
    WCDBHelper_Config *config = [[WCDBHelper_Config alloc] init];
    config.key = key;
    config.value = value;
    config.valueClass = NSStringFromClass([value class]);
    WCDBInsertOption *option = [[WCDBInsertOption alloc] initWithObjects:@[config]];
    option.tableName = kConfigTableName;
    option.primaryKeys = @[@"key"];
    return [option excute];
}

+ (int)insertOrReplaceItemByDBModel:(WCDBModel *)model {
    if (model == nil || model.objects == nil || model.objects.count == 0) {
        return 0;
    }
    
    WCDBInsertOption *option = [[WCDBInsertOption alloc] initWithObjects:model.objects];
    option.primaryKeys = model.keys;
    return [option excute];
}

#pragma mark - Update Operations

+ (BOOL)updateItemsBySQL:(NSString *)sql
                  params:(NSArray *)params
           andModelClass:(Class)modelClass {
    if (sql == nil || sql.length <= 0) {
        return NO;
    }
    
    WCDBSqlOption *option = [[WCDBSqlOption alloc] init];
    option.sql = [self sqlForTableNameFilterReplaceOriginalSQL:sql
                                                  byModelClass:modelClass];
    option.paramsArray = params;
    return [option excute];
}

#pragma mark - Delete Operations

+ (BOOL)deleteItemsFromConfigTableByKey:(NSString *)key {
    if (key == nil || key.length <= 0) {
        return NO;
    }
    
    WCDBDeleteOption *option = [[WCDBDeleteOption alloc] initWithTableName:kConfigTableName];
    option.modelClass = [WCDBHelper_Config class];
    option.where = @"WHERE key LIKE (?)";
    option.paramsArray = @[key];
    return [option excute];
}

+ (BOOL)deleteAllItemsByModelClass:(Class)modelClass {
    if (modelClass == nil) {
        return NO;
    }
    
    WCDBDeleteOption *option = [[WCDBDeleteOption alloc] initWithModelClass:modelClass];
    return [option excute];
}

+ (BOOL)deleteItemBySQL:(NSString *)sql
                 params:(NSArray *)params
          andModelClass:(Class)modelClass {
    if (sql == nil || sql.length <= 0) {
        return NO;
    }
    
    WCDBSqlOption *option = [[WCDBSqlOption alloc] init];
    option.sql = [self sqlForTableNameFilterReplaceOriginalSQL:sql
                                                  byModelClass:modelClass];
    option.paramsArray = params;
    return [option excute];
}

#pragma mark - Table Utils

// private
+ (NSString *)sqlForTableNameFilterReplaceOriginalSQL:(NSString *)originalSQL byModelClass:(Class)modelClass {
    NSString *sql = @"";
    if (modelClass != nil) {
        NSRange filterRange = [originalSQL rangeOfString:kDBTableName];
        NSString *tableName = [self tableNameFromModelClass:modelClass];
        if (filterRange.location != NSNotFound) {
            sql = [originalSQL stringByReplacingOccurrencesOfString:kDBTableName withString:tableName];
        } else {
            sql = originalSQL;
        }
    } else {
        sql = originalSQL;
    }
    return sql;
}

#pragma mark - Table Utils

+ (BOOL)ifTableExistWithName:(NSString *)tableName {
    return [WCDBUtilOption ifTableExistWithName:tableName];
}

+ (BOOL)dropTableWithName:(NSString *)tableName {
    return [WCDBUtilOption dropTableWithName:tableName];
}

+ (NSArray *)selectExistedTablesNames {
    return [WCDBUtilOption selectExistedTablesNames];
}

+ (BOOL)deleteAllTablesData {
    return [WCDBUtilOption deleteAllTablesData];
}

+ (NSString *)tableNameFromModelClass:(Class)modelClass {
    return NSStringFromClass(modelClass);
}

@end
