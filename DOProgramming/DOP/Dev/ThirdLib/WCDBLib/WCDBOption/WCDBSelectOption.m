//
//  WCDBSelectOption.m
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/17.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBSelectOption.h"
#import "WCDBSetter.h"

@implementation WCDBSelectOption

- (instancetype)initWithModelClass:(Class)modelClass {
    self = [super init];
    if (self) {
        _modelClass = modelClass;
    }
    return self;
}

- (instancetype)initWithTableName:(NSString *)tableName {
    self = [super init];
    if (self) {
        _tableName = tableName;
    }
    return self;
}

- (NSString *)tableName {
    if (_tableName == nil) {
        if (_modelClass != NULL) {
            return NSStringFromClass(_modelClass);
        }
    }
    return _tableName;
}

- (int)excuteInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    NSArray *results = (NSArray *)[self queryInTransaction:item rollback:rollback];
    return (int)results.count;
}

- (id)queryInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    NSArray *results = nil;
    WCDBSetter *dbSetter = [self dbSetter];
    if (dbSetter == nil) {
        return results;
    }
    NSString *sql = [dbSetter sqlForSelectWhere:self.where];
    if (self.paramsArray) {
        results = [[[WCDBOptionConfig shareInstance].dbManager class] doQuerySQL:sql withParamsInArray:self.paramsArray inTransaction:item rollback:rollback];
    } else {
        results = [[[WCDBOptionConfig shareInstance].dbManager class] doQuerySQL:sql withParamsInDictionary:self.paramsDict inTransaction:item rollback:rollback];
    }
    if (results && self.modelClass) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in results) {
            NSObject *obj = [[WCDBOptionConfig shareInstance].dbParser modelFromDict:dict class:self.modelClass withDBSetter:dbSetter];
            if (obj) {
                [array addObject:obj];
            }
        }
        if (array.count > 0) {
            results = [NSArray arrayWithArray:array];
        }
    }
    return results;
}

- (WCDBSetter *)dbSetter {
    WCDBSetter *dbSetter = [WCDBSetter dbSetterWithClass:self.modelClass
                                               tableName:self.tableName];
    return dbSetter;
}

@end
