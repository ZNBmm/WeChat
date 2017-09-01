//
//  ZNBSettingCell.m
//  ZNBCos
//
//  Created by mac on 2017/8/31.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBSettingCell.h"

@interface ZNBSettingCell ()



@end

@implementation ZNBSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setFrame:(CGRect)frame {

    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
