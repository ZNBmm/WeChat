//
//  ZNBConversationController.m
//  ZNBCos
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBConversationController.h"
#import "ZNBChatConversationModel.h"
#import "ZNBConversationCell.h"
#import "ZNBAddConversationController.h"
#import "ZNBChatViewController.h"
@interface ZNBConversationController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic)  RLMResults<ZNBChatConversationModel*>*conversations;
@end

@implementation ZNBConversationController
- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = kBackGroundColor;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZNBConversationCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
           // make.edges.equalTo(self.view);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self dealData];
    self.title = @"会话";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
}
#pragma mark - 处理数据
- (void)dealData {
    self.conversations = [ZNBChatConversationModel allObjects];
    NSLog(@"所有的会话列表%@",self.conversations);
    [self.tableView reloadData];
    if (self.conversations.count == 0) {
        [self showTips];
    }
}
- (void)showTips {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"皮皮友情提示" message:@"点击右上角的白色小人添加消息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [alertView show];
}
#pragma mark - 初始化UI操作
- (void)setUpNav {
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraBtn setImage:[UIImage imageWithOriginalRender:@"barbuttonicon_addfriends"] forState:UIControlStateNormal];
    cameraBtn.frame = CGRectMake(0, 0, 30, 30);
    [cameraBtn addTarget:self action:@selector(camerDidclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:cameraBtn];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.conversations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZNBConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.conversations[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.title = @"微信(99)";
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZNBChatConversationModel *model = self.conversations[indexPath.row];
    
    ZNBChatViewController *chatVc = [[ZNBChatViewController alloc] init];
    chatVc.conversationModel = model;
    [self.navigationController pushViewController:chatVc animated:YES];
 
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        ZNBChatConversationModel *model = self.conversations[indexPath.row];
        
        [realm beginWriteTransaction];
        [realm deleteObject:model];
        [realm commitWriteTransaction];
        
        tableView.editing = NO;
        
        [tableView reloadData];
    }];
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        ZNBChatConversationModel *model = self.conversations[indexPath.row];
        ZNBAddConversationController *conversationVC = [[ZNBAddConversationController alloc] init];
        conversationVC.conversationModel = model;
        [self.navigationController pushViewController:conversationVC animated:YES];
        
        tableView.editing = NO;
    }];
    return @[action1,action2];
    
}


- (void)camerDidclick {

    ZNBAddConversationController *conversationVC = [[ZNBAddConversationController alloc] init];
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
