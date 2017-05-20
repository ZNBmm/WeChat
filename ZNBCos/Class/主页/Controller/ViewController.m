//
//  ViewController.m
//  ZNBCos
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ViewController.h"
#import "ZNBTimeLineController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"发现";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.znb_width = 100;
    btn.znb_height = 50;
    btn.znb_centerX = kScreenW*0.5;
    btn.znb_centerY = kScreenH*0.5;
    [btn setTitle:@"朋友圈制作" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(timeLineMake) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)timeLineMake {
  [self.navigationController pushViewController:[[ZNBTimeLineController alloc]init] animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

  
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
