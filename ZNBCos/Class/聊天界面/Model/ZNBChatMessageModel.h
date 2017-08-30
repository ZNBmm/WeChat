//
//  ZNBChatMessageModel.h
//  ZNBCos
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Realm/Realm.h>

#define kAvatarSize 40
#define kLeftMargin 10*kScale
#define kRightMargin 6*kScale
#define kTopMargin 4*kScale
#define kDefaultMargin 13*kScale

@interface ZNBChatMessageModel : RLMObject
@property NSString *conversationID;
@property NSString *messageID;
@property NSInteger userType; // 0 代表自己 1 代表他人
@property NSString *messageContent;
@property NSData *messageImage;
@property NSString *money;
@property NSString *timeInterval; // 时间戳
@property BOOL isShowTime; // 是否显示时间戳

@end

// This protocol enables typed collections. i.e.:
// RLMArray<ZNBChatMessageModel *><ZNBChatMessageModel>
RLM_ARRAY_TYPE(ZNBChatMessageModel)
