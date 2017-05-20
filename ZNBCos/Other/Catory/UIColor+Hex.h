//
//  UIColor+Hex.h
//  颜色常识
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 ZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 * 从十六进制字符串获取颜色
 *  默认alpha位1
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 * 从十六进制字符串获取颜色
 * color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
