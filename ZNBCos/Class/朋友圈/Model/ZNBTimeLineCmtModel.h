//
//  ZNBTimeLineCmtModel.h
//  ZNBCos
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Realm/Realm.h>

@interface ZNBTimeLineCmtModel : RLMObject
@property NSString *uid;
@property NSString *replyName;
@property NSString *beReplyName;
@property NSString *content;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<ZNBTimeLineCmtModel *><ZNBTimeLineCmtModel>
RLM_ARRAY_TYPE(ZNBTimeLineCmtModel)
