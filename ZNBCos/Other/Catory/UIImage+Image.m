//
//  UIImage+Image.m
//  图片生成
//
//  Created by mac on 16/7/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (UIImage *)imageWithFrame:(CGRect)frame color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.backgroundColor = color;
    imageView.layer.cornerRadius = cornerRadius;
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [imageView.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
//    NSData *data = UIImagePNGRepresentation(newImage);
//    [data writeToFile:@"/Users/mac/Desktop/图片生成.image1.png" atomically:YES];
    return newImage;
}
+ (UIImage *)resizableImageWithColor:(UIColor*)color cornerRadius:(CGFloat)cornerRadius {
    UIImage *image = [UIImage imageWithFrame:CGRectMake(0, 0, cornerRadius*2, cornerRadius*2) color:color cornerRadius:cornerRadius];
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

/** 压缩图片到指定的物理大小*/
- (NSData *)compressImageDataWithMaxLimit:(CGFloat)maxLimit {
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.2f; // 最大压缩品质
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    NSInteger imageDataLength = [imageData length];
    while ((imageDataLength <= maxLimit * 1024 * 1024) && (compression >= maxCompression)) {
        compression -= 0.03;
        imageData = UIImageJPEGRepresentation(self, compression);
        imageDataLength = [imageData length];
    }
    return imageData;
}

- (UIImage *)compressImageWithMaxLimit:(CGFloat)maxLimit {
    NSData *imageData = [self compressImageDataWithMaxLimit:maxLimit];
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

// 头像类型
+ (UIImage *)circleImageWithname:(NSString *)name borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor {
    
    
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 1. 开启上下文
    CGFloat imageW = oldImage.size.width + 22 * borderWidth;
    CGFloat imageH = oldImage.size.height + 22 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH    );
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 花边框，大圆
    [borderColor set];
    
    CGFloat bigRadius = imageW * 0.5f;
    CGFloat centerX = bigRadius;
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    // 小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    CGContextClip(ctx);
    
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 指定大小，要把图显示到多大的区域
- (UIImage *)sourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0f;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointZero;
    
    if(CGSizeEqualToSize(imageSize, targetSize) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if (!newImage) {
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 指定宽度，按比例缩放
- (UIImage *)sourceImage:(UIImage *)sourceImage targetWidth:(CGFloat)targetWidth {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


+ (UIImage *)resizableImageWithImageName:(NSString *)imageName {
    UIImage *loginImage = [UIImage imageNamed:imageName];
    CGFloat topEdge = loginImage.size.height * 0.5;
    CGFloat leftEdge = loginImage.size.width * 0.5;
    return [loginImage resizableImageWithCapInsets:UIEdgeInsetsMake(topEdge, leftEdge, topEdge, leftEdge) resizingMode:UIImageResizingModeStretch];
}

// 根据指定比例缩放图片
- (UIImage *)sourceImage:(UIImage *)sourceImage scale:(CGFloat)scale {
    if (scale > 1) {
        return sourceImage;
    }
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGPoint targetPoint = CGPointZero;
    targetPoint.x = (imageSize.width - imageSize.width * scale) * 0.5f;
    targetPoint.y = (imageSize.height - imageSize.height * scale) * 0.5f;
    UIGraphicsBeginImageContext(imageSize);
    CGFloat imageW = imageSize.width;
    CGFloat imageH = imageSize.height;
    CGFloat targetWidth = imageW * scale;
    CGFloat targetHeight = imageH * scale;
    CGRect targetRect = (CGRect){targetPoint, CGSizeMake(targetWidth, targetHeight)};
    [sourceImage drawInRect:targetRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (!newImage) {
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (UIImage *)imageWithControlPoint:(CGFloat)controlPointX curvature:(CGFloat)scale image:(UIImage *)image {
    
    CGSize size = CGSizeMake(image.size.width, image.size.height);
    CGFloat height = size.height*scale;
    UIGraphicsBeginImageContext(size);
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(image.size.width, 0)];
    [path addLineToPoint:CGPointMake(image.size.width, image.size.height - height)];
    [path addQuadCurveToPoint:CGPointMake(0, size.height- height) controlPoint:CGPointMake(controlPointX, size.height)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addClip];
    
    [image drawAtPoint:CGPointMake(0, 0)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
- (UIImage *)drawPiucureFrontImage:(UIImage *)personImage backImage:(UIImage *)hatImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha margin:(CGFloat)margin
{
    CGSize newSize =[personImage size];
    UIGraphicsBeginImageContext(newSize);
    [personImage drawInRect:CGRectMake(margin,margin,newSize.width-2*margin,newSize.height-2*margin) blendMode:kCGBlendModeNormal alpha:1];
    [hatImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:blendMode alpha:alpha];
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
