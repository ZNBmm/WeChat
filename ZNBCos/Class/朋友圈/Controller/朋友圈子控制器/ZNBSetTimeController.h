//
//  ZNBSetTimeController.h
//  ZNBCos
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZNBSetTimeControllerBlock)(NSString *timeStr);
@interface ZNBSetTimeController : UIViewController
@property (nonatomic, copy) ZNBSetTimeControllerBlock timeBlock;
@end
