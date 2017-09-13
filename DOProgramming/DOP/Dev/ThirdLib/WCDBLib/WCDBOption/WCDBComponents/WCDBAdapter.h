//
//  WCDBAdapter.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/17.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCDBOptionConfig.h"

@class WCDBSetter;
@interface WCDBAdapter : NSObject

+ (BOOL)createAndAlterTableWithDbSetter:(WCDBSetter *)dbSetter
                          inTransaction:(id<WCTransactionItemDelegate>)item
                               rollback:(BOOL *)rollback;

+ (BOOL)createAndAlterTableWithName:(NSString *)tableName
                            columns:(NSDictionary *)columns
                     andPrimaryKeys:(NSArray *)primaryKeys
                      inTransaction:(id<WCTransactionItemDelegate>)item
                           rollback:(BOOL *)rollback;

+ (BOOL)ifTableExistWithName:(NSString *)tableName
               inTransaction:(id<WCTransactionItemDelegate>)item
                    rollback:(BOOL *)rollback;

+ (BOOL)dropTableWithName:(NSString *)tableName
            inTransaction:(id<WCTransactionItemDelegate>)item
                 rollback:(BOOL *)rollback;

+ (NSArray *)selectExistedTablesNamesInTransaction:(id<WCTransactionItemDelegate>)item
                                          rollback:(BOOL *)rollback;

+ (BOOL)deleteAllTablesDataInTransaction:(id<WCTransactionItemDelegate>)item
                                rollback:(BOOL *)rollback;

@end
