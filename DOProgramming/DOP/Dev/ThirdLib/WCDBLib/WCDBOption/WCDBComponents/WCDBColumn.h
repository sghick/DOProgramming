//
//  WCDBColumn.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/3.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// dbColumnType
extern NSString * const dbColumnTypeText;
extern NSString * const dbColumnTypeBlob;
extern NSString * const dbColumnTypeDate;
extern NSString * const dbColumnTypeReal;
extern NSString * const dbColumnTypeInteger;
extern NSString * const dbColumnTypeFloat;
extern NSString * const dbColumnTypeDouble;
extern NSString * const dbColumnTypeBoolean;
extern NSString * const dbColumnTypeSmallint;
extern NSString * const dbColumnTypeCurrency;
extern NSString * const dbColumnTypeVarchar;
extern NSString * const dbColumnTypeBinary;
extern NSString * const dbColumnTypeTime;
extern NSString * const dbColumnTypeTimestamp;

typedef NS_ENUM(NSInteger, WCDBPropertyType) {
    WCDBPropertyTypeUnknow      = 0,    // 未知
    WCDBPropertyTypeValue       = 1,    // 数值
    WCDBPropertyTypeArray       = 2,    // 数组
    WCDBPropertyTypeDictionary  = 3,    // 字典
    WCDBPropertyTypeDate        = 4,    // 日期
    WCDBPropertyTypeCustom      = 5,    // 自定义类
};

@interface WCDBColumn : NSObject

@property (nonatomic, strong) NSString *dbTypeSymbol;               ///< if none, return type, default is none
@property (nonatomic, strong, readonly) NSString *dbType;           ///< dbColumnType

@property (nonatomic, assign) WCDBPropertyType property_type;       ///< 类型区分

// property info
@property (nonatomic, strong, readonly) NSString *name;             ///< property's name
@property (nonatomic, strong, readonly) NSString *typeEncoding;     ///< property's encoding value
@property (nonatomic, strong, readonly) NSString *ivarName;         ///< property's ivar name
@property (nonatomic, assign, readonly) Class cls;                  ///< may be nil

+ (instancetype)dbColumnWithAttributeString:(objc_property_t)property;
- (instancetype)initWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding ivarName:(NSString *)ivarName cls:(Class)cls;

- (BOOL)isEqualToDBColumn:(WCDBColumn *)column;///< dbName,dbType is compared
- (NSString *)column_description;///< dbName,dbType,dbTypeSymbol is show

- (NSString *)description;

@end
