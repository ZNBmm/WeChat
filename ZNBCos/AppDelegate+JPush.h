//
//  AppDelegate+JPush.h
//  ZNBCos
//
//  Created by mac on 2017/7/10.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "AppDelegate.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate (JPush)

- (void)znb_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions ;

- (void)skipToWeb:(NSDictionary*)userInfo;
@end
