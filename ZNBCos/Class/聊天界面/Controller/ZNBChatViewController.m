//
//  ZNBChatViewController.m
//  ZNBCos
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBChatViewController.h"
#import "ZNBKeywordToolBar.h"
#import "ZNBChatMessageCell.h"
#import "ZNBAddChatMessageController.h"
#import "ZNBRedPageViewController.h"
#import "PopoverView.h"
#import "ZNBRedPageMessageCell.h"

#import "GDTMobBannerView.h"

static NSString *appkey = @"1106386544";
static NSString *posId = @"7040529554115440";

static NSString *const reuseRedPageCell = @"ZNBRedPageMessageCell";
@interface ZNBChatViewController ()<UITableViewDataSource,UITableViewDelegate,GDTMobBannerViewDelegate>
@property(nonatomic, strong) UITableView *chatList;
@property (strong, nonatomic) ZNBKeywordToolBar *keyWordToolBar;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) GDTMobBannerView *bannerView;
@property (strong, nonatomic) UIView *bannerContent;

@end

@implementation ZNBChatViewController{
   BOOL _isClose;
}

#pragma mark ==== 懒加载 ===

- (UITableView *)chatList {
    
    if (!_chatList) {
        _chatList = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _chatList.backgroundColor = ZNBColor(236, 237, 241);
        _chatList.tableFooterView = [[UIView alloc]init];
        _chatList.delegate = self;
        _chatList.dataSource = self;
        _chatList.separatorStyle = UITableViewCellSeparatorStyleNone;
       
        [_chatList registerClass:[ZNBChatMessageCell class] forCellReuseIdentifier:@"cell"];
        [_chatList registerClass:[ZNBRedPageMessageCell class] forCellReuseIdentifier:reuseRedPageCell];
        
        [self.view addSubview:_chatList];
        [_chatList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(self.keyWordToolBar.mas_top);
        }];
    }
    return _chatList;
}
- (ZNBKeywordToolBar *)keyWordToolBar
{
    if (_keyWordToolBar == nil) {
        _keyWordToolBar = [ZNBKeywordToolBar shareKeyWord];
        [self.view addSubview:_keyWordToolBar];
        [_keyWordToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.equalTo(@49);
        }];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyWordToolBarDidClick)];
        [_keyWordToolBar addGestureRecognizer:tapGes];
        
    }
    return _keyWordToolBar;
}
- (UIView *)bannerContent
{
    if (_bannerContent == nil) {
        _bannerContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0)];
        
        [_bannerContent addSubview:self.bannerView];
    }
    return _bannerContent;
}
- (GDTMobBannerView *)bannerView
{
    if (_bannerView == nil) {
        _bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0, 10, kScreenW, 50) appkey:appkey placementId:posId];
        _bannerView.delegate = self;
        _bannerView.currentViewController = self;
        _bannerView.isAnimationOn = YES;
        _bannerView.showCloseBtn = YES;
        _bannerView.isGpsOn = YES;
        [_bannerView loadAdAndShow];
    }
    return _bannerView;
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.conversationModel.to;
    [self addSubViews];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUpNav];
    _isClose = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"聊天界面"];
    [self dealData];
    
    if (self.dataArr.count == 0) {
        [self showTips];
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"聊天界面"];
}
#pragma mark - 初始化UI操作
- (void)setUpNav {
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraBtn setImage:[UIImage imageWithOriginalRender:@"barbuttonicon_InfoSingle"] forState:UIControlStateNormal];
    cameraBtn.frame = CGRectMake(0, 0, 30, 30);
    [cameraBtn addTarget:self action:@selector(camerDidclick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:cameraBtn];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)dealData {

    RLMArray<ZNBChatMessageModel*><ZNBChatMessageModel>*models = self.conversationModel.messageArr;
    
    [self.dataArr removeAllObjects];
    
    for (ZNBChatMessageModel *model in models) {
        ZNBChatMessageViewModel *viewModel = [ZNBChatMessageViewModel viewModelWithModel:model];
        [self.dataArr addObject:viewModel];
    }
    
    [self.chatList reloadData];
    if (self.dataArr.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArr.count-1 inSection:0];
        
        [self.chatList scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}
- (void)addSubViews {

    [self chatList];
    [self keyWordToolBar];
    
}
- (void)camerDidclick:(UIButton *)btn {
   
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"普通消息" handler:^(PopoverAction *action) {
        ZNBAddChatMessageController *addMessageVc = [[ZNBAddChatMessageController alloc] init];
        addMessageVc.conversationModel = self.conversationModel;
        [self.navigationController pushViewController:addMessageVc animated:YES];
    }];
    PopoverAction *action2 = [PopoverAction actionWithTitle:@"红包消息" handler:^(PopoverAction *action) {
        ZNBRedPageViewController *addRedPageMessageVc = [[ZNBRedPageViewController alloc] init];
        addRedPageMessageVc.conversationModel = self.conversationModel;
        [self.navigationController pushViewController:addRedPageMessageVc animated:YES];
    }];
//    PopoverAction *action3 = [PopoverAction actionWithTitle:@"图片消息" handler:^(PopoverAction *action) {
//        
//    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    [popoverView showToView:btn withActions:@[action1,action2]];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZNBChatMessageViewModel *viewModel = self.dataArr[indexPath.row];
    
    if (viewModel.model.money.length) {
        ZNBRedPageMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseRedPageCell];
        cell.viewModel = viewModel;
        return cell;
    }else {
        ZNBChatMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.viewModel = viewModel;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    ZNBChatMessageViewModel *viewModel = self.dataArr[indexPath.row];
    
    return viewModel.cellHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

     BOOL isPurchase = [[NSUserDefaults standardUserDefaults] valueForKey:kIsPurchase];
    if (isPurchase || _isClose) {
        return [UIView new];
    }else {
    
        return self.bannerContent;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    BOOL isPurchase = [[NSUserDefaults standardUserDefaults] valueForKey:kIsPurchase];
    if (isPurchase || _isClose) {
        return 0.001;
    }else {
        
        return 60;
    }
}
#pragma mark - tableViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ZNBChatMessageViewModel *viewModel = self.dataArr[indexPath.row];
    
    //NSLog(@"%@",viewModel.model);
    
    UIAlertController *alertVc = [UIAlertController  alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *del = [UIAlertAction actionWithTitle:@"删除本条" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteObject:viewModel.model];
        [realm commitWriteTransaction];
        
        [self dealData];
    }];
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:del];
    
    [alertVc addAction:cancel];
    
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)keyWordToolBarDidClick {
    [self showTips];
    
}
- (void)showTips {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"皮皮友情提示" message:@"点击右上角的白色小人添加消息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [alertView show];
}


#pragma mark - 广告代理方法
- (void)bannerViewDidReceived
{
    self.bannerContent.znb_height = 60;
    
}

- (void)bannerViewWillClose {
    self.bannerContent.znb_height = 0;
    
    self.bannerView = nil;
    _isClose = YES;
    
    [self.chatList reloadData];
    
}

- (void)bannerViewFailToReceived:(NSError *)error {
    self.bannerContent.znb_height = 0;
    
    self.bannerView = nil;
    _isClose = YES;
    
    [self.chatList reloadData];
}

@end
