//
//  ZNBQRCodeImage.h
//  ZNBCos
//
//  Created by mac on 2017/5/26.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNBQRCodeImage : UIImage
/**
 *  1.生成一个二维码
 *
 *  @param string 字符串
 *  @param width  二维码宽度
 *
 *  @return 生成一个二维码
 */
+ (ZNBQRCodeImage *_Nonnull)codeImageWithString:(NSString *_Nullable)string
                                        size:(CGFloat)width;

/**
 *  2.生成一个二维码
 *
 *  @param string 字符串
 *  @param width  二维码宽度
 *  @param color  二维码颜色
 *
 *  @return 生成一个二维码
 */
+ (ZNBQRCodeImage *_Nonnull)codeImageWithString:(NSString *_Nullable)string
                                        size:(CGFloat)width
                                       color:(UIColor *_Nullable)color;
/**
 *  3.生成一个二维码
 *
 *  @param string    字符串
 *  @param width     二维码宽度
 *  @param color     二维码颜色
 *  @param icon      头像
 *  @param iconWidth 头像宽度，建议宽度小于二维码宽度的1/4
 *
 *  @return 生成一个二维码
 */
+ (ZNBQRCodeImage *_Nonnull)codeImageWithString:(NSString *_Nullable)string
                                        size:(CGFloat)width
                                       color:(UIColor *_Nullable)color
                                        icon:(UIImage *_Nullable)icon
                                   iconWidth:(CGFloat)iconWidth;

+ (ZNBQRCodeImage *_Nonnull)codeImageWithString:(NSString *_Nullable)string
                                           size:(CGFloat)width
                                          color:(UIColor *_Nullable)color
                                           icon:(UIImage *_Nullable)icon
                                iconBorderColor:(UIColor *_Nullable)borderColor
                                iconBorderWidth:(CGFloat)borderWidth
                                      iconWidth:(CGFloat)iconWidth;

@end
