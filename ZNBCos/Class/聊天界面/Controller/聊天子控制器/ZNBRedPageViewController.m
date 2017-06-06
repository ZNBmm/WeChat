
//
//  ZNBRedPageViewController.m
//  ZNBCos
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBRedPageViewController.h"

@interface ZNBRedPageViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UISwitch *messageType;
@property (weak, nonatomic) IBOutlet UISwitch *redPageType;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *redPapeLabel;

@end

@implementation ZNBRedPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.messageLabel.text = self.conversationModel.from;
    [self setupNav];
}
- (IBAction)changeMessageType:(UISwitch *)sender {
    if (sender.isOn) {
        self.messageLabel.text = self.conversationModel.from;
    }else {
        self.messageLabel.text = self.conversationModel.to;
    }
}
- (IBAction)changeRedPageType:(UISwitch *)sender {
    if (sender.isOn) {
        self.redPapeLabel.text = @"微信转账";
    }else {
        self.redPapeLabel.text = @"已收款";
    }
}


- (void)setupNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveImageText)];
}
- (void)saveImageText {
    RLMRealm *realm = [RLMRealm defaultRealm];
    ZNBChatConversationModel *model = [ZNBChatConversationModel objectForPrimaryKey:self.conversationModel.conversationID];
    NSDate *date = [NSDate date];
    NSString *messageID = [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    ZNBChatMessageModel *messageModel = [[ZNBChatMessageModel alloc] init];
    messageModel.messageID = messageID;
    messageModel.money = self.textView.text;
    messageModel.conversationID = model.conversationID;
    messageModel.userType = self.messageType.isOn?0:1;
    messageModel.messageContent = self.redPageType.isOn ? @"微信转账" : @"已收款";
    [realm transactionWithBlock:^{
        [model.messageArr addObject:messageModel];
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.textView endEditing:YES];
    [self.textView resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView endEditing:YES];
    [self.textView resignFirstResponder];
}
@end
