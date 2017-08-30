//
//  AppDelegate+JPush.m
//  ZNBCos
//
//  Created by mac on 2017/7/10.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import "ZNBWebViewController.h"
#import "ZNBNavigationController.h"
@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate (JPush)

- (void)znb_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
}

- (void)skipToWeb:(NSDictionary *)userInfo {

    ZNBNavigationController *nav = (ZNBNavigationController *)self.window.rootViewController;
    ZNBWebViewController *webVc = [[ZNBWebViewController alloc] init];
    webVc.url = userInfo[@"targetUrl"];
    
    [nav pushViewController:webVc animated:YES];
    
}

@end
