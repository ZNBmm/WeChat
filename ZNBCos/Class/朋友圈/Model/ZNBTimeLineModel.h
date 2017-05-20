//
//  ZNBTimeLineModel.h
//  ZNBCos
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Realm/Realm.h>
#import "ZNBImageModel.h"
#import "ZNBTimeLineCmtModel.h"

#define kTopMargin 14.0*kScale
#define kRightMargin 10.0*kScale
#define kLeftMargin 10.0*kScale
#define kBottomMargin 10.0*kScale
#define kAvatarSize 40.0*kScale
#define kImageMargin 5.0
#define kImageWidth (kScreenW-(kLeftMargin+kAvatarSize+kRightMargin)*2-2*kImageMargin)/3.0
#define kCmtLabelWidth (kScreenW-kLeftMargin-kAvatarSize-2*kRightMargin)
@interface ZNBTimeLineModel : RLMObject
@property NSString *uid;
@property NSData *avatar;
@property NSString *name;
@property NSString *content;
@property NSString *likes;
@property NSString *time;
@property NSString *address;
@property NSString *source;
@property RLMArray<ZNBImageModel*><ZNBImageModel> *imageArr;
@property RLMArray<ZNBTimeLineCmtModel*><ZNBTimeLineCmtModel> *cmtArr;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<ZNBTimeLineModel *><ZNBTimeLineModel>
RLM_ARRAY_TYPE(ZNBTimeLineModel)
