//
//  ZNBAddConversationController.m
//  ZNBCos
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBAddConversationController.h"
#import "ZNBAddImageTextCell.h"
#import "ZNBSetNameController.h"
#import "ZNBChatConversationModel.h"
typedef enum : NSUInteger {
    ZNBClickTypeMe,
    ZNBClickTypeOther
} ZNBClickType;

@interface ZNBAddConversationController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImage *fromImage;
@property (strong, nonatomic) UIImage *toImage;
@property (copy, nonatomic) NSString *from;
@property (copy, nonatomic) NSString *to;
@property (assign, nonatomic) ZNBClickType type;
@end

@implementation ZNBAddConversationController
- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:tableView];
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = kBackGroundColor;
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZNBAddImageTextCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.conversationModel) {
        self.from = self.conversationModel.from;
        self.to = self.conversationModel.to;
        self.toImage = [UIImage imageWithData:self.conversationModel.toImage];
        self.fromImage = [UIImage imageWithData:self.conversationModel.fromImage];
    }
    
    [self.tableView reloadData];
    
    [self setupNav];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"添加会话列表界面"];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"添加会话列表界面"];
}

- (void)setupNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveImageText)];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZNBAddImageTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"我的头像";
            cell.rightLabel.text = @"";
            UIImage *image;
            
            if (self.fromImage) {
                image = self.fromImage;
            }else {
                image = [UIImage imageNamed:@"brandDefaultHeadFrame"];
            }
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.znb_width = 50;
            imageView.znb_height = 50;
            cell.accessoryView = imageView;
            
        }else if (indexPath.row == 1) {
            cell.leftLabel.text = @"对方的头像";
            cell.rightLabel.text = @"";
            UIImage *image;
            
            if (self.toImage) {
                image = self.toImage;
            }else {
                image = [UIImage imageNamed:@"brandDefaultHeadFrame"];
            }
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.znb_width = 50;
            imageView.znb_height = 50;
            cell.accessoryView = imageView;
        }
    }else {
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"我的昵称";
            NSString *leftStr;
            if (self.from.length) {
                leftStr = self.from;
            }else {
                leftStr = @"昵称,必填";
            }
            cell.rightLabel.text = leftStr;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 1) {
            cell.leftLabel.text = @"对方的昵称";
            NSString *leftStr;
            if (self.to.length) {
                leftStr = self.to;
            }else {
                leftStr = @"昵称,必填";
            }
            cell.rightLabel.text = leftStr;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 64;
    }else {
        return 44;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.type = ZNBClickTypeMe;
            [self imagePickerVc];
        
        }else if (indexPath.row == 1) {
            self.type = ZNBClickTypeOther;
            [self imagePickerVc];
        }
    }else {
        if (indexPath.row == 0) {
            self.type = ZNBClickTypeMe;
            [self setUpNameVc];
        }else if (indexPath.row == 1) {
            self.type = ZNBClickTypeOther;
            [self setUpNameVc];
        }
    }
}


- (void)setUpNameVc {
    ZNBSetNameController *setNameVc = [[ZNBSetNameController alloc] init];
    
    setNameVc.nameBlock = ^(NSString *name) {
        
        if (self.type == ZNBClickTypeOther) {
            self.to = name;
        }else if (self.type == ZNBClickTypeMe) {
            self.from = name;
        }
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:setNameVc animated:YES];
    
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
    [self dismissViewControllerAnimated:YES completion:nil];
    // 选择的图片信息存储于info字典中
    NSLog(@"%@", info);
    if (self.type == ZNBClickTypeMe) {
        
        self.fromImage = info[UIImagePickerControllerEditedImage];
        
    }else if (self.type == ZNBClickTypeOther) {
        
        self.toImage = info[UIImagePickerControllerEditedImage];
    }
    
    [self.tableView reloadData];
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}

- (void)saveImageText {
    if (!self.fromImage || !self.from.length || !self.to.length || !self.toImage) {
        [ZNBAnimationManager shakeView:self.view];
        UIAlertView *alerView =[[UIAlertView alloc] initWithTitle:@"请补全信息" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alerView show];
        return;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    NSDate *date = [NSDate date];
    NSString *conversationID = self.conversationModel.conversationID.length?self.conversationModel.conversationID:[NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    if (self.conversationModel.conversationID.length) { // 这就是修改模型
        ZNBChatConversationModel *model = [ZNBChatConversationModel objectForPrimaryKey:self.conversationModel.conversationID];
        
        [realm transactionWithBlock:^{
            model.from = self.from;
            model.to = self.to;
            model.fromImage = UIImagePNGRepresentation(self.fromImage);
            model.toImage = UIImagePNGRepresentation(self.toImage);
        }];
    }else {
        ZNBChatConversationModel *model = [[ZNBChatConversationModel alloc] init];
        model.fromImage = UIImagePNGRepresentation(self.fromImage);
        model.toImage = UIImagePNGRepresentation(self.toImage);
        model.to = self.to;
        model.from = self.from;
        model.conversationID = conversationID;
        [realm beginWriteTransaction];
        [ZNBChatConversationModel createInRealm:realm withValue:model];
        [realm commitWriteTransaction];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
