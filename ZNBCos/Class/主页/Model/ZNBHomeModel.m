//
//  ZNBHomeModel.m
//  ZNBCos
//
//  Created by mac on 2017/5/26.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBHomeModel.h"

@implementation ZNBHomeModel
+ (instancetype)modelWithDict:(NSDictionary *)dict {

    ZNBHomeModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
