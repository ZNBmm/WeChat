//
//  ZNBAddQRViewController.h
//  ZNBCos
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZNBAddQRViewControllerBlock)(UIImage *image);
@interface ZNBAddQRViewController : UIViewController
@property (nonatomic, copy) ZNBAddQRViewControllerBlock imageBlock;
@end
