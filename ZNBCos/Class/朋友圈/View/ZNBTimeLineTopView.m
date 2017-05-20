//
//  ZNBTimeLineTopView.m
//  ZNBCos
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBTimeLineTopView.h"

@interface ZNBTimeLineTopView ()
@property (weak, nonatomic) IBOutlet UIView *avatarContent;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarWidth;

@end
@implementation ZNBTimeLineTopView
+ (instancetype)timeLineTopView {
    return [self viewForXib];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _avatarContent.layer.borderColor = ZNBColor(240, 240, 240).CGColor;
    _avatarContent.layer.borderWidth = 0.5;
    _avatarWidth.constant = 72*kScale;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (self.topClickBlock) {
        self.topClickBlock();
    }
}
@end
