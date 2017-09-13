//
//  WCSections.m
//  AstonMartin
//
//  Created by buding on 15/11/23.
//  Copyright © 2015年 Buding WeiChe. All rights reserved.
//

#import "WCSections.h"

@implementation WCSections

- (instancetype)init {
    self = [super init];
    if (self) {
        _sections = [NSMutableArray array];
    }
    return self;
}

- (WCRow *)rowWithIndexPath:(NSIndexPath *)indexPath {
    WCSection *sec = [self sectionWithIndexPathSection:indexPath.section];
    if (sec) {
        WCRow *row = [sec rowAtIndexPathRow:indexPath.row];
        if (row == nil) {
            row = [[WCRow alloc] init];
            row.sectionKey = sec.sectionKey;
            row.rowKey = -99999;
        }
        return row;
    }
    return nil;
}

//- (WCSection *)sectionWithIndexPathSection:(NSInteger)section {
//    if (self.sections.count > section) {
//        WCSection *sec = self.sections[section];
//        return sec;
//    }
//    return nil;
//}
- (WCSection *)sectionWithIndexPathSection:(NSInteger)section {
    NSInteger index = [self indexOfSectionsWithIndexPathSection:section];
    if (self.sections.count > index) {
        WCSection *sec = self.sections[index];
        sec.sectionSamesIndex = [self sectionSamesIndexWithIndexPathSection:section];
        return sec;
    }
    return nil;
}

// private
- (NSInteger)indexOfSectionsWithIndexPathSection:(NSInteger)section {
    NSInteger index = 0;
    NSInteger sumSection = 0;
    for (WCSection *sec in self.sections) {
        sumSection += sec.sectionSamesCount;
        if (sumSection > section) {
            return index;
        }
        index++;
    }
    return -99999;
}

// private
- (NSInteger)sectionSamesIndexWithIndexPathSection:(NSInteger)section {
    NSInteger sectionSamesIndex = 0;
    NSInteger sumSection = 0;
    for (WCSection *sec in self.sections) {
        sumSection += sec.sectionSamesCount;
        if (sumSection > section) {
            sectionSamesIndex = section - (sumSection - sec.sectionSamesCount);
            return sectionSamesIndex;
        }
    }
    return -99999;
}

- (NSIndexPath *)indexPathWithRowKey:(NSInteger)rowKey {
    for (int s = 0; s < self.sections.count; s++) {
        WCSection *sec = self.sections[s];
        for (int r = 0; r < sec.rows.count; r++) {
            WCRow *row = sec.rows[r];
            if (row.rowKey == rowKey) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:r inSection:s];
                return indexPath;
            }
        }
    }
    return nil;
}

- (NSIndexPath *)indexPathWithSectionKey:(NSInteger)sectionKey rowKey:(NSInteger)rowKey {
    for (int s = 0; s < self.sections.count; s++) {
        WCSection *sec = self.sections[s];
        for (int r = 0; r < sec.rows.count; r++) {
            WCRow *row = sec.rows[r];
            if ((row.sectionKey == sectionKey) && (row.rowKey == rowKey)) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:r inSection:s];
                return indexPath;
            }
        }
    }
    return nil;
}

- (NSInteger)indexPathSectionWithSectionKey:(NSInteger)sectionKey {
    for (int s = 0; s < self.sections.count; s++) {
        WCSection *sec = self.sections[s];
        if (sec.sectionKey == sectionKey) {
            return s;
        }
    }
    return -1;
}

- (void)addSection:(WCSection *)section {
    [self.sections addObject:section];
}

- (void)addSectionKey:(NSInteger)sectionKey rowKey:(NSInteger)rowKey {
    [self addSectionKey:sectionKey rowKey:rowKey sectionSamesCount:1 rowSamesCount:1];
}

- (void)addSectionKey:(NSInteger)sectionKey rowKey:(NSInteger)rowKey sectionSamesCount:(NSInteger)sectionSamesCount {
    [self addSectionKey:sectionKey rowKey:rowKey sectionSamesCount:sectionSamesCount rowSamesCount:1];
}

- (void)addSectionKey:(NSInteger)sectionKey rowKey:(NSInteger)rowKey rowSamesCount:(NSInteger)rowSamesCount {
    [self addSectionKey:sectionKey rowKey:rowKey sectionSamesCount:1 rowSamesCount:rowSamesCount];
}

// private
- (void)addSectionKey:(NSInteger)sectionKey rowKey:(NSInteger)rowKey sectionSamesCount:(NSInteger)sectionSamesCount rowSamesCount:(NSInteger)rowSamesCount {
    WCSection *sec = [self sectionWithSectionKey:sectionKey];
    if (sec) {
        [sec addRowKey:rowKey sectionSamesCount:sectionSamesCount rowSamesCount:rowSamesCount];
    } else {
        sec = [[WCSection alloc] initWithSectionKey:sectionKey];
        [sec addRowKey:rowKey sectionSamesCount:sectionSamesCount rowSamesCount:rowSamesCount];
        [self addSection:sec];
    }
}

- (WCSection *)sectionWithSectionKey:(NSInteger)sectionKey {
    for (WCSection *sec in self.sections) {
        if (sec.sectionKey == sectionKey) {
            return sec;
        }
    }
    return nil;
}

- (NSInteger)sectionSamesCountOfAll {
    NSInteger sectionCount = 0;
    for (WCSection *sec in self.sections) {
        sectionCount += sec.sectionSamesCount;
    }
    return sectionCount;
}

@end

@implementation WCSection

- (instancetype)initWithSectionKey:(NSInteger)sectionKey {
    self = [super init];
    if (self) {
        _sectionKey = sectionKey;
        _rows = [NSMutableArray array];
    }
    return self;
}

- (void)addRowKey:(NSInteger)rowKey sectionSamesCount:(NSInteger)sectionSamesCount rowSamesCount:(NSInteger)rowSamesCount {
    self.sectionSamesCount = sectionSamesCount;
    WCRow *row = [[WCRow alloc] init];
    row.rowSamesCount = rowSamesCount;
    row.sectionKey = self.sectionKey;
    row.rowKey = rowKey;
    [self.rows addObject:row];
}

//- (WCRow *)rowAtIndexPathRow:(NSInteger)row {
//    if (self.rows.count > row) {
//        return self.rows[row];
//    }
//    return nil;
//}
- (WCRow *)rowAtIndexPathRow:(NSInteger)row {
    NSInteger index = [self indexOfRowsAtIndexPathRow:row];
    if (self.rows.count > index) {
        WCRow *rw = self.rows[index];
        rw.rowSamesIndex = [self rowSamesIndexAtIndexPathRow:row];
        return rw;
    }
    return nil;
}

// private
- (NSInteger)indexOfRowsAtIndexPathRow:(NSInteger)row {
    NSInteger index = 0;
    NSInteger sumRow = 0;
    for (WCRow *rw in self.rows) {
        sumRow += rw.rowSamesCount;
        if (sumRow > row) {
            return index;
        }
        index++;
    }
    return -99999;
}

// private
- (NSInteger)rowSamesIndexAtIndexPathRow:(NSInteger)row {
    NSInteger rowSamesIndex = 0;
    NSInteger sumRow = 0;
    for (WCRow *rw in self.rows) {
        sumRow += rw.rowSamesCount;
        if (sumRow > row) {
            rowSamesIndex = row - (sumRow - rw.rowSamesCount);
            return rowSamesIndex;
        }
    }
    return -99999;
}

- (NSInteger)rowKeyAtIndexPathRow:(NSInteger)row {
    if (self.rows.count > row) {
        return self.rows[row].rowKey;
    }
    return -1;
}


- (NSInteger)rowSamesCountOfAll {
    NSInteger rowCount = 0;
    for (WCRow *row in self.rows) {
        rowCount += row.rowSamesCount;
    }
    return rowCount;
}

@end

@implementation WCRow

@end
