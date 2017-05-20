//
//  ZNBRaiseCmtView.h
//  ZNBCos
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNBRaiseCmtView : UIView
@property (weak, nonatomic) IBOutlet UIButton *raiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *cmtBtn;
+ (instancetype)raiseCmtView;
@end
