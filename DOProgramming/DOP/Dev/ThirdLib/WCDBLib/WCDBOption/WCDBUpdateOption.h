//
//  WCDBUpdateOption.h
//  WCDBLib
//
//  Created by 丁治文 on 2017/2/17.
//  Copyright © 2017年 WeiChe. All rights reserved.
//

#import "WCDBOption.h"

@interface WCDBUpdateOption : WCDBOption

/**
 Optional,表名
 default:object.class
 */
@property (copy  , nonatomic) NSString  *tableName;

/**
 要被修改的数据源
 default:nil
 */
@property (strong, nonatomic) NSObject  *object;

/**
 Optional,为sql添加条件
 default:nil
 如:
 where ...
 limit ...
 order by ...
 参数写成 key=:keyname,并在params中传入
 */
@property (copy  , nonatomic) NSString  *where;

/**
 初始化方法
 
 @param obj 要修改的model
 @return UpdateOption对象
 */
- (instancetype)initWithObject:(NSObject *)obj;

@end
