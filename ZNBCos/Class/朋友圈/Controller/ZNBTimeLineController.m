//
//  ZNBTimeLineController.m
//  ZNBCos
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBTimeLineController.h"
#import "ZNBTimeLineCell.h"
#import "ZNBTimeLineTopView.h"
#import "ZNBAddImageTextController.h"
#import "ZNBAddCmtController.h"
#import "ZNBAddLikesController.h"
#import "ZNBAddBGViewController.h"
#import "ZNBTimeLineBGModel.h"
static NSString *const reuseCell = @"ZNBTimeLineCell";
@interface ZNBTimeLineController ()<UITableViewDelegate,UITableViewDataSource,ZNBTimeLineCellDelegate>
@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) ZNBTimeLineTopView *topView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (weak, nonatomic) ZNBTimeLineCell *currentCell;
@property (weak, nonatomic) UIButton *currentCmtBtn;
@end

@implementation ZNBTimeLineController
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (ZNBTimeLineTopView *)topView
{
    if (_topView == nil) {
        ZNBTimeLineTopView *top = [ZNBTimeLineTopView viewForXib];
        top.topClickBlock = ^{
            
            [self.navigationController pushViewController:[[ZNBAddBGViewController alloc] init] animated:YES];
        };
        CGFloat height = (kScreenH-64)*0.5-64;
        top.frame = CGRectMake(0, 0, kScreenW, height);
        _topView = top;
        
    }
    return _topView;
}
#pragma mark - 控制器生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self setUpNav];
    
    [self setUpTableView];
    
    
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
   
}
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self detalData];
    
}
#pragma mark - 初始化UI操作
- (void)setUpNav {
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraBtn setImage:[UIImage imageWithOriginalRender:@"barbuttonicon_Camera"] forState:UIControlStateNormal];
    cameraBtn.frame = CGRectMake(0, 0, 30, 30);
    [cameraBtn addTarget:self action:@selector(camerDidclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:cameraBtn];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)setUpTableView {

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = kBackGroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    _tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = self.topView;
    [tableView registerClass:[ZNBTimeLineCell class] forCellReuseIdentifier:reuseCell];
}

#pragma mark - 处理数据
- (void)detalData {

    RLMResults<ZNBTimeLineModel *> *timeLineModels = [ZNBTimeLineModel allObjects];
    RLMResults<ZNBImageModel *>*imageArr = [ZNBImageModel allObjects];
    NSLog(@"imageArr--%@",imageArr);
    NSLog(@"%@",timeLineModels);
    [self.dataSource removeAllObjects];
    for (ZNBTimeLineModel *model in timeLineModels) {
        ZNBTimeLineViewModel *viewModel = [ZNBTimeLineViewModel viewModelWithModel:model];
        [self.dataSource addObject:viewModel];
    }
    RLMResults<ZNBTimeLineBGModel *>*bgModels = [ZNBTimeLineBGModel allObjects];
    ZNBTimeLineBGModel *model = bgModels.lastObject;
    if (model) {
        _topView.nameLabel.text = model.name;
        _topView.avatar.image = [UIImage imageWithData:model.avatar];
        _topView.bgImageView.image = [UIImage imageWithData:model.bg];
    }
    
    [self.tableView reloadData];
}
#pragma mark - 相机点击事件
- (void)camerDidclick {
    ZNBAddImageTextController *addVc = [[ZNBAddImageTextController alloc] init];
    [self.navigationController pushViewController:addVc animated:YES];
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ZNBTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    cell.delegate = self;
    ZNBTimeLineViewModel *viewModel = self.dataSource[indexPath.section];
    cell.viewModel = viewModel;
    
    cell.raiseBtnBlock = ^{
        ZNBAddLikesController *addLikeVc = [[ZNBAddLikesController alloc] init];
        addLikeVc.uid = viewModel.model.uid;
        [self.navigationController pushViewController:addLikeVc animated:YES];
    };
    
    cell.cmtBtnBlock = ^{
        ZNBAddCmtController *addCmtVc = [[ZNBAddCmtController alloc] init];
        addCmtVc.uid = viewModel.model.uid;
        [self.navigationController pushViewController:addCmtVc animated:YES];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZNBTimeLineViewModel *viewModel;
    if (indexPath.section < self.dataSource.count) {
        viewModel = self.dataSource[indexPath.section];
    }
    NSString *uid = viewModel.model.uid;
    CGFloat height = [ZNBTimeLineCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        ZNBTimeLineCell *cell = (ZNBTimeLineCell *)sourceCell;
        cell.viewModel = viewModel;
    } cache:^NSDictionary *{
        return @{kHYBCacheUniqueKey: uid,
                 kHYBCacheStateKey : @"",
                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                 kHYBRecalculateForStateKey : @(YES) // 标识不用重新更新
                 };
    }];
    return height+1;
}
#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZNBTimeLineViewModel *viewModel;
    if (indexPath.section < self.dataSource.count) {
        viewModel = self.dataSource[indexPath.section];
    }
   
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除本条" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         RLMRealm *realm = [RLMRealm defaultRealm];
        ZNBTimeLineModel *model = viewModel.model;
        [realm beginWriteTransaction];
        [realm deleteObject:model];
        [realm commitWriteTransaction];
        
        [self detalData];
    }];
    UIAlertAction *modify = [UIAlertAction actionWithTitle:@"修改本条" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZNBAddImageTextController *addImageTextVC = [[ZNBAddImageTextController alloc] init];
        addImageTextVC.viewModel = viewModel;
        [self.navigationController pushViewController:addImageTextVC animated:YES];
    }];
   
    UIAlertAction *deleteAll = [UIAlertAction actionWithTitle:@"删除全部" style: UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        RLMResults<ZNBTimeLineModel *>*timeLines = [ZNBTimeLineModel allObjectsInRealm:realm];
        [realm beginWriteTransaction];
        [realm deleteObjects:timeLines];
        [realm commitWriteTransaction];
        
        [self detalData];
    }];
    
    
    [alertVc addAction:cancel];
    [alertVc addAction:deleteAll];
    [alertVc addAction:delete];
    [alertVc addAction:modify];
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - <ZNBTimeLineCellDelegate> 
- (void)timeLineCell:(ZNBTimeLineCell *)timeLineCell didSelectedCmtCell:(ZNBTimeLineCmtCell *)cmtCell atIndexPath:(NSIndexPath *)indexPath {

    [self.currentCell hiddenRaiseCmtView];
    self.currentCell = timeLineCell;
    ZNBTimeLineViewModel *viewModel = timeLineCell.viewModel;
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除本条评论" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        ZNBTimeLineCmtModel *model = viewModel.model.cmtArr[indexPath.row];
        [realm beginWriteTransaction];
        [realm deleteObject:model];
        [realm commitWriteTransaction];
        
        [self detalData];
    }];
    UIAlertAction *modify = [UIAlertAction actionWithTitle:@"修改本条评论" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         ZNBTimeLineCmtModel *model = viewModel.model.cmtArr[indexPath.row];
        ZNBAddCmtController *addCMTVC = [[ZNBAddCmtController alloc] init];
        addCMTVC.uid = viewModel.model.uid;
        addCMTVC.cmtUid = model.uid;
        [self.navigationController pushViewController:addCMTVC animated:YES];
    }];
    /*
    UIAlertAction *deleteAll = [UIAlertAction actionWithTitle:@"删除全部评论" style: UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        for (ZNBTimeLineCmtModel *cmtModel in viewModel.model.cmtArr) {
            [realm beginWriteTransaction];
            [realm deleteObjects:cmtModel];
            [realm commitWriteTransaction];
        }
        
        [self detalData];
    }];
     */
    
    [alertVc addAction:cancel];
   // [alertVc addAction:deleteAll];
    [alertVc addAction:delete];
    [alertVc addAction:modify];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)timeLineCell:(ZNBTimeLineCell *)timeLineCell didSelectedCmtBtn:(UIButton *)cmtBtn {
    self.currentCell = timeLineCell;
    self.currentCmtBtn = cmtBtn;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    self.currentCmtBtn.selected = NO;
    [self.currentCell hiddenRaiseCmtView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {

    NSLog(@"%s",__func__);
}
@end
