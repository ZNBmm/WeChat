//
//  ZNBHomeTopView.m
//  ZNBCos
//
//  Created by mac on 2017/5/26.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBHomeTopView.h"

@interface ZNBHomeTopView ()

@property (weak, nonatomic) IBOutlet UIView *contentview;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHeight;

@end
@implementation ZNBHomeTopView

- (SXWaveCell *)waveCell
{
    if (_waveCell == nil) {
        SXWaveCell *cell = [SXWaveCell cell];
        _waveCell = cell;
        cell.endless = YES;
        [_waveCell setPrecent:0 textColor:[UIColor orangeColor] type:0 alpha:1];
        [_waveCell addAnimateWithType:0];
        [_contentview addSubview:cell];
    }
    return _waveCell;
}
-(void)awakeFromNib {
    [super awakeFromNib];
    [self waveCell];
    
}
- (void)upDateWaveCellWithPresent:(int)present {
    [_waveCell removeFromSuperview];
    _waveCell = nil;
    [self.waveCell setPrecent:present textColor:[UIColor orangeColor] type:0 alpha:1];
    [self.waveCell addAnimateWithType:0];
    [self layoutSubviews];
}
+ (instancetype)shareView {
    
    return [self viewForXib];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.waveCell.frame = CGRectMake(0, 0, self.contentview.znb_width, kScale*145);
    _labelHeight.constant = kScale*105;
    NSLog(@"%f",self.waveCell.znb_width);
}


@end
