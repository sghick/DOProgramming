//
//  WCDBManager.h
//  DBDemo
//
//  Created by WuBo on 16/2/24.
//  Copyright © 2016年 WeiChe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCDataBase.h"

typedef NS_ENUM(NSInteger, WCDBStatus) {
    DB_CREATE_FAIL    = -1,//数据库创建失败
    DB_CREATE_SUCCESS = 0,//数据库创建成功
    DB_EXIST          = 1,//数据库已经存在
    DB_OPEN_FAIL      = 2,//数据库链接失败
    DB_OPEN_SUCCESS   = 3,//数据库链接成功
    DB_OPENNING       = 4,//数据库当前为open状态
    DB_CLOSED         = 5,//数据库当前为close状态
};

@class FMDatabaseQueue;
@class FMDatabase;
@interface WCTransactionItem : NSObject<WCTransactionItemDelegate>

@property (strong, nonatomic) FMDatabaseQueue   *queue;
@property (strong, nonatomic) FMDatabase        *db;

@end

@interface WCDBManager : NSObject<WCDataBaseDelegate>

+ (WCDBManager *)defaultDBManager;

#pragma mark - 数据库操作

/**
 把boundle中的本地数据库拷贝到待连接的数据库地址
 
 @param boundle boundle中的数据库名
 @param name    更名拷贝到沙盒中的数据库名
 */
- (void)copyDatabaseIfNotExsitFromBoundle:(NSString *)boundle toName:(NSString *)name;

/**
 *  根据名称建立或连接数据库，如果数据库不存在则建立并连接打开，如果数据库已经存在则直接连接打开
 *
 *  @param name     Database Name，只名称，不需要包含后缀名
 *  @param version  Database 的版本号,如果版本号比原来大,则删除原来的Database,并重新创建一个新的
 *
 *  @return 返回数据库创建或连接状态
 */
- (WCDBStatus)connectDatabaseWithName:(NSString *)name withVersion:(double)version;

/**
 *  根据名称建立或连接数据库，如果数据库不存在则建立并连接打开，如果数据库已经存在则直接连接打开
 *
 *  @param name Database Name，只名称，不需要包含后缀名
 *
 *  @return 返回数据库创建或连接状态
 */
- (WCDBStatus)connectDatabaseWithName:(NSString *)name;

/**
 *  关闭数据库
 */
- (void)closeDatabase;

/**
 *  删除数据库文件
 */
- (BOOL)deleteDatabase;

/**
 *  获取数据库当前状态，OPEN还是CLOSED
 *
 *  @return 返回数据库状态
 */
- (WCDBStatus)getDatabaseConnectStatus;

#pragma mark - Database Utils

/**
 *  获取当前的数据库对象
 *
 *  @return 返回数据库对象
 */
- (FMDatabase *)getCurrentDatabase;

/**
 *  获取数据库文件路径
 *
 *  @return 数据库文件路径
 */
- (NSString *)getDBFilePath;

/**
 *  检查数据库文件是否存在
 *
 *  @return 存在返回YES，不存在返回NO
 */
- (BOOL)checkDBFileExist;

@end
