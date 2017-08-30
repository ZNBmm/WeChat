//
//  ZNBSetAddressController.m
//  ZNBCos
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBSetAddressController.h"

@interface ZNBSetAddressController ()
@property (weak, nonatomic) IBOutlet UITextField *cityTextF;
@property (weak, nonatomic) IBOutlet UITextField *addressTextF;

@end

@implementation ZNBSetAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置所在位置";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAddress)];
}
- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    [self.cityTextF becomeFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [MobClick beginLogPageView:@"添加发布位置界面"];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"添加发布位置界面"];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.cityTextF resignFirstResponder];
    [self.addressTextF resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)saveAddress {

    NSString *addressStr = [[NSString alloc] initWithFormat:@"%@ · %@",self.cityTextF.text,self.addressTextF.text];
    if (self.addressBlock) {
        self.addressBlock(addressStr);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
