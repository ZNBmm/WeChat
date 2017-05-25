//
//  ZNBConversationCell.h
//  ZNBCos
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZNBChatConversationModel;
@interface ZNBConversationCell : UITableViewCell
@property (strong, nonatomic) ZNBChatConversationModel *model;
@end
