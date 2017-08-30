//
//  ZNBAddLikesController.m
//  ZNBCos
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBAddLikesController.h"
#import "ZNBTimeLineModel.h"
@interface ZNBAddLikesController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;

@end

@implementation ZNBAddLikesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
    self.title = @"添加点赞";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveLikes)];
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [MobClick beginLogPageView:@"添加赞界面"];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"添加赞界面"];
    
}

- (void)textViewDidChange:(UITextView *)textView {

    if (textView.text.length) {
        self.placeholder.hidden = YES;
    }else {
    
        self.placeholder.hidden = NO;
    }
}
- (void)saveLikes {

    RLMRealm *realm = [RLMRealm defaultRealm];
    
    ZNBTimeLineModel *model  = [ZNBTimeLineModel objectForPrimaryKey:self.uid];
    [realm beginWriteTransaction];
    model.likes = self.textView.text;
    [ZNBTimeLineModel createOrUpdateInRealm:realm withValue:model];
    [realm commitWriteTransaction];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
