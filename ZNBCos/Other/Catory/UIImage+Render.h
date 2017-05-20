//
//  UIImage+Render.h
//  BuDeJie01
//
//  Created by mac on 16/7/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Render)

// 声明完一个方法后不要急于实现,应该在外界先调用
// 传递一个图片名称给我,返回一个没有被渲染的图片
+ (UIImage *)imageWithOriginalRender:(NSString *)imageName;
@end
