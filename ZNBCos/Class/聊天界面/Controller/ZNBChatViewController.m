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
@interface ZNBChatViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UITableView *chatList;
@property (strong, nonatomic) ZNBKeywordToolBar *keyWordToolBar;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation ZNBChatViewController
#pragma mark ==== 懒加载 ===

- (UITableView *)chatList {
    
    if (!_chatList) {
        _chatList = [[UITableView alloc]init];
        _chatList.backgroundColor = ZNBColor(236, 237, 241);
        _chatList.tableFooterView = [[UIView alloc]init];
        _chatList.delegate = self;
        _chatList.dataSource = self;
        _chatList.separatorStyle = UITableViewCellSeparatorStyleNone;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listTap)];
        [_chatList registerClass:[ZNBChatMessageCell class] forCellReuseIdentifier:@"cell"];
        [_chatList addGestureRecognizer:tap];
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
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self dealData];
    
    if (self.dataArr.count == 0) {
        [self showTips];
    }
}
#pragma mark - 初始化UI操作
- (void)setUpNav {
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraBtn setImage:[UIImage imageWithOriginalRender:@"barbuttonicon_InfoSingle"] forState:UIControlStateNormal];
    cameraBtn.frame = CGRectMake(0, 0, 30, 30);
    [cameraBtn addTarget:self action:@selector(camerDidclick) forControlEvents:UIControlEventTouchUpInside];
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
- (void)camerDidclick {
    ZNBAddChatMessageController *addMessageVc = [[ZNBAddChatMessageController alloc] init];
    addMessageVc.conversationModel = self.conversationModel;
    [self.navigationController pushViewController:addMessageVc animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZNBChatMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.viewModel = self.dataArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    ZNBChatMessageViewModel *viewModel = self.dataArr[indexPath.row];
    
    return viewModel.cellHeight;
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
- (void)listTap {

}

@end
