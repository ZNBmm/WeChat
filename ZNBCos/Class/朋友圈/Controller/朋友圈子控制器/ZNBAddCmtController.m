//
//  ZNBAddCmtController.m
//  ZNBCos
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBAddCmtController.h"
#import "ZNBTimeLineModel.h"
@interface ZNBAddCmtController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *replyTextF;
@property (weak, nonatomic) IBOutlet UITextField *beReplyTextF;
@property (weak, nonatomic) IBOutlet UITextView *contentTextV;
@property (weak, nonatomic) IBOutlet UILabel *placeHoder;

@end

@implementation ZNBAddCmtController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentTextV.delegate = self;
    self.title = @"添加评论";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveCmt)];
    if (self.cmtUid.length) {
        ZNBTimeLineCmtModel *cmtModel = [ZNBTimeLineCmtModel objectForPrimaryKey:self.cmtUid];
        self.replyTextF.text = cmtModel.replyName;
        self.beReplyTextF.text = cmtModel.beReplyName;
        self.contentTextV.text = cmtModel.content;
        self.placeHoder.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [MobClick beginLogPageView:@"添加评论界面"];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"添加评论界面"];
    
}
- (void)textViewDidChange:(UITextView *)textView {

    if (textView.text.length) {
        self.placeHoder.hidden = YES;
    }else {
        self.placeHoder.hidden = NO;
    }
}

- (void)saveCmt {
    if (!self.replyTextF.text.length) {
        [ZNBAnimationManager shakeView:self.view];
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"评论人必填" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alerView show];
        return;
    }
    
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    ZNBTimeLineModel *model = [ZNBTimeLineModel objectForPrimaryKey:self.uid];
    ZNBTimeLineCmtModel *cmtModel;
    if (self.cmtUid.length) {
        cmtModel = [ZNBTimeLineCmtModel objectForPrimaryKey:self.cmtUid];
        [realm transactionWithBlock:^{
            cmtModel.replyName = self.replyTextF.text;
            cmtModel.beReplyName = self.beReplyTextF.text;
            cmtModel.content = self.contentTextV.text;
        }];
    }else {
        NSString *cmtUid = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
        cmtModel = [[ZNBTimeLineCmtModel alloc] init];
        cmtModel.uid = cmtUid;
        cmtModel.replyName = self.replyTextF.text;
        cmtModel.beReplyName = self.beReplyTextF.text;
        cmtModel.content = self.contentTextV.text;
        
        [realm beginWriteTransaction];
        [model.cmtArr addObject:cmtModel];
        [ZNBTimeLineCmtModel createOrUpdateInRealm:realm withValue:cmtModel];
//        [ZNBTimeLineModel createOrUpdateInRealm:realm withValue:model];
        [realm commitWriteTransaction];
    }

   
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
