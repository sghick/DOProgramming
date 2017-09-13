//
//  UIView+WCReuseObject.h
//  AstonMartin
//
//  Created by 丁治文 on 16/11/28.
//  Copyright © 2016年 WeiChe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WCReuseDelegate <NSObject>

- (void)registerClass:(Class)viewClass forViewReuseIdentifier:(NSString *)identifier;
- (__kindof UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier;

@end

@interface UIView (WCReuseObject)

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier;

@end
