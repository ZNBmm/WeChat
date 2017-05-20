//
//  ZNBAddBGViewController.m
//  ZNBCos
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBAddBGViewController.h"
#import "ZNBTimeLineBGModel.h"

typedef enum : NSUInteger {
    ZNBTypeBG,
    ZNBTypeAvatar
} ZNBType;

@interface ZNBAddBGViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *avatarView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property (nonatomic, assign) ZNBType style;
@end

@implementation ZNBAddBGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改背景";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfor)];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView)];
    [self.bgView addGestureRecognizer:tapGes];
    UITapGestureRecognizer *tapGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvatarView)];
    [self.avatarView addGestureRecognizer:tapGes1];
}

- (void)saveInfor {

    if (!self.avatarImageView.image || !self.bgImageView.image || !self.textF.text.length) {
        [ZNBAnimationManager shakeView:self.view];
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请补全信息" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
        return;
        
        
    }
    RLMRealm *realm = [RLMRealm defaultRealm];
    ZNBTimeLineBGModel *model = [[ZNBTimeLineBGModel alloc] init];
    model.uid = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    model.bg = UIImagePNGRepresentation(self.bgImageView.image);
    model.avatar = UIImagePNGRepresentation(self.avatarImageView.image);
    model.name = self.textF.text;
    [realm transactionWithBlock:^{
        [ZNBTimeLineBGModel createOrUpdateInRealm:realm withValue:model];
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tapAvatarView {
    self.style = ZNBTypeAvatar;
    [self imagePickerVc];
    
}
- (void)tapBgView {
    self.style = ZNBTypeBG;
    [self imagePickerVc];
    
}
- (void)imagePickerVc{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
#pragma mark - <UIImagePickerControllerDelegate>
// 选择图片成功调用此方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // dismiss UIImagePickerController
    // 选择的图片信息存储于info字典中
    NSLog(@"%@", info);
    switch (self.style) {
        case ZNBTypeBG:
            self.bgImageView.image = info[UIImagePickerControllerEditedImage];
            break;
            
        default:
             self.avatarImageView.image = info[UIImagePickerControllerEditedImage];
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
   
    
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
