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
#import <iAd/iAd.h>

#define kTopViewHeight kScale*250
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ADBannerViewDelegate>
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (weak, nonatomic) ZNBHomeTopView *topView;
@property (strong, nonatomic) ADBannerView *bannerView;
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
- (ADBannerView *)bannerView
{
    if (_bannerView == nil) {
        _bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
        _bannerView.delegate = self;
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
        tableView.contentInset = UIEdgeInsetsMake(kTopViewHeight, 0, 0, 0);
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
    
   
    self.tableView.tableFooterView = self.bannerView;
    

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

     [self.navigationController pushViewController:[[ZNBQRViewController alloc]init] animated:YES];}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title  = @"发现";
    
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
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    NSLog(@"%s",__func__);
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"%s",__func__);
}
@end
