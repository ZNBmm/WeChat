//
//  ZNBChatMessageCell.m
//  ZNBCos
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBChatMessageCell.h"

@interface ZNBChatMessageCell ()
/** 头像 */
@property (nonatomic, strong) UIImageView *iconImageView;
/** 用户名 */
@property (nonatomic, strong) UILabel     *usernameLabel;
/** 文本消息 */
@property (nonatomic, strong) YYLabel     *messageTextLabel;
/** 图片消息 */
@property (nonatomic, strong) UIImageView *messageImageView;
/** 图片消息 */
@property (nonatomic, strong) UIImageView *contentBg;

@end
@implementation ZNBChatMessageCell
- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"znb 2"];
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}
- (YYLabel *)messageTextLabel
{
    if (_messageTextLabel == nil) {
        _messageTextLabel = [[YYLabel alloc] init];
        _messageTextLabel.numberOfLines = 0;
        _messageTextLabel.textColor = ZNBColor(33, 33, 33);
        _messageTextLabel.font = [UIFont systemFontOfSize:16];
        _messageTextLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        [self addSubview:_messageTextLabel];
    }
    return _messageTextLabel;
}
- (UIImageView *)messageImageView
{
    if (_messageImageView == nil) {
        _messageImageView = [[UIImageView alloc] init];
        [self addSubview:_messageImageView];
    }
    return _messageImageView;
}
- (UIImageView *)contentBg
{
    if (_contentBg == nil) {
        _contentBg = [[UIImageView alloc] init];
        
        [self addSubview:_contentBg];
        
    }
    return _contentBg;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI {

    [self contentBg];
    [self iconImageView];
    [self messageImageView];
    [self messageTextLabel];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setViewModel:(ZNBChatMessageViewModel *)viewModel {
    _viewModel = viewModel;
    self.iconImageView.image = viewModel.avatar;
    self.messageTextLabel.text = viewModel.model.messageContent;
    self.messageImageView.image = [UIImage imageWithData:viewModel.model.messageImage];
    
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    if (self.viewModel.messageType == ZNBChatMessageTypeMe) {
       
        self.contentBg.image = [self resizableImageWithImageName:@"SenderTextNodeBkg"];
        self.contentBg.highlightedImage = [self resizableImageWithImageName:@"SenderTextNodeBkgHL"];
        [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-kLeftMargin);
            make.top.equalTo(self).offset(kTopMargin);
            make.width.equalTo(@(kAvatarSize));
            make.height.equalTo(@(kAvatarSize));
        }];
        
        [self.contentBg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.iconImageView.mas_left).offset(-kRightMargin);
            make.top.equalTo(self.iconImageView);
            make.height.equalTo(@(self.viewModel.messageBgHeight));
            make.width.equalTo(@(self.viewModel.messageBgWidth));
        }];
        
        [self.messageTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentBg.mas_left).offset(kDefaultMargin);
            make.top.equalTo(self.contentBg).offset(kDefaultMargin);
            make.height.equalTo(@(self.viewModel.messageHeight));
            make.width.equalTo(@(self.viewModel.messageWidth));
            
        }];
        [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentBg.mas_left).offset(kDefaultMargin);
            make.top.equalTo(self.contentBg).offset(kDefaultMargin);
            make.height.equalTo(@(self.viewModel.messageHeight));
            make.width.equalTo(@(self.viewModel.messageWidth));
        }];
        
    }else if (self.viewModel.messageType == ZNBChatMessageTypeOther) {
        
       
        self.contentBg.image = [self resizableImageWithImageName:@"ReceiverTextNodeBkg"];
        
        self.contentBg.highlightedImage = [self resizableImageWithImageName:@"ReceiverTextNodeBkg"];
        [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kLeftMargin);
            make.top.equalTo(self).offset(kTopMargin);
            make.width.equalTo(@(kAvatarSize));
            make.height.equalTo(@(kAvatarSize));
        }];

        [self.contentBg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(kRightMargin);
            make.top.equalTo(self.iconImageView);
            make.height.equalTo(@(self.viewModel.messageBgHeight));
            make.width.equalTo(@(self.viewModel.messageBgWidth));
        }];
        
        [self.messageTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentBg.mas_left).offset(kDefaultMargin);
            make.top.equalTo(self.contentBg).offset(kDefaultMargin);
            make.height.equalTo(@(self.viewModel.messageHeight));
            make.width.equalTo(@(self.viewModel.messageWidth));
        }];
        [self.messageImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentBg.mas_left).offset(kDefaultMargin);
            make.top.equalTo(self.contentBg).offset(kDefaultMargin);
            make.height.equalTo(@(self.viewModel.messageHeight));
            make.width.equalTo(@(self.viewModel.messageWidth));
        }];
    }
    
    if (self.viewModel.model.messageImage) {
        self.messageTextLabel.hidden = YES;
        self.messageImageView.hidden = NO;
    }else {
        self.messageTextLabel.hidden = NO;
        self.messageImageView.hidden = YES;
    }
}


- (UIImage *)resizableImageWithImageName:(NSString *)imageName {

    UIImage *loginImage = [UIImage imageNamed:imageName];
    CGFloat topEdge = loginImage.size.height * 0.8;
    CGFloat bottomEdge = loginImage.size.height * 0.19;
    CGFloat leftEdge = loginImage.size.width * 0.5;
    CGFloat rightEdge = loginImage.size.width * 0.49;
    return [loginImage resizableImageWithCapInsets:UIEdgeInsetsMake(topEdge, leftEdge, bottomEdge, rightEdge) resizingMode:UIImageResizingModeStretch];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
