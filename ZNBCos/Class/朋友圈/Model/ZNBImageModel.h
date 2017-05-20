//
//  ZNBImageModel.h
//  ZNBCos
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Realm/Realm.h>

@interface ZNBImageModel : RLMObject
@property NSData *imageData;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<ZNBImageModel *><ZNBImageModel>
RLM_ARRAY_TYPE(ZNBImageModel)
