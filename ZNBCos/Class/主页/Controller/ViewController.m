//
//  ViewController.m
//  ZNBCos
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ViewController.h"
#import "ZNBTimeLineController.h"
#import "ZNBChatViewController.h"
#import "ZNBConversationController.h"
#import "ZNBHomeCell.h"
#import "ZNBHomeModel.h"
#import "ZNBHomeTopView.h"
#import "ZNBQRViewController.h"

#import "ZNBMineViewController.h"
#import "GDTMobBannerView.h"

#define kTopViewHeight kScale*250

// 1106386544
// 9060728554207423
static NSString *appkey = @"1106386544";
static NSString *posId = @"9060728554207423";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,GDTMobBannerViewDelegate>
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (weak, nonatomic) ZNBHomeTopView *topView;
@property (strong, nonatomic) GDTMobBannerView *bannerView;
@property (strong, nonatomic) UIView *bannerContent;

@end

@implementation ViewController
- (ZNBHomeTopView *)topView
{
    if (_topView == nil) {
        ZNBHomeTopView *topView = [ZNBHomeTopView shareView];
        _topView = topView;
        _topView.frame = CGRectMake(0, 0, kScreenW, kTopViewHeight);
        [self.view addSubview:topView];
    }
    return _topView;
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
        _bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(20, 10, kScreenW-40, 50) appkey:appkey placementId:posId];
        _bannerView.delegate = self;
        _bannerView.currentViewController = self;
        _bannerView.isAnimationOn = YES;
        _bannerView.showCloseBtn = YES;
        _bannerView.isGpsOn = YES;
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
- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(kTopViewHeight, 0, 30, 0);
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZNBHomeCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}


- (void)viewWillLayoutSubviews {

    [super viewWillLayoutSubviews];
    self.topView.znb_height = kTopViewHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self topView];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeData" ofType:@"plist"]];
    self.view.layer.borderColor = [UIColor colorWithHexString:@"ffd247"].CGColor;
    self.view.layer.borderWidth = 10;
    
    NSArray *tempArr = dict[@"Data"];
    
    for (NSDictionary *dict in tempArr) {
        [self.dataArr addObject:[ZNBHomeModel modelWithDict:dict]];
    }
    [self.tableView reloadData];
    

}
- (void)sessionMake {
    self.title = @"返回";
    [self.navigationController pushViewController:[[ZNBConversationController alloc]init] animated:YES];
    
}
- (void)timeLineMake {
    self.title = @"发现";
    [self.navigationController pushViewController:[[ZNBTimeLineController alloc]init] animated:YES];
    
}
- (void)qrImageMake {

     [self.navigationController pushViewController:[[ZNBQRViewController alloc]init] animated:YES];
}

- (void)personCenter {
    [self.navigationController pushViewController:[[ZNBMineViewController alloc]init] animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title  = @"发现";
    
    BOOL isPurchase = [[NSUserDefaults standardUserDefaults] valueForKey:kIsPurchase];
    if (isPurchase) {
        
        self.bannerView = nil;
        self.bannerContent = nil;
    }else {
        [self.bannerContent addSubview:self.bannerView];
        [self.bannerView loadAdAndShow];
        
    }
    
    [MobClick beginLogPageView:@"主页"];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    NSInteger total = [[NSUserDefaults standardUserDefaults] integerForKey:@"total"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.topView upDateWaveCellWithPresent:(int)total];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"主页"];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ZNBHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ZNBHomeModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self timeLineMake];
    }else if (indexPath.row == 1) {
        [self sessionMake];
    }else if (indexPath.row == 2) {
        [self qrImageMake];
    }else {
        [self personCenter];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 90;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 广告代理方法
- (void)bannerViewDidReceived
{
    self.bannerContent.znb_height = 60;
    self.tableView.tableHeaderView = self.bannerContent;
}

- (void)bannerViewWillClose {
    self.bannerContent.znb_height = 0;
    self.tableView.tableHeaderView = self.bannerContent;
    self.bannerView = nil;
}

- (void)bannerViewFailToReceived:(NSError *)error {
    self.bannerContent.znb_height = 0;
    self.tableView.tableHeaderView = self.bannerContent;
}

@end
