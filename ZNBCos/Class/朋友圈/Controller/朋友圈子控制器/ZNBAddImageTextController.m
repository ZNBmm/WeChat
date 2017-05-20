//
//  ZNBAddImageTextController.m
//  ZNBCos
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBAddImageTextController.h"
#import "ZNBAddImageTextCell.h"
#import "ZNBSetNameController.h"
#import "ZNBSetAddressController.h"
#import "ZNBSetTimeController.h"
#import "ZNBAddImageTextEditCell.h"
#import "ZNBTimeLineImageCell.h"
#import "ZNBTimeLineModel.h"
#import "ZNBTimeLineViewModel.h"

static NSString *const reuseCell = @"ZNBTimeLineImageCell";
@interface ZNBAddImageTextController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate>
@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIImage *avatar;
@property (copy, nonatomic) NSString *name;
@property (nonatomic, copy) NSString *creatTime;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *source;
@property (weak, nonatomic) UITextView *textView;
@property (weak, nonatomic) UICollectionView *collecView;
@property (strong, nonatomic) NSMutableArray *imageArr;
@property (strong, nonatomic) NSMutableArray *cmtArr;
@end

@implementation ZNBAddImageTextController
- (NSMutableArray *)imageArr
{
    if (_imageArr == nil) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
- (NSMutableArray *)cmtArr
{
    if (_cmtArr == nil) {
        _cmtArr = [NSMutableArray array];
    }
    return _cmtArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [self setUpTableView];
    self.title = @"添加图文";
    
    [self setupNav];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}
- (void)setupNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveImageText)];
}

- (void)setViewModel:(ZNBTimeLineViewModel *)viewModel {
    _viewModel = viewModel;
    self.avatar = [UIImage imageWithData:viewModel.model.avatar];
    self.name = viewModel.model.name;
    self.address = viewModel.model.address;
    self.creatTime = viewModel.model.time;
    self.imageArr = viewModel.imageArr;
    self.cmtArr = viewModel.cmtArr;
    self.source = viewModel.model.source;
    [self.tableView reloadData];
    [self.collecView reloadData];
    
    self.textView.text = viewModel.model.content;
}

#pragma mark - 保存图文
- (void)saveImageText {
    
    if (!self.avatar || !self.name.length || !self.creatTime.length || !self.textView.text.length) {
        [ZNBAnimationManager shakeView:self.view];
        UIAlertView *alerView =[[UIAlertView alloc] initWithTitle:@"请补全信息" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alerView show];
        return;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    NSDate *date = [NSDate date];
    
    NSString *uid = self.viewModel.model.uid.length?self.viewModel.model.uid: [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    if (self.viewModel.model.uid.length) {
        ZNBTimeLineModel *timeLineModel = [ZNBTimeLineModel objectForPrimaryKey:uid];
        
        [realm transactionWithBlock:^{
            
            timeLineModel.name = self.name;
            timeLineModel.content = self.textView.text;
            timeLineModel.time = self.creatTime;
            timeLineModel.address = self.address;
            timeLineModel.source = self.source;
            timeLineModel.avatar = UIImagePNGRepresentation(self.avatar);
            [timeLineModel.imageArr removeAllObjects];
            for (UIImage *image in self.imageArr) {
                ZNBImageModel *imageModel = [[ZNBImageModel alloc] init];
                imageModel.imageData = UIImagePNGRepresentation(image);
                [timeLineModel.imageArr addObject:imageModel];
            }
        }];
        
    }else {
        ZNBTimeLineModel *timeLineModel = [[ZNBTimeLineModel alloc] init];
        timeLineModel.uid = uid;
        timeLineModel.name = self.name;
        timeLineModel.content = self.textView.text;
        timeLineModel.time = self.creatTime;
        timeLineModel.address = self.address;
        timeLineModel.source = self.source;
        
        timeLineModel.avatar = UIImagePNGRepresentation(self.avatar);
        for (UIImage *image in self.imageArr) {
            ZNBImageModel *imageModel = [[ZNBImageModel alloc] init];
            imageModel.imageData = UIImagePNGRepresentation(image);
            [timeLineModel.imageArr addObject:imageModel];
        }
        
        [realm beginWriteTransaction];
        [ZNBTimeLineModel createOrUpdateInRealm:realm withValue:timeLineModel];
        [realm commitWriteTransaction];
    }
   
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setUpTableView {

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView = tableView;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = ZNBColor(240, 240, 240);
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZNBAddImageTextCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZNBAddImageTextEditCell class]) bundle:nil] forCellReuseIdentifier:@"editCell"];
    
}
#pragma mark - TableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 4;
    }else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
       ZNBAddImageTextCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        cell.leftLabel.text = @"发布人头像";
        cell.rightLabel.text = @"";
        UIImage *image;
        
        if (self.avatar) {
            image = self.avatar;
        }else {
            image = [UIImage imageNamed:@"brandDefaultHeadFrame"];
        }
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.znb_width = 50;
        imageView.znb_height = 50;
        cell.accessoryView = imageView;
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
       ZNBAddImageTextCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"发布人昵称";
            NSString *leftStr;
            if (self.name.length) {
                leftStr = self.name;
            }else {
                leftStr = @"昵称,必填";
            }
            cell.rightLabel.text = leftStr;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 1) {
            NSString *leftStr;
            if (self.creatTime.length) {
                leftStr = self.creatTime;
            }else {
                leftStr = @"发布时间, 必填";
            }
            cell.leftLabel.text = @"发布时间";
            cell.rightLabel.text = leftStr;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
        }else if (indexPath.row == 2) {
            NSString *leftStr;
            if (self.address.length) {
                leftStr = self.address;
            }else {
                leftStr = @"选填";
            }
            cell.leftLabel.text = @"所在位置";
            cell.rightLabel.text = leftStr;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 3) {
            NSString *leftStr;
            if (self.source.length) {
                leftStr = self.source;
            }else {
                leftStr = @"选填";
            }
            cell.leftLabel.text = @"来源";
            cell.rightLabel.text = leftStr;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
        
    }else {
        ZNBAddImageTextEditCell* cell = [tableView dequeueReusableCellWithIdentifier:@"editCell"];
        self.textView = cell.textView;
        if (self.viewModel) {
            self.textView.text = self.viewModel.model.content;
            cell.placeHolder.hidden = YES;
        }
        [cell.collecView registerClass:[ZNBTimeLineImageCell class] forCellWithReuseIdentifier:reuseCell];
        cell.collecView.delegate = self;
        cell.collecView.dataSource = self;
        self.collecView = cell.collecView;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0 ) {
        return 64;
    } else if (indexPath.section == 2) {
        CGFloat height = self.textView.znb_height+20+kItemSize+kZNBAddImageTextEditCelMargin;
        if (self.imageArr.count >=5) {
            height = self.textView.znb_height+20+kItemSize*2+kZNBAddImageTextEditCelMargin*2;
        }
        return height;
    }
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self imagePickerVc];
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self setUpNameVc];
        }else if (indexPath.row == 1) {
            [self setUpTimeVc];
        }else if (indexPath.row == 2) {
            [self setUpAddressVc];
        }else {
            [self setupSourceVC];
        }
    }else {
    
    }
}

#pragma mark - 设置昵称控制器
- (void)setUpNameVc {
    ZNBSetNameController *setNameVc = [[ZNBSetNameController alloc] init];
    
    setNameVc.nameBlock = ^(NSString *name) {
        self.name = name;
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:setNameVc animated:YES];
    
}

- (void)setUpAddressVc {
    ZNBSetAddressController *setAddressVc = [[ZNBSetAddressController alloc] init];
    
    setAddressVc.addressBlock = ^(NSString *address) {
        self.address = address;
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:setAddressVc animated:YES];
    
}

- (void)setUpTimeVc {
    ZNBSetTimeController *setTimeVc = [[ZNBSetTimeController alloc] init];
    
    setTimeVc.timeBlock = ^(NSString *timeStr) {
        self.creatTime = timeStr;
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:setTimeVc animated:YES];
}

- (void)setupSourceVC {
    ZNBSetNameController *setNameVc = [[ZNBSetNameController alloc] init];
    setNameVc.vcType = ZNBSetNameControllerTypeSetSource;
    setNameVc.nameBlock = ^(NSString *source) {
        self.source = source;
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
    self.avatar = info[UIImagePickerControllerEditedImage];
    
    [self.tableView reloadData];
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSLog(@"%f",scrollView.contentOffset.y);
}

#pragma mark - <keyboardWillShow>
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    __block  CGFloat keyboardHeight = [aValue CGRectValue].size.height;
    if (keyboardHeight==0) return;
    CGRect keyboardRect = [aValue CGRectValue];
    
    keyboardRect = [self.view convertRect:keyboardRect toView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;

    CGFloat delta = 0.0;
    CGFloat textV_y = [self.textView convertRect:self.textView.bounds toView:nil].origin.y;
    delta = textV_y - ([UIApplication sharedApplication].keyWindow.bounds.size.height - keyboardHeight-self.textView.znb_height);
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [self.tableView setContentOffset:offset animated:YES];
    
}

#pragma mark - <UICollectionView 代理,数据源方法>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArr.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZNBTimeLineImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCell forIndexPath:indexPath];
    if (indexPath.row == _imageArr.count) {
        cell.image = [UIImage imageNamed:@"AddGroupMemberBtnHL"];
    }else {
        cell.image = self.imageArr[indexPath.row];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == self.imageArr.count) {
        [self pushImagePickerController];
    }else {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"删除图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.imageArr removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
            [self.collecView reloadData];
        }];
        [alertVc addAction:cancel];
        [alertVc addAction:delete];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
}

- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9-self.imageArr.count columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.photoWidth = kScreenW*0.5;
    imagePickerVc.allowPickingVideo = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - <TZImagePickerControllerDelegate>
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    [self.imageArr addObjectsFromArray:[NSMutableArray arrayWithArray:photos]];
    
    [self.tableView reloadData];
    
    [self.collecView reloadData];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.textView resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

@end
