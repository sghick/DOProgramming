//
//  UITableView+Separator.h
//  SeperatorLine
//
//  Created by 丁治文 on 16/7/11.
//  Copyright © 2016年 丁治文. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  线的样式,所有样式中的线都在cell的下方,cell上方的线请自行添加
 */
typedef NS_ENUM(NSInteger, SeparatorType) {
    /**
     *  全部为长线
     *  ---------
     *  ---------
     *  ---------
     *  ---------
     *  ---------
     */
    SeparatorTypeDefault,
    
    /**
     *  尾部为长线,中间为短线
     *   --------
     *   --------
     *   --------
     *   --------
     *  ---------
     */
    SeparatorTypeLeftShort,
    
    /**
     *  尾部没有线,中间为长线
     *  ---------
     *  ---------
     *  ---------
     *
     */
    SeparatorTypeDefaultBottomNone,
    
    /**
     *  尾部有线,首部和中间没有线
     *
     *
     *
     *  ---------
     */
    SeparatorTypeBottomLong,
    
    /**
     *  全部为短线
     *   --------
     *   --------
     *   --------
     *   --------
     *   --------
     */
    SeparatorTypeAllLeftShort,
    
    /**
     *  尾部没有线,中间为短线
     *   --------
     *   --------
     *   --------
     *   --------
     *
     */
    SeparatorTypeCenterShort,
    
    /**
     *  没有线
     */
    SeparatorTypeDefaultAllNone,
    
    // ================== 其它样式 ================//
    /**
     *  倒数第二为长线,中间为短线,最后为无线
     *   --------
     *   --------
     *   --------
     *   --------
     *  ---------
     *
     */
    SeparatorTypeExSubmit,
    /**
     *  第一根没线，其他都为长线
     *  
     *  ---------
     *  ---------
     *  ---------
     *  ---------
     */
    SeparatorTypeFirstNoneOtherLong,
};

@interface UITableView (Separator)

/**
 *  标记使用自定义type的线,并隐藏系统多余的线条(必须)
 *  推荐写在初始化方法中
 */
- (void)sp_markCustomTableViewSeparators;

/**
 *  推荐写在下面方法中(必须)
 *  - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
 *
 *  @param separatorsType 线的样式
 *  @param cell           cell
 *  @param indexPath      所在的indexPath
 */
- (void)sp_setSeparatorsType:(SeparatorType)separatorsType cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end
