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
#import "GDTNativeExpressAd.h"
#import "GDTNativeExpressAdView.h"
#import <SDCycleScrollView.h>

#define kTopViewHeight kScale*250

// 1106386544
// 9060728554207423
static NSString *const appkey = @"1106386544";
static NSString *const posId = @"9060728554207423";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,GDTMobBannerViewDelegate,GDTNativeExpressAdDelegete,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (weak, nonatomic) ZNBHomeTopView *topView;
@property (strong, nonatomic) GDTMobBannerView *bannerView;
@property (strong, nonatomic) UIView *bannerContent;
// 用于请求原生模板广告，注意：不要在广告打开期间释放！
@property (nonatomic, retain)   GDTNativeExpressAd *nativeExpressAd;
// 存储返回的GDTNativeExpressAdView
@property (nonatomic, retain)       NSArray *expressAdViews;

@property (strong, nonatomic) UIView *bottomContent;
@property (weak, nonatomic) UICollectionView *collecView;


@end

@implementation ViewController
{
    BOOL _isPurchase;
}
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
- (UIView *)bottomContent
{
    if (_bottomContent == nil) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        fl.itemSize = CGSizeMake(kScreenW-20, 95*kScale);

        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, kScreenW-10, 95*kScale) collectionViewLayout:fl];
        _collecView = collect;
        collect.delegate = self;
        collect.dataSource = self;
        collect.pagingEnabled = YES;
        collect.showsHorizontalScrollIndicator = NO;
        collect.backgroundColor = [UIColor whiteColor];
        [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        collect.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
        _bottomContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 95*kScale+10)];
        [_bottomContent addSubview:collect];
        
    }
    return _bottomContent;
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
        tableView.contentInset = UIEdgeInsetsMake(kTopViewHeight-44, 0, 30, 0);
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
    UIScrollView *s;
    
    if (@available(iOS 11.0, *)) {
        NSLog(@"安全区域%@",NSStringFromUIEdgeInsets(self.tableView.superview.safeAreaInsets));
        NSLog(@"adjustedContentInset%@",NSStringFromUIEdgeInsets(self.tableView.adjustedContentInset));
    } else {
        // Fallback on earlier versions
    }
    
    NSLog(@"contentInset%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
    
    
    
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
    
    [self loadAD];
    
    
}
// 拉取广告
- (void)loadAD {
    self.nativeExpressAd = [[GDTNativeExpressAd alloc] initWithAppkey:@"1106386544" placementId:@"3060924577620401" adSize:CGSizeMake(kScreenW-20, 95*kScale)];
    self.nativeExpressAd.delegate = self;
    
    // 拉取5条广告
    [self.nativeExpressAd loadAd:5];
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
    
    _isPurchase = [[NSUserDefaults standardUserDefaults] boolForKey:kIsPurchase];
    if (_isPurchase) {
        
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
    ZNBLog(@"%@",error);
}

/**
 * 拉取广告成功的回调
 */
- (void)nativeExpressAdSuccessToLoad:(GDTNativeExpressAd *)nativeExpressAd views:(NSArray<__kindof GDTNativeExpressAdView *> *)views
{
    [self.expressAdViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GDTNativeExpressAdView *adView = (GDTNativeExpressAdView *)obj;
        [adView removeFromSuperview];
    }];
    
    self.expressAdViews = [NSArray arrayWithArray:views];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    //vc = [self navigationController];
#pragma clang diagnostic pop
    
    if (self.expressAdViews.count) {
        
        self.tableView.tableFooterView = self.bottomContent;
        [self.collecView reloadData];
    }
    
}

/**
 * 拉取广告失败的回调
 */
- (void)nativeExpressAdFailToLoad:(GDTNativeExpressAd *)nativeExpressAd error:(NSError *)error {
    
}
/**
 * 拉取广告失败的回调
 */
- (void)nativeExpressAdRenderFail:(GDTNativeExpressAdView *)nativeExpressAdView
{
    ZNBLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewRenderSuccess:(GDTNativeExpressAdView *)nativeExpressAdView
{
    ZNBLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewClicked:(GDTNativeExpressAdView *)nativeExpressAdView
{
    ZNBLog(@"%s",__FUNCTION__);
}
#pragma mark - collectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.expressAdViews.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    GDTNativeExpressAdView *expressView =  [self.expressAdViews objectAtIndex:indexPath.row];
    // 设置frame，开发者自己设置
    expressView.frame = CGRectMake(0, 0, kScreenW-20, 95*kScale);
    expressView.controller = self;
    
    [expressView render];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.contentView respondsToSelector:@selector(removeAllSubviews)];
    [cell.contentView addSubview:expressView];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

@end
