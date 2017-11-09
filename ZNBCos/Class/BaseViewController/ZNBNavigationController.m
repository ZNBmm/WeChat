//
//  ZNBNavigationController.m
//  ZNBCos
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBNavigationController.h"

@interface ZNBNavigationController ()

@end

@implementation ZNBNavigationController

+ (void)load {
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont fontWithName:@"AlNile-Bold" size:18];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    bar.titleTextAttributes = attr;
    bar.tintColor = [UIColor whiteColor];
    bar.translucent = NO;
    
    CGFloat rgb = 0.1;
    bar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
   // [bar setBackgroundImage:[UIImage imageNamed:@"SenderTextNodeBkg"] forBarMetrics:UIBarMetricsDefault];;
}
- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
