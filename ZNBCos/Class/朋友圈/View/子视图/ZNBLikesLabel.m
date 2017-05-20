//
//  ZNBLikesLabel.m
//  ZNBCos
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBLikesLabel.h"

@implementation ZNBLikesLabel

- (void)drawRect:(CGRect)rect {

    UIImage *loginImage = [UIImage imageNamed:@"moments_bg"];
    CGFloat topEdge = loginImage.size.height * 0.4;
    CGFloat leftEdge = loginImage.size.width * 0.4;
    UIImage *image = [loginImage resizableImageWithCapInsets:UIEdgeInsetsMake(topEdge, leftEdge, topEdge, leftEdge)];

    [image drawInRect:rect];
    
    [super drawRect:rect];
}


@end
