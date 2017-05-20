//
//  ZNBSetNameController.h
//  ZNBCos
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZNBSetNameControllerTypeSetName,
    ZNBSetNameControllerTypeSetSource,
} ZNBSetNameControllerType;

typedef void(^ZNBSetNameBlock)(NSString *name);
@interface ZNBSetNameController : UIViewController
/** 控制器类型 */
@property(nonatomic,assign) ZNBSetNameControllerType vcType;
@property (nonatomic, copy) ZNBSetNameBlock nameBlock;
@end
