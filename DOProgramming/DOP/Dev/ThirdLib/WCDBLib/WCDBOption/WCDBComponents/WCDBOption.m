//
//  WCDBOption.m
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/21.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBOption.h"
#import "WCDBAdapter.h"
#import "WCDBSetter.h"

@interface WCDBOption ()

/**
 Optional,表名
 default:NSStringFromClass(modelClass)
 */
@property (copy  , nonatomic) NSString  *baseTableName;

/**
 Optional,类名,指定创建的表/类名
 default:NULL
 */
@property (assign, nonatomic) Class     baseModelClass;

/**
 Optional,创建表时指定的主键
 default:nil
 */
@property (strong, nonatomic) NSArray   *basePrimaryKeys;

@end

@implementation WCDBOption

- (int)excuteInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    return 0;
}

- (id)queryInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    return nil;
}

- (int)excute {
    __block int count = 0;
    [[WCDBOptionConfig shareInstance].dbManager doOptionInTransaction:^(id<WCTransactionItemDelegate> item, BOOL *rollback) {
        if (self.needsAutoCreateAndAlterTable) {
            WCDBSetter *dbSetter = [self dbSetter];
            if (dbSetter == nil) {
                return;
            }
            BOOL isTableModifiedSuccess = [WCDBAdapter createAndAlterTableWithDbSetter:dbSetter inTransaction:item rollback:rollback];
            if (isTableModifiedSuccess == NO) {
                return;
            }
        }
        
        count += [self excuteInTransaction:item rollback:rollback];
    }];
    return count;
}

- (id)query {
    __block id result = nil;
    [[WCDBOptionConfig shareInstance].dbManager doOptionInTransaction:^(id<WCTransactionItemDelegate> item, BOOL *rollback) {
        if (self.needsAutoCreateAndAlterTable) {
            WCDBSetter *dbSetter = [self dbSetter];
            if (dbSetter == nil) {
                return;
            }
            BOOL isTableModifiedSuccess = [WCDBAdapter createAndAlterTableWithDbSetter:dbSetter inTransaction:item rollback:rollback];
            if (isTableModifiedSuccess == NO) {
                return;
            }
        }
        
        result = [self queryInTransaction:item rollback:rollback];
    }];
    return result;
}

- (WCDBSetter *)dbSetter {
    WCDBSetter *dbSetter = [WCDBSetter dbSetterWithClass:self.baseModelClass
                                               tableName:self.baseTableName
                                             primaryKeys:self.basePrimaryKeys];
    return dbSetter;
}

- (void)setNeedsAutoCreateAndAlterTableWithModelClass:(Class)modelClass tableName:(NSString *)tableName primaryKeys:(NSArray *)primaryKeys {
    _needsAutoCreateAndAlterTable = YES;
    _baseModelClass = modelClass;
    _baseTableName = tableName;
    _basePrimaryKeys = primaryKeys;
}

- (id)parserResultsToModel:(NSArray *)results withModelClass:(Class)modelClass {
    WCDBSetter *dbSetter = [WCDBSetter dbSetterWithClass:modelClass];
    if (results && modelClass) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in results) {
            NSObject *obj = [[WCDBOptionConfig shareInstance].dbParser modelFromDict:dict class:modelClass withDBSetter:dbSetter];
            if (obj) {
                [array addObject:obj];
            }
        }
        return [NSArray arrayWithArray:array];
    }
    return nil;
}

@end
