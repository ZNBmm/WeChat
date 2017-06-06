//
//  ZNBRedPageViewController.h
//  ZNBCos
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNBChatConversationModel.h"
@interface ZNBRedPageViewController : UIViewController
/** 会话模型 */
@property (strong, nonatomic) ZNBChatConversationModel *conversationModel;
@end
