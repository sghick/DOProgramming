//
//  WCDBModel.h
//  WCDBLib
//
//  Created by WuBo on 16/6/29.
//  Copyright © 2016年 WeiChe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCDBModel : NSObject

@property (nonatomic, copy) NSArray *objects; /**< 需要插入的对象 */
@property (nonatomic, copy) NSArray *keys; /**< 指定表中的主键 */

@end
