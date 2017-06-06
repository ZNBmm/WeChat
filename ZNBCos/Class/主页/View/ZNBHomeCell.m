//
//  ZNBHomeCell.m
//  ZNBCos
//
//  Created by mac on 2017/5/26.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBHomeCell.h"
#import "ZNBHomeModel.h"

@interface ZNBHomeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *indicateLabel;

@end
@implementation ZNBHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ZNBHomeModel *)model {
    _model = model;
    self.indicateLabel.text = model.title;
//    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:model.title attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick|NSUnderlinePatternSolid)}];
//    self.indicateLabel.attributedText = attr;
    
    self.iconImage.image = [UIImage imageNamed:model.iconImage];
    self.contentView.backgroundColor = [UIColor colorWithHexString:model.colorHex];
}
- (void)setFrame:(CGRect)frame {

    frame.size.width -= 40;
    frame.size.height  -= 10;
    frame.origin.x = 20;
    frame.origin.y += 10;
    [super setFrame:frame];
}

@end
