//
//  WCPureLayoutObject.m
//  AstonMartin
//
//  Created by buding on 16/4/13.
//  Copyright © 2016年 Buding WeiChe. All rights reserved.
//

#import "WCPureLayoutObject.h"
#import "PureLayout.h"

@implementation WCPureLayoutObject

- (instancetype)initWithConstraints:(NSArray<NSLayoutConstraint *> *)constraints didInstalled:(BOOL)didInstalled {
    self = [super init];
    if (self) {
        _constraints = constraints;
        _didInstallled = didInstalled;
    }
    return self;
}

- (void)autoRemoveConstraints {
    if (_didInstallled) {
        _didInstallled = NO;
        [self.constraints autoRemoveConstraints];
    }
}

- (void)autoInstallConstraints {
    _didInstallled = YES;
    [self.constraints autoInstallConstraints];
}

+ (instancetype)autoCreateAndInstallConstraints:(ALConstraintsBlock)block {
    NSArray *constraints = [NSLayoutConstraint autoCreateAndInstallConstraints:block];
    WCPureLayoutObject *rtn = [[WCPureLayoutObject alloc] initWithConstraints:constraints didInstalled:YES];
    return rtn;
}

+ (instancetype)autoCreateConstraintsWithoutInstalling:(ALConstraintsBlock)block {
    NSArray *constraints = [NSLayoutConstraint autoCreateConstraintsWithoutInstalling:block];
    WCPureLayoutObject *rtn = [[WCPureLayoutObject alloc] initWithConstraints:constraints didInstalled:NO];
    return rtn;
}

@end
