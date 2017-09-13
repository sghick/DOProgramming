//
//  WCDataBase.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/6/27.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WCTransactionItemDelegate <NSObject>

@end

typedef void(^WCTransactionBlock)(id<WCTransactionItemDelegate> item, BOOL *rollback);

@protocol WCDataBaseDelegate <NSObject>

#pragma mark - SQL执行

- (void)doOptionInTransaction:(WCTransactionBlock)block;
+ (BOOL)doExcuteSQLs:(NSArray *)sqlArray inTransaction:(id<WCTransactionItemDelegate>)transaction rollback:(BOOL *)rollback;
+ (BOOL)doExcuteSQL:(NSString *)sql withParamsInDictionary:(NSDictionary *)params inTransaction:(id<WCTransactionItemDelegate>)transaction rollback:(BOOL *)rollback;
+ (BOOL)doExcuteSQL:(NSString *)sql withParamsInArray:(NSArray *)params inTransaction:(id<WCTransactionItemDelegate>)transaction rollback:(BOOL *)rollback;
+ (NSArray *)doQuerySQL:(NSString *)sql withParamsInDictionary:(NSDictionary *)params inTransaction:(id<WCTransactionItemDelegate>)transaction rollback:(BOOL *)rollback;
+ (NSArray *)doQuerySQL:(NSString *)sql withParamsInArray:(NSArray *)params inTransaction:(id<WCTransactionItemDelegate>)transaction rollback:(BOOL *)rollback;

@end

@interface WCDataBase : NSObject

@end
