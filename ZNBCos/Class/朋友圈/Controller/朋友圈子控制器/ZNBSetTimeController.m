//
//  ZNBSetTimeController.m
//  ZNBCos
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBSetTimeController.h"

@interface ZNBSetTimeController ()
@property (weak, nonatomic) IBOutlet UITextField *textF;

@end

@implementation ZNBSetTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置发布时间";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveTime)];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textF becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textF resignFirstResponder];
}

- (void)saveTime {
    if (self.timeBlock) {
        self.timeBlock(self.textF.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
