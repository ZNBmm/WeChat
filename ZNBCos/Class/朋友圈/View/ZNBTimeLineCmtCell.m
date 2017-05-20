//
//  ZNBTimeLineCmtCell.m
//  ZNBCos
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBTimeLineCmtCell.h"

@implementation ZNBTimeLineCmtCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.contentLabel];
        self.contentLabel.backgroundColor  = [UIColor clearColor];
        self.contentLabel.preferredMaxLayoutWidth = kCmtLabelWidth;
        self.backgroundColor = [UIColor clearColor];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(5);
            make.right.mas_equalTo(self.contentView).offset(-5);
            make.top.mas_equalTo(self.contentView).offset(3.0);//cell上部距离为3.0个间隙
        }];
        
        self.hyb_lastViewInCell = self.contentLabel;
        self.hyb_bottomOffsetToCell = 3.0;//cell底部距离为3.0个间隙
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
