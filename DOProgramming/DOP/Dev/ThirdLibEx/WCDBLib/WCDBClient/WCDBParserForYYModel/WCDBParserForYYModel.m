//
//  WCDBParserForYYModel.m
//  WCDBLib
//
//  Created by 丁治文 on 2017/6/27.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBParserForYYModel.h"
#import "WCDBSetter.h"
#import "WCDBColumn.h"
#import "YYModel.h"

@implementation WCDBParserForYYModel

- (NSDictionary *)sqlParamsDictFromModel:(NSObject *)obj withDBSetter:(WCDBSetter *)dbSetter {
    if (!obj) {
        return nil;
    }
    if (!dbSetter) {
        return nil;
    }
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    for (NSString *name in dbSetter.all_column_names) {
        id value = [obj valueForKey:name];
        WCDBColumn *column = [dbSetter columnWithColumnName:name];
        NSData *objectValue = [WCDBParserForYYModel parserToDBParamsWithValue:value withColumn:column];
        [dict setValue:(objectValue?objectValue:[NSNull null]) forKey:name];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (id)modelFromDict:(NSDictionary *)dict class:(Class)cls withDBSetter:(WCDBSetter *)dbSetter {
    if (!dict) {
        return nil;
    }
    if (!cls) {
        return nil;
    }
    if (!dbSetter) {
        return nil;
    }
    
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    for (NSString *name in dbSetter.all_column_names) {
        id value = dict[name];
        if (value && ![value isKindOfClass:[NSNull class]]) {
            WCDBColumn *column = [dbSetter columnWithColumnName:name];
            id jsonObject = [WCDBParserForYYModel parserToObjectWithValue:value withColumn:column];
            if (jsonObject) {
                [mutDict setObject:jsonObject forKey:name];
            }
        }
    }
    NSObject *obj = [cls yy_modelWithDictionary:mutDict];
    return obj;
}

#pragma mark - JSON Utils
+ (id)parserToDBParamsWithValue:(id)value withColumn:(WCDBColumn *)column {
    if (!value || [value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    switch (column.property_type) {
        case WCDBPropertyTypeCustom: {
            if ([column.dbTypeSymbol isEqualToString:dbColumnTypeBlob]) {
                NSData *objectValue = [value yy_modelToJSONData];
                return objectValue;
            }
        }
            break;
        case WCDBPropertyTypeArray: {
            if ([column.dbTypeSymbol isEqualToString:dbColumnTypeBlob]) {
                NSData *objectValue = [value yy_modelToJSONData];
                return objectValue;
            }
        }
            break;
        case WCDBPropertyTypeDictionary: {
            if ([column.dbTypeSymbol isEqualToString:dbColumnTypeBlob]) {
                NSData *objectValue = [value yy_modelToJSONData];
                return objectValue;
            }
        }
            break;
            
        default:
            break;
    }
    return value;
}

+ (id)parserToObjectWithValue:(id)value withColumn:(WCDBColumn *)column {
    switch (column.property_type) {
        case WCDBPropertyTypeCustom: {
            id jsonObject = [WCDBParserForYYModel parserToCustomOrDictionaryOrArray:value withColumn:column];
            return jsonObject;
        }
            break;
        case WCDBPropertyTypeArray: {
            id jsonObject = [WCDBParserForYYModel parserToCustomOrDictionaryOrArray:value withColumn:column];
            return jsonObject;
        }
            break;
        case WCDBPropertyTypeDictionary: {
            id jsonObject = [WCDBParserForYYModel parserToCustomOrDictionaryOrArray:value withColumn:column];
            return jsonObject;
        }
            break;
            
        default:
            break;
    }
    return value;
}

+ (id)parserToCustomOrDictionaryOrArray:(NSData *)data withColumn:(WCDBColumn *)column {
    if (![data isKindOfClass:[NSData class]]) {
        return nil;
    }
    NSError *err;
    id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    //data转换成dic或者数组
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return responseObject;
}

@end
