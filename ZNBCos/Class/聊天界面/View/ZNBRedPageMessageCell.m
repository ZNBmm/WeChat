//
//  ZNBRedPageMessageCell.m
//  ZNBCos
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBRedPageMessageCell.h"

@interface ZNBRedPageMessageCell ()
/** 头像 */
@property (nonatomic, strong) UIImageView *iconImageView;
/** 收钱image */
@property (nonatomic, strong) UIImageView *moneyStateImage;
@property (strong, nonatomic) UILabel *moneyLabel;

@property (nonatomic, strong) UIImageView *contentBg;

//contacts_helloword
/** 文本消息 */
@property (nonatomic, strong) YYLabel     *messageTextLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@end

@implementation ZNBRedPageMessageCell
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
        _messageTextLabel.textColor = [UIColor whiteColor];
        _messageTextLabel.font = kFontSize(15);
        _messageTextLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_messageTextLabel];
    }
    return _messageTextLabel;
}
- (UIImageView *)contentBg
{
    if (_contentBg == nil) {
        _contentBg = [[UIImageView alloc] init];
        [self addSubview:_contentBg];

    }
    return _contentBg;
}

- (UIImageView *)moneyStateImage
{
    if (_moneyStateImage == nil) {
        _moneyStateImage = [[UIImageView alloc] init];
        [self addSubview:_moneyStateImage];
    }
    return _moneyStateImage;
}
- (UILabel *)moneyLabel
{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        [self addSubview:_moneyLabel];
        _moneyLabel.font = [UIFont systemFontOfSize:11];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _moneyLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.backgroundColor = ZNBColor(200, 200, 200);
        _timeLabel.text = @" 昨天 下午7:43 ";
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.layer.cornerRadius = 3;
        _timeLabel.layer.masksToBounds = YES;
        
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    
    return self;
}
- (void)setViewModel:(ZNBChatMessageViewModel *)viewModel {
    _viewModel = viewModel;
    self.iconImageView.image = viewModel.avatar;
    self.messageTextLabel.text = viewModel.model.messageContent;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",viewModel.model.money];
    if ([viewModel.model.messageContent isEqualToString:@"微信转账"]) {
        self.moneyStateImage.image = [UIImage imageNamed:@"C2C_Transfer_Icon"];
        
    }else {
        self.moneyStateImage.image = [UIImage imageNamed:@"sharecard_done"];
    }
    
    
}
- (void)initUI {
    
    [self contentBg];
    [self iconImageView];
    [self messageTextLabel];
    [self moneyStateImage];
    [self moneyLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (self.viewModel.timeStr.length) {
        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(20);
            make.height.equalTo(@17);
            
        }];
    }else {
        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(0);
            make.height.equalTo(@0);
            
        }];
    }
    
    if (self.viewModel.messageType == ZNBChatMessageTypeMe) {
        
        self.contentBg.image = [self resizableImageWithImageName:@"zhuanzhuang_from"];
        
        [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-kLeftMargin);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(10*kScale);
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
            make.left.equalTo(self.moneyStateImage.mas_right).offset(kDefaultMargin);
            make.top.equalTo(self.moneyStateImage);
        }];
  
        [self.moneyStateImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentBg).offset(kDefaultMargin);
            make.centerY.equalTo(self.contentBg).offset(-10);
            make.width.height.equalTo(@(kAvatarSize));
        }];
        
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.messageTextLabel);
            make.top.equalTo(self.messageTextLabel.mas_bottom).offset(3*kScale);
            
        }];
        
    }else if (self.viewModel.messageType == ZNBChatMessageTypeOther) {
        
        
        self.contentBg.image = [self resizableImageWithImageName:@"zhuanzhang_to"];
      
        [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kLeftMargin);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(10*kScale);
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
            make.left.equalTo(self.moneyStateImage.mas_right).offset(kDefaultMargin);
            make.top.equalTo(self.moneyStateImage);
        }];
        [self.moneyStateImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentBg).offset(kDefaultMargin+3);
            make.centerY.equalTo(self.contentBg).offset(-10);
            make.width.height.equalTo(@(kAvatarSize));
        }];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.messageTextLabel);
            make.top.equalTo(self.messageTextLabel.mas_bottom).offset(3*kScale);
            
        }];
    }
    

    
}


- (UIImage *)resizableImageWithImageName:(NSString *)imageName {
    
    UIImage *loginImage = [UIImage imageNamed:imageName];
    CGFloat topEdge = loginImage.size.height * 0.49;
    CGFloat bottomEdge = loginImage.size.height * 0.49;
    CGFloat leftEdge = loginImage.size.width * 0.49;
    CGFloat rightEdge = loginImage.size.width * 0.49;
    return [loginImage resizableImageWithCapInsets:UIEdgeInsetsMake(topEdge, leftEdge, bottomEdge, rightEdge) resizingMode:UIImageResizingModeStretch];
}


@end
