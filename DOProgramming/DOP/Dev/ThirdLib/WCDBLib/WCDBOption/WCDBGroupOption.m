//
//  WCDBGroupOption.m
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/17.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBGroupOption.h"

@implementation WCDBGroupOption

- (int)excuteInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    int count = 0;
    for (id<WCDBOption> opt in self.options) {
        count += [opt excuteInTransaction:item rollback:rollback];
    }
    return count;
}

- (id)queryInTransaction:(id<WCTransactionItemDelegate>)item rollback:(BOOL *)rollback {
    NSMutableArray *results = [NSMutableArray array];
    for (id<WCDBOption> opt in self.options) {
        NSArray *array = [opt queryInTransaction:item rollback:rollback];
        if (array) {
            [results addObject:array];
        }
    }
    return [NSArray arrayWithArray:results];
}

- (void)addOption:(id<WCDBOption>)option {
    if (!option) {
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.options];
    [array addObject:option];
    self.options = [NSArray arrayWithArray:array];
}

- (void)addOptions:(NSArray<id<WCDBOption>> *)options {
    if (!options || (options.count == 0)) {
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.options];
    [array addObjectsFromArray:options];
    self.options = [NSArray arrayWithArray:array];
}

@end
