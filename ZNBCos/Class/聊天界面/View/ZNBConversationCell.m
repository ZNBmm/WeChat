//
//  ZNBConversationCell.m
//  ZNBCos
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBConversationCell.h"
#import "ZNBChatConversationModel.h"

@interface ZNBConversationCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nick;

@end
@implementation ZNBConversationCell

- (void)setModel:(ZNBChatConversationModel *)model {
    _model = model;
    self.avatar.image = [UIImage imageWithData:model.toImage];
    self.nick.text = model.to;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.avatar.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}
- (void)setFrame:(CGRect)frame {

    
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
