//
//  ZNBChatConversationViewModel.h
//  ZNBCos
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNBChatConversationModel.h"
@interface ZNBChatConversationViewModel : NSObject
@property (strong, nonatomic) ZNBChatConversationModel *model;

+ (instancetype)viewModelWithModel:(ZNBChatConversationModel *)model;
@end
