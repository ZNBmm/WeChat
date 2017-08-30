//
//  NotificationService.h
//  ZNBPush
//
//  Created by mac on 2017/7/8.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max

#import <UserNotifications/UserNotifications.h>

@interface NotificationService : UNNotificationServiceExtension

@end
#endif
