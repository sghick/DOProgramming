//
//  WCDBParser.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/4/20.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCDBSetter;
@protocol WCDBParserDelegate <NSObject>

- (NSDictionary *)sqlParamsDictFromModel:(NSObject *)obj withDBSetter:(WCDBSetter *)dbSetter;
- (id)modelFromDict:(NSDictionary *)dict class:(Class)cls withDBSetter:(WCDBSetter *)dbSetter;

@end

@interface WCDBParser : NSObject<WCDBParserDelegate>

@end
