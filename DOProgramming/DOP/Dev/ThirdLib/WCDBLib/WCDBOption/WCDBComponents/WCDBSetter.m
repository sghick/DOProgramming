//
//  WCDBSetter.m
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/3.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBSetter.h"
#import "WCDBColumn.h"
#import <objc/runtime.h>

@implementation WCDBSetter

@synthesize table_description = _table_description;
@synthesize all_column_names = _all_column_names;

#pragma mark - Init
+ (WCDBSetter *)dbSetterWithClass:(Class)cls {
    return [self dbSetterWithClass:cls tableName:nil];
}

+ (WCDBSetter *)dbSetterWithTableName:(NSString *)tableName {
    return [self dbSetterWithClass:nil tableName:tableName];
}

+ (WCDBSetter *)dbSetterWithClass:(Class)cls tableName:(NSString *)tableName {
    return [self dbSetterWithClass:cls tableName:tableName primaryKeys:nil];
}

+ (WCDBSetter *)dbSetterWithClass:(Class)cls tableName:(NSString *)tableName primaryKeys:(NSArray *)primaryKeys {
    if ((cls == NULL) && ((tableName == nil) || (tableName.length == 0))) {
        return nil;
    }
    WCDBSetter *dbSetter = [[WCDBSetter alloc] init];
    dbSetter.table_name = tableName?tableName:NSStringFromClass(cls);
    dbSetter.primaryKeys = primaryKeys;
    dbSetter.columns = [self columnsWithClass:cls];
    return dbSetter;
}

#pragma mark - Utls
- (BOOL)isEqualToDBSetter:(WCDBSetter *)dbSetter {
    // 1.判断对象是否相等
    if (dbSetter == nil) {
        return NO;
    }
    // 2.判断表名
    if (![self isEqualTableNameToDBSetter:dbSetter]) {
        return NO;
    }
    // 3.判断主键
    if (![self isEqualPrimaryKeyToDBSetter:dbSetter]) {
        return NO;
    }
    // 4.判断字段
    if (![self isEqualColumnsToDBSetter:dbSetter]) {
        return NO;
    }
    return YES;
}

- (BOOL)isEqualTableNameToDBSetter:(WCDBSetter *)dbSetter {
    if (self.table_name) {
        if (![self.table_name isEqualToString:dbSetter.table_name]) {
            return NO;
        }
    } else {
        if (dbSetter.table_name && dbSetter.table_name.length) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isEqualPrimaryKeyToDBSetter:(WCDBSetter *)dbSetter {
    if (self.primaryKeys) {
        if (dbSetter.primaryKeys == nil) {
            return NO;
        }
        if (self.primaryKeys.count != dbSetter.primaryKeys.count) {
            return NO;
        }
        for (NSString *key in self.primaryKeys) {
            if (![dbSetter.primaryKeys containsObject:key]) {
                return NO;
            }
        }
        for (NSString *key in dbSetter.primaryKeys) {
            if (![self.primaryKeys containsObject:key]) {
                return NO;
            }
        }
    } else {
        if (dbSetter.primaryKeys && dbSetter.primaryKeys.count) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isEqualColumnsToDBSetter:(WCDBSetter *)dbSetter {
    if (self.columns) {
        if (dbSetter.columns == nil) {
            return NO;
        }
        if (self.columns.count != dbSetter.columns.count) {
            return NO;
        }
        for (WCDBColumn *column in self.columns) {
            if (![dbSetter containsForColumn:column]) {
                return NO;
            }
        }
        for (WCDBColumn *column in dbSetter.columns) {
            if (![self containsForColumn:column]) {
                return NO;
            }
        }
    } else {
        if (dbSetter.columns && dbSetter.columns.count) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)containsForColumnName:(NSString *)name {
    for (WCDBColumn *column in self.columns) {
        if ([column.name isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)containsForColumn:(WCDBColumn *)colm {
    for (WCDBColumn *column in self.columns) {
        if ([column.column_description isEqualToString:colm.column_description]) {
            return YES;
        }
    }
    return NO;
}

- (void)setNeedsResetTableDescription {
    _table_description = nil;
}

- (void)setNeedsResetTableColumnNames {
    _all_column_names = nil;
}

- (WCDBColumn *)columnWithColumnName:(NSString *)name {
    for (WCDBColumn *column in self.columns) {
        if ([column.name isEqualToString:name]) {
            return column;
        }
    }
    return nil;
}

- (void)addDBColumnTypeSymbol:(NSString *)columnName dbType:(NSString *)dbType {
    WCDBColumn *column = [self columnWithColumnName:columnName];
    if (column) {
        column.dbTypeSymbol = dbType;
    }
}

- (NSDictionary *)columnsOfDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (WCDBColumn *column in self.columns) {
        [dict setObject:column.dbType forKey:column.name];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

+ (NSArray<WCDBColumn *> *)columnsWithClass:(Class)cls {
    if (cls == nil) {
        return nil;
    }
    NSMutableArray *rtn = [NSMutableArray array];
//    YYClassInfo *classInfo = [YYClassInfo classInfoWithClass:cls];
//    [classInfo.propertyInfos enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, YYClassPropertyInfo * _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"%@,%@,%@,%@", obj.name, obj.typeEncoding, obj.ivarName, NSStringFromClass(obj.cls));
//        WCDBColumn *column = [[WCDBColumn alloc] initWithName:obj.name typeEncoding:obj.typeEncoding ivarName:obj.ivarName cls:obj.cls];
//        if (column) {
//            [rtn addObject:column];
//        }
//    }];
    
    
    NSString *className = NSStringFromClass(cls);
    // 设置字段/主键
    id classM = objc_getClass([className UTF8String]);
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(classM, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        WCDBColumn *column = [WCDBColumn dbColumnWithAttributeString:property];
        if (column) {
            //NSLog(@"%@,%@,%@,%@,%@", column.dbTypeSymbol, column.name, column.typeEncoding, column.ivarName, NSStringFromClass(column.cls));
            [rtn addObject:column];
        }
    }
    return rtn;
}

#pragma mark - Override
- (NSString *)description {
    return [self table_description];
}

#pragma mark - SqlUtils
- (NSString *)sqlForDropTable {
    NSString *dropSQL = [NSString stringWithFormat:@"DROP TABLE IF EXISTS '%@'", self.table_name];
    return dropSQL;
}

- (NSString *)sqlForCreateTable {
    NSMutableString *sqlColumns = [NSMutableString string];
    NSMutableString *sqlKeys = [NSMutableString string];
    for (WCDBColumn *column in self.columns) {
        // primary key
        if ([self.primaryKeys containsObject:column.name]) {
            [sqlColumns appendFormat:@"'%@' %@ NOT NULL, ", column.name, column.dbTypeSymbol];
            [sqlKeys appendFormat:@"'%@', ", column.name];
        } else {
            [sqlColumns appendFormat:@"'%@' %@, ", column.name, column.dbTypeSymbol];
        }
    }
    if (sqlColumns.length > 1) {
        [sqlColumns replaceCharactersInRange:NSMakeRange(sqlColumns.length - 2, 2) withString:@""];
    }
    
    NSString *createSQL = @"";
    if (sqlColumns.length > 0) {
        if (sqlKeys.length > 1) {
            [sqlKeys replaceCharactersInRange:NSMakeRange(sqlKeys.length - 2, 2) withString:@""];
            createSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (%@, PRIMARY KEY(%@))", self.table_name, sqlColumns, sqlKeys];
        } else {
            createSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (%@)", self.table_name, sqlColumns];
        }
    } else {
        createSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'", self.table_name];
    }
    return createSQL;
}

// private
- (NSString *)sqlForInsertWithHead:(NSString *)head {
    if (!head || head.length == 0) {
        return nil;
    }
    NSMutableString *properties = [NSMutableString string];
    NSMutableString *values = [NSMutableString string];
    for (WCDBColumn *column in self.columns) {
        [properties appendFormat:@"'%@',", column.name];
        [values appendFormat:@":%@,", column.name];
    }
    if ((properties.length > 0) && (values.length > 0)) {
        [properties replaceCharactersInRange:NSMakeRange(properties.length - 1, 1) withString:@""];
        [values replaceCharactersInRange:NSMakeRange(values.length - 1, 1) withString:@""];
        NSMutableString *sql = [NSMutableString stringWithFormat:@"%@ INTO '%@' (%@) VALUES(%@)", head, self.table_name, properties, values];
        return [NSString stringWithString:sql];
    } else {
        return nil;
    }
}

- (NSString *)sqlForInsert {
    return [self sqlForInsertWithHead:@"INSERT"];
}

- (NSString *)sqlForInsertOrReplace {
    return [self sqlForInsertWithHead:@"INSERT OR REPLACE"];
}

- (NSString *)sqlForInsertOrIgnore {
    return [self sqlForInsertWithHead:@"INSERT OR IGNORE"];
}

- (NSString *)sqlForDeleteWhere:(NSString *)where {
    NSString *sql = nil;
    if (where && (where.length > 0)) {
        sql = [NSString stringWithFormat:@"DELETE FROM '%@' %@", self.table_name, where];
    } else {
        sql = [NSString stringWithFormat:@"DELETE FROM '%@'", self.table_name];
    }
    return sql;
}

- (NSString *)sqlForUpdateWhere:(NSString *)where {
    NSMutableString *set = [NSMutableString string];
    for (WCDBColumn *column in self.columns) {
        [set appendFormat:@"'%@'=:%@,", column.name, column.name];
    }
    
    if (set.length > 0) {
        [set replaceCharactersInRange:NSMakeRange(set.length - 1, 1) withString:@""];
        NSString *sql = nil;
        if (where && (where.length > 0)) {
            sql = [NSString stringWithFormat:@"UPDATE '%@' set %@ %@", self.table_name, set, where];
        } else {
            sql = [NSString stringWithFormat:@"UPDATE '%@' set %@", self.table_name, set];
        }
        return sql;
    } else {
        return nil;
    }
}

- (NSString *)sqlForSelectWhere:(NSString *)where {
    NSString *sql = nil;
    if (where && (where.length > 0)) {
        sql = [NSString stringWithFormat:@"SELECT * FROM '%@' %@", self.table_name, where];
    } else {
        sql = [NSString stringWithFormat:@"SELECT * FROM '%@'", self.table_name];
    }
    return sql;
}

#pragma mark - Setters/Getters
- (NSString *)table_description {
    if (_table_description == nil) {
        NSMutableString *des = [NSMutableString string];
        // table_name
        [des appendFormat:@"table_name:%@", self.table_name];
        // primaryKeys
        if (self.primaryKeys && self.primaryKeys.count) {
            NSString *keysFormat = @"primaryKeys:(%@)";
            NSMutableString *keys = [NSMutableString string];
            for (NSString *key in self.primaryKeys) {
                [keys appendFormat:@"%@,", key];
            }
            [keys replaceCharactersInRange:NSMakeRange(keys.length - 1, 1) withString:@""];
            [des appendFormat:keysFormat, keys];
        }
        // columns
        if (self.columns && self.columns.count) {
            NSString *columnsFormat = @"columns:<\n%@\n>";
            NSMutableString *colms = [NSMutableString string];
            for (WCDBColumn *column in self.columns) {
                [colms appendFormat:@"\t%@,", column.column_description];
            }
            [colms replaceCharactersInRange:NSMakeRange(colms.length - 1, 1) withString:@""];
            [des appendFormat:columnsFormat, colms];
        }
        _table_description = [NSString stringWithString:des];
    }
    return _table_description;
}

- (NSArray *)all_column_names {
    if (_all_column_names == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (WCDBColumn *column in self.columns) {
            if (column.name) {
                [array addObject:column.name];
            }
        }
        _all_column_names = [NSArray arrayWithArray:array];
    }
    return _all_column_names;
}

- (void)setTable_name:(NSString *)table_name {
    _table_name = table_name;
    [self setNeedsResetTableDescription];
}

- (void)setPrimaryKeys:(NSArray *)primaryKeys {
    _primaryKeys = primaryKeys;
    [self setNeedsResetTableDescription];
}

- (void)setColumns:(NSArray<WCDBColumn *> *)columns {
    _columns = columns;
    [self setNeedsResetTableDescription];
    [self setNeedsResetTableColumnNames];
}

@end
