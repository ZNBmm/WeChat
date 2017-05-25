//
//  ZNBChatConversationModel.h
//  ZNBCos
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Realm/Realm.h>
#import "ZNBChatMessageModel.h"

@interface ZNBChatConversationModel : RLMObject
@property NSString *conversationID;
@property NSString *from;
@property NSString *to;
@property NSData *fromImage;
@property NSData *toImage;
@property RLMArray<ZNBChatMessageModel*><ZNBChatMessageModel> *messageArr;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<ZNBChatConversationModel *><ZNBChatConversationModel>
RLM_ARRAY_TYPE(ZNBChatConversationModel)
