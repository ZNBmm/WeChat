//
//  ZNBHomeModel.h
//  ZNBCos
//
//  Created by mac on 2017/5/26.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNBHomeModel : NSObject
/** 背景颜色 */
@property (nonatomic, copy) NSString *colorHex;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconImage;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
