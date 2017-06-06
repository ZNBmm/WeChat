//
//  UIImage+Image.h
//  图片生成
//
//  Created by mac on 16/7/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
/** 返回一张自定义颜色圆角拉伸的图片 */
+ (UIImage *)resizableImageWithColor:(UIColor*)color cornerRadius:(CGFloat)cornerRadius;

/** 返回一张自定义颜色,尺寸,圆角的颜色图片 */
+ (UIImage *)imageWithFrame:(CGRect)frame color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;


+ (UIImage *)circleImageWithname:(NSString *)name
                     borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor;

/**
 *  保持宽高比设置图片在多大区域显示
 */
- (UIImage *)sourceImage:(UIImage *)sourceImage
              targetSize:(CGSize)targetSize;

/**
 *  指定宽度按比例缩放
 */
- (UIImage *)sourceImage:(UIImage *)sourceImage
             targetWidth:(CGFloat)targetWidth;

/**
 *  等比例缩放
 */
- (UIImage *)sourceImage:(UIImage *)sourceImage
                   scale:(CGFloat)scale;


+ (UIImage *)resizableImageWithImageName:(NSString *)imageName;




/**
 返回一张底部带有弧度的图片
 
 @param controlPointX 水平控制点
 @param scale 竖直方向弯曲率
 @param image 源图片
 @return 弧度图片
 */
+ (UIImage *)imageWithControlPoint:(CGFloat)controlPointX curvature:(CGFloat)scale image:(UIImage *)image;

/** 压缩图片到指定的物理大小*/
- (NSData *)compressImageDataWithMaxLimit:(CGFloat)maxLimit;

- (UIImage *)compressImageWithMaxLimit:(CGFloat)maxLimit;

- (UIImage *)drawPiucureFrontImage:(UIImage *)personImage backImage:(UIImage *)hatImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha margin:(CGFloat)margin;
@end
