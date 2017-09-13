//
//  WCDBDeleteOption.m
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/17.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBDeleteOption.h"
#import "WCDBSetter.h"

@implementation WCDBDeleteOption

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
    WCDBSetter *dbSetter = [self dbSetter];
    if (dbSetter == nil) {
        return 0;
    }
    NSString *sql = [dbSetter sqlForDeleteWhere:self.where];
    BOOL result = NO;
    if (self.paramsArray) {
        result = [[[WCDBOptionConfig shareInstance].dbManager class] doExcuteSQL:sql withParamsInArray:self.paramsArray inTransaction:item rollback:rollback];
    } else {
        result = [[[WCDBOptionConfig shareInstance].dbManager class] doExcuteSQL:sql withParamsInDictionary:self.paramsDict inTransaction:item rollback:rollback];
    }
    return result;
}

- (id)queryInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    return @([self excuteInTransaction:item rollback:rollback]);
}

- (WCDBSetter *)dbSetter {
    WCDBSetter *dbSetter = [WCDBSetter dbSetterWithClass:self.modelClass
                                               tableName:self.tableName];
    return dbSetter;
}

@end
