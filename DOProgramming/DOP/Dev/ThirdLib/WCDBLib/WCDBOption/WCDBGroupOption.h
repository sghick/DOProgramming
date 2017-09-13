//
//  WCDBGroupOption.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/17.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBOption.h"

@interface WCDBGroupOption : WCDBOption

@property (copy, nonatomic) NSArray<id<WCDBOption>> *options;

- (void)addOption:(id<WCDBOption>)option;
- (void)addOptions:(NSArray<id<WCDBOption>> *)options;

@end
