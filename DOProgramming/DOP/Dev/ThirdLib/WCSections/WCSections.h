//
//  WCSections.h
//  AstonMartin
//
//  Created by buding on 15/11/23.
//  Copyright © 2015年 Buding WeiChe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCSection, WCRow;

@interface WCSections : NSObject

@property (strong, readonly, nonatomic) NSMutableArray<WCSection *> *sections;
@property (assign, readonly, nonatomic) NSInteger sectionSamesCountOfAll;

- (WCRow *)rowWithIndexPath:(NSIndexPath *)indexPath;                                       /**< 未找到:若section存在，返回rowKey = -99999的row对象，否则返回nil */
- (WCSection *)sectionWithIndexPathSection:(NSInteger)section;                              /**< 未找到:返回nil */
- (NSIndexPath *)indexPathWithRowKey:(NSInteger)rowKey;                                     /**< 如果rowKey没有重复的，推荐用此方法,未找到返回nil */
- (NSIndexPath *)indexPathWithSectionKey:(NSInteger)sectionKey rowKey:(NSInteger)rowKey;    /**< 如果rowKey有重复的，推荐用此方法,未找到返回nil */
- (NSInteger)indexPathSectionWithSectionKey:(NSInteger)sectionKey;                          /**< 未找到返回-1 */

- (WCSection *)sectionWithSectionKey:(NSInteger)sectionKey;                                 /**< 未找到返回nil */

- (void)addSection:(WCSection *)section;                                                    /**< 添加section */
- (void)addSectionKey:(NSInteger)sectionKey rowKey:(NSInteger)rowKey;                       /**< 添加section，推荐使用本方法 */
- (void)addSectionKey:(NSInteger)sectionKey
               rowKey:(NSInteger)rowKey
    sectionSamesCount:(NSInteger)sectionSamesCount;                                         /**< 添加section，这个section对应多个相同时可用 */
- (void)addSectionKey:(NSInteger)sectionKey
               rowKey:(NSInteger)rowKey
        rowSamesCount:(NSInteger)rowSamesCount;                                             /**< 添加section，这个section-row对应多个相同时可用 */

@end

@class WCRow;
@interface WCSection : NSObject

@property (assign, readonly, nonatomic) NSInteger rowSamesCountOfAll;
@property (assign, readonly, nonatomic) NSInteger sectionKey;
@property (strong, readonly, nonatomic) NSMutableArray<WCRow *> *rows;
@property (assign, nonatomic) NSInteger sectionSamesIndex;
@property (assign, nonatomic) NSInteger sectionSamesCount;

- (instancetype)initWithSectionKey:(NSInteger)sectionKey;
- (void)addRowKey:(NSInteger)rowKey sectionSamesCount:(NSInteger)sectionSamesCount rowSamesCount:(NSInteger)rowSamesCount;
- (WCRow *)rowAtIndexPathRow:(NSInteger)row;                /**< 未找到返回nil */
- (NSInteger)rowKeyAtIndexPathRow:(NSInteger)row;           /**< 未找到返回-1 */

@end

@interface WCRow : NSObject

@property (assign, nonatomic) NSInteger sectionKey;
@property (assign, nonatomic) NSInteger rowKey;
@property (assign, nonatomic) NSInteger rowSamesIndex;
@property (assign, nonatomic) NSInteger rowSamesCount;

@end


