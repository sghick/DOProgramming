//
//  UITableView+Separator.m
//  SeperatorLine
//
//  Created by 丁治文 on 16/7/11.
//  Copyright © 2016年 丁治文. All rights reserved.
//

#import "UITableView+Separator.h"
#import <objc/runtime.h>

@interface UITableView ()

@property (assign, nonatomic) BOOL didMarkedCustom;

@end

@implementation UITableView (Separator)

#pragma mark - Getters/Setters
// didMarkedCustom
static const char SPDidMarkedCustomKey = '\0';
- (void)setDidMarkedCustom:(BOOL)didMarkedCustom {
    if (didMarkedCustom != self.didMarkedCustom) {
        objc_setAssociatedObject(self, &SPDidMarkedCustomKey, @(didMarkedCustom), OBJC_ASSOCIATION_ASSIGN);
    }
}

- (BOOL)didMarkedCustom {
    NSNumber *number = objc_getAssociatedObject(self, &SPDidMarkedCustomKey);
    return number.boolValue;
}

#pragma mark - Utils
// 推荐在初始化方法中添加,如Getter方法中
- (void)sp_markCustomTableViewSeparators {
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    self.separatorColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    // 设置隐藏系统额外的线
    [self sp_setExtraCellLineHidden];
    self.didMarkedCustom = YES;
}

- (void)sp_setSeparatorsType:(SeparatorType)separatorsType cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    if (self.didMarkedCustom == NO) {
        self.didMarkedCustom = YES;
        [self sp_markCustomTableViewSeparators];
        NSAssert(NO, @"%s:未标记使用自定义样式线, 请使用 '-:sp_markCustomTableViewSeparators'", __func__);
    }
    switch (separatorsType) {
        case SeparatorTypeDefault: {
            [self setCell:cell separatorMargins:[self insetForLone]];
        }
            break;
        case SeparatorTypeLeftShort: {
            NSInteger rowCount = [self numberOfRowsInSection:indexPath.section];
            if (rowCount != (indexPath.row + 1)) {
                [self setCell:cell separatorMargins:[self insetForLeftShort]];
            } else {
                [self setCell:cell separatorMargins:[self insetForLone]];
            }
        }
            break;
        case SeparatorTypeDefaultBottomNone: {
            NSInteger rowCount = [self numberOfRowsInSection:indexPath.section];
            if (rowCount != (indexPath.row + 1)) {
                [self setCell:cell separatorMargins:[self insetForLone]];
            } else {
                [self setCell:cell separatorMargins:[self insetForNone]];
            }
        }
            break;
        case SeparatorTypeBottomLong: {
            NSInteger rowCount = [self numberOfRowsInSection:indexPath.section];
            if (rowCount != (indexPath.row + 1)) {
                [self setCell:cell separatorMargins:[self insetForNone]];
            } else {
                [self setCell:cell separatorMargins:[self insetForLone]];
            }
        }
            break;
        case SeparatorTypeAllLeftShort: {
            [self setCell:cell separatorMargins:[self insetForLeftShort]];
        }
            break;
        case SeparatorTypeCenterShort: {
            NSInteger rowCount = [self numberOfRowsInSection:indexPath.section];
            if (rowCount != (indexPath.row + 1)) {
                [self setCell:cell separatorMargins:[self insetForLeftShort]];
            } else {
                [self setCell:cell separatorMargins:[self insetForNone]];
            }
        }
            break;
        case SeparatorTypeDefaultAllNone: {
            [self setCell:cell separatorMargins:[self insetForNone]];
        }
            break;
        case SeparatorTypeExSubmit: {
            NSInteger rowCount = [self numberOfRowsInSection:indexPath.section];
            if (rowCount == (indexPath.row + 2)) {
                [self setCell:cell separatorMargins:[self insetForLone]];
            } else if (rowCount == (indexPath.row + 1)) {
                [self setCell:cell separatorMargins:[self insetForNone]];
            } else {
                [self setCell:cell separatorMargins:[self insetForLeftShort]];
            }
        }
            break;
        case SeparatorTypeFirstNoneOtherLong: {
            if (indexPath.row == 0) {
                [self setCell:cell separatorMargins:[self insetForNone]];
            } else {
                [self setCell:cell separatorMargins:[self insetForLone]];
            }
        }
            break;
        default:
            break;
    }
}

// private 隐藏多余的view
- (void)sp_setExtraCellLineHidden {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}

// private
- (void)setCell:(UITableViewCell *)cell separatorMargins:(UIEdgeInsets)inset {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:inset];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

// private
- (UIEdgeInsets)insetForLeftShort {
    return UIEdgeInsetsMake(0, 10, 0, 0);
}

// private
- (UIEdgeInsets)insetForLone {
    return UIEdgeInsetsZero;
}

// private
- (UIEdgeInsets)insetForNone {
    return UIEdgeInsetsMake(0, [UIScreen mainScreen].bounds.size.width, 0, 0);
}

@end
