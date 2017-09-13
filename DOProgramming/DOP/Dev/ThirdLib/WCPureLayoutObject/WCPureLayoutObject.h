//
//  WCPureLayoutObject.h
//  AstonMartin
//
//  Created by buding on 16/4/13.
//  Copyright © 2016年 Buding WeiChe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PureLayoutDefines.h"

@interface WCPureLayoutObject : NSObject

/**
 *  约束
 */
@property (nonatomic, strong, readonly) NSArray<NSLayoutConstraint *> *constraints;

/**
 *  是否已经install过
 */
@property (nonatomic, assign, readonly) BOOL didInstallled;

- (instancetype)initWithConstraints:(NSArray<NSLayoutConstraint *> *)constraints didInstalled:(BOOL)didInstalled;

- (void)autoRemoveConstraints;
- (void)autoInstallConstraints;

+ (instancetype)autoCreateAndInstallConstraints:(ALConstraintsBlock)block;
+ (instancetype)autoCreateConstraintsWithoutInstalling:(ALConstraintsBlock)block;

@end
