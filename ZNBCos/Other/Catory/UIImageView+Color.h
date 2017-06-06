//
//  UIImageView+Color.h
//  ZNBCos
//
//  Created by mac on 2017/5/31.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Color)
- (UIColor *) getPixelColorAtLocation:(CGPoint)point;
- (UIColor *)colorAtPixel:(CGPoint)point;
@end
