//
//  WCDBInsertOption.m
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/17.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBInsertOption.h"
#import "WCDBSetter.h"
#import "WCDBAdapter.h"

@implementation WCDBInsertOption

- (instancetype)init {
    return [self initWithObjects:nil];
}

- (instancetype)initWithObjects:(NSArray *)objs {
    self = [super init];
    if (self) {
        _objects = objs;
        _insertType = WCDBInsertOptionTypeInsertOrReplace;
    }
    return self;
}

- (NSString *)tableName {
    if (_tableName == nil) {
        if (_objects != nil) {
            return NSStringFromClass([_objects.firstObject class]);
        }
    }
    return _tableName;
}

- (int)excuteInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    int count = 0;
    WCDBSetter *dbSetter = [self dbSetter];
    if (dbSetter == nil) {
        return count;
    }
    
    BOOL isTableModifiedSuccess = [WCDBAdapter createAndAlterTableWithDbSetter:dbSetter inTransaction:item rollback:rollback];
    if (isTableModifiedSuccess == YES) {
        NSString *sql = nil;
        switch (self.insertType) {
            case WCDBInsertOptionTypeInsert:{sql = [dbSetter sqlForInsert];} break;
            case WCDBInsertOptionTypeInsertOrReplace:{sql = [dbSetter sqlForInsertOrReplace];} break;
            case WCDBInsertOptionTypeInsertOrIgnore:{sql = [dbSetter sqlForInsertOrIgnore];} break;
            default: break;
        }
        if (sql == nil) {
            return count;
        }
        
        for (id model in self.objects) {
            NSDictionary *params = [[WCDBOptionConfig shareInstance].dbParser sqlParamsDictFromModel:model withDBSetter:dbSetter];
            if (self.generalParam) {
                NSMutableDictionary *gen = [NSMutableDictionary dictionaryWithDictionary:params];
                [gen setValuesForKeysWithDictionary:self.generalParam];
                params = [NSDictionary dictionaryWithDictionary:gen];
            }
            BOOL result = [[[WCDBOptionConfig shareInstance].dbManager class] doExcuteSQL:sql
                                                           withParamsInDictionary:params
                                                                    inTransaction:item
                                                                         rollback:rollback];
            count += result;
        }
    }
    return count;
}

- (id)queryInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    return @([self excuteInTransaction:item rollback:rollback]);
}

- (WCDBSetter *)dbSetter {
    Class modelClass = [self.objects.firstObject class];
    WCDBSetter *dbSetter = [WCDBSetter dbSetterWithClass:modelClass
                                               tableName:self.tableName
                                             primaryKeys:self.primaryKeys];
    return dbSetter;
}

@end
