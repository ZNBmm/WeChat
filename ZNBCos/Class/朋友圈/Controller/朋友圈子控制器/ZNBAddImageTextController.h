//
//  ZNBAddImageTextController.h
//  ZNBCos
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZNBAddImageTextComplementHandle)();

@class ZNBTimeLineViewModel;
@interface ZNBAddImageTextController : UIViewController
@property (strong, nonatomic) ZNBTimeLineViewModel *viewModel;

@property (nonatomic, copy) ZNBAddImageTextComplementHandle handle;
@end
