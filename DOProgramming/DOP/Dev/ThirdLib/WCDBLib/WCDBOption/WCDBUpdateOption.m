//
//  WCDBUpdateOption.m
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/17.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBUpdateOption.h"
#import "WCDBSetter.h"

@implementation WCDBUpdateOption

- (instancetype)initWithObject:(NSObject *)obj {
    self = [super init];
    if (self) {
        _object = obj;
    }
    return self;
}

- (NSString *)tableName {
    if (_tableName == nil) {
        if (_object != nil) {
            return NSStringFromClass([_object class]);
        }
    }
    return _tableName;
}

- (int)excuteInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    WCDBSetter *dbSetter = [self dbSetter];
    if (dbSetter == nil) {
        return NO;
    }
    if (self.object == nil) {
        return NO;
    }
    NSDictionary *params = [[WCDBOptionConfig shareInstance].dbParser sqlParamsDictFromModel:self.object withDBSetter:dbSetter];
    NSString *sql = [dbSetter sqlForUpdateWhere:self.where];
    BOOL isSuccess = [[[WCDBOptionConfig shareInstance].dbManager class] doExcuteSQL:sql withParamsInDictionary:params inTransaction:item rollback:rollback];
    return isSuccess;
}

- (id)queryInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    return @([self excuteInTransaction:item rollback:rollback]);
}

- (WCDBSetter *)dbSetter {
    Class modelClass = [self.object class];
    WCDBSetter *dbSetter = [WCDBSetter dbSetterWithClass:modelClass
                                               tableName:self.tableName];
    return dbSetter;
}

@end
