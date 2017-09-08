//
//  AppDelegate.h
//  DOProgramming
//
//  Created by 丁治文 on 2017/9/7.
//  Copyright © 2017年 dingzhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DONavigationViewDemand.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) DONavigationViewDemand *navigatorDemand;
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

