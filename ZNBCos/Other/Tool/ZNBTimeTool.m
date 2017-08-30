//
//  ZNBTimeTool.m
//  ZNBCos
//
//  Created by mac on 2017/8/28.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBTimeTool.h"
#import "NSDate+Date.h"
@implementation ZNBTimeTool

+ (NSString *)dateStringWithDate:(NSDate *)date {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSString *timeStr;
    if ([date isThisYear]) {
        if ([date isThisToday]) {
            
            fmt.dateFormat = @"HH";
            NSString *hour = [fmt stringFromDate:date];
            int timeValue = [hour intValue];
            if (timeValue > 12) {
                timeValue = timeValue - 12;
                fmt.dateFormat = @"mm";
                NSString *tempTime = [fmt stringFromDate:date];
                timeStr = [NSString stringWithFormat:@" 下午 %d:%@ ",timeValue,tempTime];
            }else if(timeValue == 12) {
                fmt.dateFormat = @"mm";
                NSString *tempTime = [fmt stringFromDate:date];
                timeStr = [NSString stringWithFormat:@" 中午 %d:%@ ",timeValue,tempTime];
            }else {
                fmt.dateFormat = @"mm";
                NSString *tempTime = [fmt stringFromDate:date];
                timeStr = [NSString stringWithFormat:@" 上午 %d:%@ ",timeValue,tempTime];
            }
            
        } else if ([date isThisYesterday]) { // 昨天
            // 昨天 21:10
            
            fmt.dateFormat = @" 昨天 HH:mm ";
            timeStr = [fmt stringFromDate:date];
            
        } else { // 昨天之前 08-05 21:10:08
            fmt.dateFormat = @" yyyy-MM-dd HH:mm ";
            timeStr = [fmt stringFromDate:date];
        }
    }else {
        fmt.dateFormat = @" yyyy-MM-dd HH:mm ";
        timeStr = [fmt stringFromDate:date];
    }
    
    return timeStr;
}
@end
