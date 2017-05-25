//
//  ZNBChatMessageViewModel.m
//  ZNBCos
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBChatMessageViewModel.h"

@implementation ZNBChatMessageViewModel

+ (instancetype)viewModelWithModel:(ZNBChatMessageModel *)model {

    ZNBChatMessageViewModel *viewModel = [[self alloc] init];
    viewModel.model = model;
    
    return viewModel;
}

- (void)setModel:(ZNBChatMessageModel *)model {
    _model = model;
    UIImage *messageImage = [UIImage imageWithData:model.messageImage];
    self.messageImageSize = messageImage.size;
    
    CGSize maxSize = CGSizeMake(kScreenW-4*kLeftMargin-2*kAvatarSize-2*kDefaultMargin, MAXFLOAT);
    // 创建文本容器
    YYTextContainer *container = [[YYTextContainer alloc] init];
    container.size = maxSize;
    container.maximumNumberOfRows = 0;
    
    // 生成排版结果
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:model.messageContent attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:attrStr];
    self.messageWidth = layout.textBoundingSize.width > maxSize.width ? maxSize.width : layout.textBoundingSize.width;
    self.messageHeight = layout.textBoundingSize.height;
    self.messageBgWidth = self.messageWidth+2*kDefaultMargin;
    self.messageBgHeight = self.messageHeight+2*kDefaultMargin;
    if (_messageBgHeight < 40) {
        
        _messageBgHeight = 40;
    }
    self.cellHeight = self.messageBgHeight+2*kTopMargin;
    
    ZNBChatConversationModel *conversation = [ZNBChatConversationModel objectForPrimaryKey:model.conversationID];
    if (model.userType == 0) {
        self.messageType = ZNBChatMessageTypeMe;
        self.avatar = [UIImage imageWithData:conversation.fromImage];
        self.nick = conversation.from;
    }else {
        self.messageType = ZNBChatMessageTypeOther;
        self.avatar = [UIImage imageWithData:conversation.toImage];
        self.nick = conversation.to;
    
    }
    
}
@end
