//
//  ZNBSetNameController.m
//  ZNBCos
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBSetNameController.h"

@interface ZNBSetNameController ()
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property (weak, nonatomic) IBOutlet UILabel *indicateLabel;

@end

@implementation ZNBSetNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置微信昵称";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveName)];
    if (self.vcType == ZNBSetNameControllerTypeSetName) {
        self.textF.placeholder = @"填写昵称";
        self.indicateLabel.text = @"昵称的长度在16个字以内";
    }else {
        self.textF.placeholder = @"填写来源";
        self.indicateLabel.text = @"来源的长度在8个字以内";
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textF becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textF resignFirstResponder];
}

- (void)saveName {
    if (self.nameBlock) {
        self.nameBlock(self.textF.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    NSLog(@"dealloc");
}
@end
