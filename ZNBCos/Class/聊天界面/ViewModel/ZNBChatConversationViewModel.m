//
//  ZNBChatConversationViewModel.m
//  ZNBCos
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBChatConversationViewModel.h"

@implementation ZNBChatConversationViewModel
+ (instancetype)viewModelWithModel:(ZNBChatConversationModel *)model {

    ZNBChatConversationViewModel *viewModel = [[self alloc] init];
    viewModel.model = model;
    return viewModel;
}
@end
