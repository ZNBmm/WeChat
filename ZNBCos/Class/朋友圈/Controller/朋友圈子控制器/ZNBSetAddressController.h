//
//  ZNBSetAddressController.h
//  ZNBCos
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZNBSetAddressControllerBlock)(NSString *address);
@interface ZNBSetAddressController : UIViewController

@property (nonatomic, copy) ZNBSetAddressControllerBlock addressBlock;
@end
