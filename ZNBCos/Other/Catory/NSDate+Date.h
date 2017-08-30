//
//  NSDate+Date.h
//  ZNBCos
//
//  Created by mac on 2017/8/28.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Date)
// 是否是今年
- (BOOL)isThisYear;

// 是否今天
- (BOOL)isThisToday;

// 是否昨天
- (BOOL)isThisYesterday;
@end
