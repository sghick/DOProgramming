//
//  UIView+WCReuseObject.m
//  AstonMartin
//
//  Created by 丁治文 on 16/11/28.
//  Copyright © 2016年 WeiChe. All rights reserved.
//

#import "UIView+WCReuseObject.h"
#import <objc/runtime.h>

static char reuseIdentifierKey;

@implementation UIView (WCReuseObject)

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [self init];
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    self = [self initWithFrame:frame];
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

#pragma mark - Getters/Setters
- (NSString *)reuseIdentifier {
    return objc_getAssociatedObject(self, &reuseIdentifierKey);
}

- (void)setReuseIdentifier:(NSString *)reuseIdentifier {
    objc_setAssociatedObject(self, &reuseIdentifierKey, reuseIdentifier, OBJC_ASSOCIATION_RETAIN);
}

@end
