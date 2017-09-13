//
//  WCDBUtilOption.m
//  WCDBLib
//
//  Created by 丁治文 on 2017/4/19.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBUtilOption.h"
#import "WCDBAdapter.h"
#import "WCDBOptionConfig.h"

@implementation WCDBUtilOption

#pragma mark - DBUtils
+ (BOOL)ifTableExistWithName:(NSString *)tableName {
    __block BOOL result = NO;
    [[WCDBOptionConfig shareInstance].dbManager doOptionInTransaction:^(id<WCTransactionItemDelegate> item, BOOL *rollback) {
        result = [WCDBAdapter ifTableExistWithName:tableName inTransaction:item rollback:rollback];
    }];
    return result;
}

+ (BOOL)dropTableWithName:(NSString *)tableName {
    __block BOOL result = NO;
    [[WCDBOptionConfig shareInstance].dbManager doOptionInTransaction:^(id<WCTransactionItemDelegate> item, BOOL *rollback) {
        result = [WCDBAdapter dropTableWithName:tableName inTransaction:item rollback:rollback];
    }];
    return result;
}

+ (NSArray *)selectExistedTablesNames {
    __block NSArray *result = nil;
    [[WCDBOptionConfig shareInstance].dbManager doOptionInTransaction:^(id<WCTransactionItemDelegate> item, BOOL *rollback) {
        result = [WCDBAdapter selectExistedTablesNamesInTransaction:item rollback:rollback];
    }];
    return result;
}

+ (BOOL)deleteAllTablesData {
    __block BOOL result = NO;
    [[WCDBOptionConfig shareInstance].dbManager doOptionInTransaction:^(id<WCTransactionItemDelegate> item, BOOL *rollback) {
        result = [WCDBAdapter deleteAllTablesDataInTransaction:item rollback:rollback];
    }];
    return result;
}

@end
