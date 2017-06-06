//
//  ZNBQRBottomToolView.h
//  ZNBCos
//
//  Created by mac on 2017/5/30.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNBQRBottomToolView : UIView
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *middleBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

+ (instancetype)bottomToolView;
@end
