//
//  DOObject.m
//  DOProgramming
//
//  Created by 丁治文 on 2017/9/7.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import "DOObject.h"

@interface DOObject ()

@end

@implementation DOObject

@synthesize identifier = _identifier;
@synthesize path = _path;
@synthesize dobjectMappers = _dobjectMappers;

- (void)dealloc {
    NSLog(@"释放了Demand:<%@,%p>", [self class], self);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"加载了Demand:<%@,%p>", [self class], self);
    }
    return self;
}

#pragma mark - DOProtocol

+ (instancetype)demand {
    return [self demandWithIdentifier:[NSUUID UUID].UUIDString];
}

+ (instancetype)demandWithIdentifier:(NSString *)identifier {
    DOObject *obj = [[self alloc] init];
    obj.identifier = identifier;
    return obj;
}

- (id<DOProtocol>)dobjectWithIdentifier:(NSString *)identifier {
    return self.dobjectMappers[identifier];
}

- (void)addDObject:(id<DOProtocol>)dobject {
    if (!dobject) {
        return;
    }
    self.dobjectMappers[dobject.identifier] = dobject;
}

- (NSMutableDictionary *)dobjectMappers {
    if (!_dobjectMappers) {
        _dobjectMappers = [NSMutableDictionary dictionary];
    }
    return _dobjectMappers;
}

@end
