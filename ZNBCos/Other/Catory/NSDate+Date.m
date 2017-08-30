//
//  NSDate+Date.m
//  ZNBCos
//
//  Created by mac on 2017/8/28.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "NSDate+Date.h"

@implementation NSDate (Date)
- (BOOL)isThisYear
{
    // 获取当前日期对象
    NSDate *curDate = [NSDate date];
    
    // 获取日历类
    NSCalendar *curCalendar = [NSCalendar currentCalendar];
    // 获取自己日期组件(年,月,等)
    NSDateComponents *selfCmp = [curCalendar components:NSCalendarUnitYear fromDate:self];
    
    // 获取当前时间日期组件(年,月,等)
    NSDateComponents *curCmp = [curCalendar components:NSCalendarUnitYear fromDate:curDate];
    
    return  curCmp.year == selfCmp.year;
}

// 判断是否是今天
- (BOOL)isThisToday
{
    // 获取日历类
    NSCalendar *curCalendar = [NSCalendar currentCalendar];
    
    return [curCalendar isDateInToday:self];
}

- (BOOL)isThisYesterday
{
    NSCalendar *curCalendar = [NSCalendar currentCalendar];
    
    return [curCalendar isDateInYesterday:self];
}
@end
