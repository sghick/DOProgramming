//
//  WCDBSqlOption.m
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/20.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBSqlOption.h"

@implementation WCDBSqlOption

- (int)excuteInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    int count = 0;
    NSArray *sqls = [self componentsSeparatedSql:self.sql];
    if (self.paramsArray) {
        for (NSString *sql in sqls) {
            if (![self validateSql:sql]) {
                continue;
            }
            count += [[[WCDBOptionConfig shareInstance].dbManager class] doExcuteSQL:sql withParamsInArray:self.paramsArray inTransaction:item rollback:rollback];
        }
    } else {
        for (NSString *sql in sqls) {
            if (![self validateSql:sql]) {
                continue;
            }
            count += [[[WCDBOptionConfig shareInstance].dbManager class] doExcuteSQL:sql withParamsInDictionary:self.paramsDict inTransaction:item rollback:rollback];
        }
    }
    return count;
}

- (id)queryInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    id result = nil;
    NSArray *sqls = [self componentsSeparatedSql:self.sql];
    if (self.paramsArray) {
        for (NSString *sql in sqls) {
            if (![self validateSql:sql]) {
                continue;
            }
            result = [[[WCDBOptionConfig shareInstance].dbManager class] doQuerySQL:sql withParamsInArray:self.paramsArray inTransaction:item rollback:rollback];
        }
    } else {
        for (NSString *sql in sqls) {
            if (![self validateSql:sql]) {
                continue;
            }
            result = [[[WCDBOptionConfig shareInstance].dbManager class] doQuerySQL:sql withParamsInDictionary:self.paramsDict inTransaction:item rollback:rollback];
        }
    }
    return result;
}

- (NSArray<NSString *> *)componentsSeparatedSql:(NSString *)sql {
    if (!sql || !sql.length) {
        return nil;
    }
    NSArray *sqls = [sql componentsSeparatedByString:@";"];
    return sqls;
}

- (BOOL)validateSql:(NSString *)sql {
    if (!sql || !sql.length) {
        return NO;
    }
    NSString *ssq = [sql stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (ssq.length == 0) {
        return NO;
    }
    return YES;
}

@end
