//
//  ZNBLikeBGView.m
//  ZNBCos
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBLikeBGView.h"

@implementation ZNBLikeBGView

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    UIImage *loginImage = [UIImage imageNamed:@"moments_bg"];
    CGFloat topEdge = loginImage.size.height * 0.4;
    CGFloat leftEdge = loginImage.size.width * 0.4;
    UIImage *image = [loginImage resizableImageWithCapInsets:UIEdgeInsetsMake(topEdge, leftEdge, topEdge, leftEdge)];
    
    [image drawInRect:rect];
    
}

@end
