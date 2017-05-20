//
//  ZNBTimeLineBGModel.h
//  ZNBCos
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Realm/Realm.h>

@interface ZNBTimeLineBGModel : RLMObject
@property NSString *uid;
@property NSData *avatar;
@property NSData *bg;
@property NSString *name;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<ZNBTimeLineBGModel *><ZNBTimeLineBGModel>
RLM_ARRAY_TYPE(ZNBTimeLineBGModel)
