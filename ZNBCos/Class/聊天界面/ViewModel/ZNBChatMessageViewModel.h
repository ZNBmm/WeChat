//
//  ZNBChatMessageViewModel.h
//  ZNBCos
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNBChatMessageModel.h"
#import "ZNBChatConversationModel.h"
typedef enum : NSUInteger {
    ZNBChatMessageTypeMe,
    ZNBChatMessageTypeOther
} ZNBChatMessageType;
@interface ZNBChatMessageViewModel : NSObject

@property (strong, nonatomic) ZNBChatMessageModel *model;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat messageHeight;
@property (nonatomic, assign) CGFloat messageWidth;
@property (nonatomic, assign) CGFloat messageBgHeight;
@property (nonatomic, assign) CGFloat messageBgWidth;
@property (nonatomic, assign) CGSize messageImageSize;
@property (strong, nonatomic) UIImage *avatar;
@property (nonatomic, assign) ZNBChatMessageType messageType;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *money;
+ (instancetype)viewModelWithModel:(ZNBChatMessageModel *)model;
@end
