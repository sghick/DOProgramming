//
//  WCDBManager.m
//  WCDBLib
// 
//  Created by WuBo on 16/2/24.
//  Copyright © 2016年 WeiChe. All rights reserved.
//

#import "WCDBManager.h"
#import "FMDB.h"
#import "FMDatabase+WCSqliteKey.h"
#import "WCDBOptionConfig.h"
#import "WCDBParserForYYModel.h"

#define kDBLibVersion(dbPath) ([NSString stringWithFormat:@"%@", dbPath])

@implementation WCTransactionItem

@end

@interface WCDBManager ()

@property (nonatomic, copy  ) NSString        *dbName;//数据库名称，保护后缀名
@property (nonatomic, copy  ) NSString        *dbFilePath;//本地数据库路径
@property (nonatomic, strong) FMDatabaseQueue *queue;
@property (nonatomic, strong) FMDatabase      *db;

@end

@implementation WCDBManager

static WCDBManager *_sharedDBManager;
+ (WCDBManager *)defaultDBManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDBManager = [[WCDBManager alloc] init];
        /// 初始化组件
        WCDBParserForYYModel *parser = [[WCDBParserForYYModel alloc] init];
        [WCDBOptionConfig shareInstance].dbManager = _sharedDBManager;
        [WCDBOptionConfig shareInstance].dbParser = parser;
    });
    return _sharedDBManager;
}

- (void)dealloc {
    [self closeDatabase];
    _sharedDBManager = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

#pragma mark - Version
- (void)setLocalVersion:(double)localVersion withDBPath:(NSString *)dbPath {
    [[NSUserDefaults standardUserDefaults] setDouble:localVersion forKey:kDBLibVersion(dbPath)];
}

- (double)localVersionWithDBPath:(NSString *)dbPath {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kDBLibVersion(dbPath)];
}

- (NSComparisonResult)versionCompareToLocal:(double)version withDBPath:(NSString *)dbPath {
    return (version > [self localVersionWithDBPath:dbPath]);
}

#pragma mark - 数据库操作
- (void)copyDatabaseIfNotExsitFromBoundle:(NSString *)boundle toName:(NSString *)name {
    if (!boundle) {
        return;
    }
    if (!name) {
        return;
    }
    NSString *dbFileDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath = [dbFileDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.sqlite", name]];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:dbFilePath]) {
        NSString *dbPath = [[NSBundle mainBundle] pathForResource:boundle ofType:@"sqlite"];
        [manager copyItemAtPath:dbPath toPath:dbFilePath error:nil];
    }
}

- (WCDBStatus)connectDatabaseWithName:(NSString *)name withVersion:(double)version {
    WCDBStatus status = [self connectDatabaseWithName:name];
    if (status == DB_OPEN_SUCCESS) {
        if ([self versionCompareToLocal:version withDBPath:self.dbFilePath] == NSOrderedDescending) {
            if ([self deleteDatabase]) {
                [self setLocalVersion:version withDBPath:self.dbFilePath];
                return [self connectDatabaseWithName:name withVersion:version];
            }
        }
    }
    return status;
}

- (WCDBStatus)connectDatabaseWithName:(NSString *)name {
    if (name == nil || name.length == 0) {
        return DB_OPEN_FAIL;
    }
    
    if (self.dbName != nil && [self.dbName isEqualToString:name] == NO) {
        [self closeDatabase];
    }
    self.dbName = [NSString stringWithFormat:@"%@.sqlite",name];
    NSString *dbFilePath = [self getDBFilePath];
    if (_queue == nil) {
        _queue = [[FMDatabaseQueue alloc] initWithPath:dbFilePath];
        self.dbFilePath = dbFilePath;
        self.db = [self getCurrentDatabase];
        NSLog(@"db path: %@", dbFilePath);
    }
    return DB_OPEN_SUCCESS;
}

- (void)closeDatabase {
    [self.queue close];
    self.queue = nil;
    self.db = nil;
}

- (BOOL)deleteDatabase {
    [self closeDatabase];
    
    if ([self checkDBFileExist] == YES) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error = nil;
        [fileManager removeItemAtPath:[self getDBFilePath] error:&error];
        if (error != nil) {
            NSLog(@"remove database error");
            return NO;
        } else {
            NSLog(@"remove database successfully");
            return YES;
        }
    } else {
        NSLog(@"There is no database!");
        return YES;
    }
}

- (WCDBStatus)getDatabaseConnectStatus {
    if (self.queue == nil || self.db == nil) {
        return DB_CLOSED;
    }
    
    if ([self.db goodConnection] == YES) {
        return DB_OPENNING;
    } else {
        return DB_CLOSED;
    }
}

#pragma mark - SQL执行

- (void)doOptionInTransaction:(WCTransactionBlock)block {
    __weak typeof(self) weakSelf = self;
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if (block) {
            WCTransactionItem *item = [[WCTransactionItem alloc] init];
            item.db = db;
            item.queue = weakSelf.queue;
            block(item, rollback);
        }
    }];
}

+ (BOOL)doExcuteSQLs:(NSArray *)sqlArray inTransaction:(id<WCTransactionItemDelegate>)transaction rollback:(BOOL *)rollback {
    __block BOOL result = NO;
    WCTransactionItem *item = (WCTransactionItem *)transaction;
    for (NSString *sql in sqlArray) {
        // validate SQL
        NSError *error = nil;
        result = [item.db validateSQL:sql error:&error];
        if (result == NO || error != nil) {
            *rollback = YES;
            return result;
        }
        
        // execute SQL
        result = [item.db executeUpdate:[NSString stringWithFormat:@"%@;", sql]];
        if (result == NO) {
            *rollback = YES;
            return result;
        }
    }
    
    if (result == YES) {
        // sql 语句执行成功
        //        NSLog(@"WCDBManager: sqls excute successfully");
    } else {
        // sql 语句执行失败
        NSLog(@"WCDBManager: sqls excute unsuccessfully");
    }
    return result;
}

+ (BOOL)doExcuteSQL:(NSString *)sql withParamsInDictionary:(NSDictionary *)params inTransaction:(id<WCTransactionItemDelegate>)transaction rollback:(BOOL *)rollback {
    if (sql == nil || sql.length == 0) {
        return NO;
    }
    BOOL result = NO;
    NSError *error = nil;
    WCTransactionItem *item = (WCTransactionItem *)transaction;
    result = [item.db validateSQL:sql error:&error];
    if (result == NO || error != nil) {
        *rollback = YES;
        return NO;
    }
    
    result = [item.db executeUpdate:sql withParameterDictionary:params];
    if (result == NO) {
        *rollback = YES;
        return NO;
    }
    
    if (result == YES) {
        // sql 语句执行成功
        //        NSLog(@"WCDBManager: sqls excute successfully");
    } else {
        // sql 语句执行失败
        NSLog(@"WCDBManager: sqls excute unsuccessfully");
    }
    return result;
}

+ (BOOL)doExcuteSQL:(NSString *)sql withParamsInArray:(NSArray *)params inTransaction:(id<WCTransactionItemDelegate>)transaction rollback:(BOOL *)rollback {
    if (sql == nil || sql.length == 0) {
        return NO;
    }
    BOOL result = NO;
    NSError *error = nil;
    WCTransactionItem *item = (WCTransactionItem *)transaction;
    result = [item.db validateSQL:sql error:&error];
    if (result == NO || error != nil) {
        *rollback = YES;
        return NO;
    }
    
    result = [item.db executeUpdate:sql withArgumentsInArray:params];
    if (result == NO) {
        *rollback = YES;
        return NO;
    }
    
    if (result == YES) {
        // sql 语句执行成功
        //        NSLog(@"WCDBManager: sqls excute successfully");
    } else {
        // sql 语句执行失败
        NSLog(@"WCDBManager: sqls excute unsuccessfully");
    }
    return result;
}

+ (NSArray *)doQuerySQL:(NSString *)sql withParamsInDictionary:(NSDictionary *)params inTransaction:(id<WCTransactionItemDelegate>)transaction rollback:(BOOL *)rollback {
    WCTransactionItem *item = (WCTransactionItem *)transaction;
    if (sql == nil || sql.length == 0 || item.queue == nil) {
        return nil;
    }
    
    NSError *error = nil;
    BOOL result = [item.db validateSQL:sql error:&error];
    if (result == NO || error != nil) {
        return nil;
    }
    
    NSMutableArray *ret = [NSMutableArray array];
    FMResultSet * set = [item.db executeQuery:sql withParameterDictionary:params];
    while ([set next]) {
        [ret addObject:[set resultDictionary]];
    }
    return [NSArray arrayWithArray:ret];
}

+ (NSArray *)doQuerySQL:(NSString *)sql withParamsInArray:(NSArray *)params inTransaction:(id<WCTransactionItemDelegate>)transaction rollback:(BOOL *)rollback {
    WCTransactionItem *item = (WCTransactionItem *)transaction;
    if (sql == nil || sql.length == 0 || item.queue == nil) {
        return nil;
    }
    
    NSError *error = nil;
    BOOL result = [item.db validateSQL:sql error:&error];
    if (result == NO || error != nil) {
        return nil;
    }
    
    NSMutableArray *ret = [NSMutableArray array];
    FMResultSet * set = [item.db executeQuery:sql withArgumentsInArray:params];
    while ([set next]) {
        [ret addObject:[set resultDictionary]];
    }
    return [NSArray arrayWithArray:ret];
}

#pragma mark - DB Utils

- (FMDatabase *)getCurrentDatabase {
    if (self.queue == nil) {
        return nil;
    }
    
    __block FMDatabase *database = nil;
    [self.queue inDatabase:^(FMDatabase *db) {
        database = db;
    }];
    return database;
}

- (NSString *)getDBFilePath {
    NSString *dbFileDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath = [dbFileDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@", self.dbName]];
    return dbFilePath;
}

- (BOOL)checkDBFileExist {
    if (self.dbName == nil) {
        return NO;
    }
    NSString *dbFilePath = [self getDBFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:dbFilePath];;
}



@end
