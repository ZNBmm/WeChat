//
//  UIImage+Render.m
//  BuDeJie01
//
//  Created by mac on 16/7/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)


+ (UIImage *)imageWithOriginalRender:(NSString *)imageName {


    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
