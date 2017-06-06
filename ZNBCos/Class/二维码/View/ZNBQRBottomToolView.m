//
//  ZNBQRBottomToolView.m
//  ZNBCos
//
//  Created by mac on 2017/5/30.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBQRBottomToolView.h"

@interface ZNBQRBottomToolView ()
@property (strong, nonatomic) CALayer *topLayer;
@property (strong, nonatomic) CALayer *midLeftLayer;
@property (strong, nonatomic) CALayer *midRightLayer;
@end
@implementation ZNBQRBottomToolView

- (CALayer *)topLayer
{
    if (_topLayer == nil) {
        _topLayer = [CALayer layer];
        _topLayer.backgroundColor = ZNBColor(240, 240, 240).CGColor;
        [self.layer addSublayer:_topLayer];
    }
    return _topLayer;
}
- (CALayer *)midLeftLayer
{
    if (_midLeftLayer == nil) {
        _midLeftLayer = [CALayer layer];
        _midLeftLayer.backgroundColor = ZNBColor(240, 240, 240).CGColor;
        [self.layer addSublayer:_midLeftLayer];
    }
    return _midLeftLayer;
}
- (CALayer *)midRightLayer
{
    if (_midRightLayer == nil) {
        _midRightLayer = [CALayer layer];
        _midRightLayer.backgroundColor = ZNBColor(240, 240, 240).CGColor;
        [self.layer addSublayer:_midRightLayer];
    }
    return _midRightLayer;
}
+ (instancetype)bottomToolView {

    return [self viewForXib];
}


- (void)layoutSubviews {

    [super layoutSubviews];
    self.topLayer.frame = CGRectMake(0, 0, kScreenW, 1);
    self.midRightLayer.frame = CGRectMake(kScreenW/3.0, 5, 1, 39);
    self.midLeftLayer.frame = CGRectMake(2*(kScreenW/3), 5, 1, 39);
}
@end
