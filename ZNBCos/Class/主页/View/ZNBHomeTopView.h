//
//  ZNBHomeTopView.h
//  ZNBCos
//
//  Created by mac on 2017/5/26.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXWaveCell.h"
@interface ZNBHomeTopView : UIView
@property(nonatomic,strong)SXWaveCell *waveCell;
+ (instancetype)shareView;
- (void)upDateWaveCellWithPresent:(int)present ;
@end
