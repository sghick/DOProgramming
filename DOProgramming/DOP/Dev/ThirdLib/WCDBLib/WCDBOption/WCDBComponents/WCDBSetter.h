//
//  WCDBSetter.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/3.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCDBColumn.h"

@interface WCDBSetter : NSObject

@property (nonatomic, strong, readonly) NSString *table_description;
@property (nonatomic, strong, readonly) NSArray *all_column_names;
@property (nonatomic, strong) NSString *table_name;
@property (nonatomic, strong) NSArray *primaryKeys;
@property (nonatomic, strong) NSArray<WCDBColumn *> *columns;

#pragma mark - Init
+ (WCDBSetter *)dbSetterWithClass:(Class)cls;
+ (WCDBSetter *)dbSetterWithTableName:(NSString *)tableName;
+ (WCDBSetter *)dbSetterWithClass:(Class)cls tableName:(NSString *)tableName;
+ (WCDBSetter *)dbSetterWithClass:(Class)cls tableName:(NSString *)tableName primaryKeys:(NSArray *)primaryKeys;

#pragma mark - Utls
- (BOOL)isEqualToDBSetter:(WCDBSetter *)dbSetter;
- (BOOL)isEqualTableNameToDBSetter:(WCDBSetter *)dbSetter;
- (BOOL)isEqualPrimaryKeyToDBSetter:(WCDBSetter *)dbSetter;
- (BOOL)isEqualColumnsToDBSetter:(WCDBSetter *)dbSetter;
- (BOOL)containsForColumnName:(NSString *)name;
- (BOOL)containsForColumn:(WCDBColumn *)colm;
- (void)setNeedsResetTableDescription;
- (void)setNeedsResetTableColumnNames;
- (WCDBColumn *)columnWithColumnName:(NSString *)name;
- (void)addDBColumnTypeSymbol:(NSString *)columnName dbType:(NSString *)dbType;
- (NSDictionary *)columnsOfDictionary;
+ (NSArray<WCDBColumn *> *)columnsWithClass:(Class)cls;

#pragma mark - Override
- (NSString *)description;

#pragma mark - SqlUtils
- (NSString *)sqlForDropTable;
- (NSString *)sqlForCreateTable;
- (NSString *)sqlForInsert;
- (NSString *)sqlForInsertOrReplace;
- (NSString *)sqlForInsertOrIgnore;
- (NSString *)sqlForDeleteWhere:(NSString *)where;
- (NSString *)sqlForUpdateWhere:(NSString *)where;
- (NSString *)sqlForSelectWhere:(NSString *)where;

#pragma mark - Setters/Getters
- (NSString *)table_description;
- (NSArray *)all_column_names;
- (void)setTable_name:(NSString *)table_name;
- (void)setPrimaryKeys:(NSArray *)primaryKeys;
- (void)setColumns:(NSArray<WCDBColumn *> *)columns;

@end
