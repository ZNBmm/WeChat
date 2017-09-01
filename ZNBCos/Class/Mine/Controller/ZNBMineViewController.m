//
//  ZNBMineViewController.m
//  ZNBCos
//
//  Created by mac on 2017/8/31.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBMineViewController.h"
#import "ZNBSettingCell.h"
#import "ZNBRemoveADViewController.h"
#import "IAPManager.h"
#import "ZNBWebViewController.h"


@interface ZNBMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (nonatomic,strong) IAPManager *iapManager;
@end

@implementation ZNBMineViewController


- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZNBSettingCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZNBColor(230, 230, 230);
    
    [self tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ZNBSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"花费6块永久消去广告";
    }else{
        cell.titleLabel.text = @"技术支持网址";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        [self removeAD];
        
    }else {
    
        ZNBWebViewController *webVc = [[ZNBWebViewController alloc] init];
        webVc.source = @"support";
        webVc.url = @"http://www.jianshu.com/p/a03cdf76c12d";
        [self.navigationController pushViewController:webVc animated:YES];
    }
    
}

- (void)removeAD {

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定花费6元去除广告吗" message:@"一经购买,终身有效" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (!_iapManager) {
            _iapManager = [[IAPManager alloc] init];
        }
        
        // iTunesConnect 苹果后台配置的产品ID
        [SVProgressHUD showWithStatus:@"正在购买..."];
        [_iapManager startPurchWithID:@"com.znb.chat_removeAD" completeHandle:^(IAPPurchType type,NSData *data) {
            ZNBLog(@"type=--->%d",type);
            [SVProgressHUD dismiss];
            if (type == 0) {
                [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kIsPurchase];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }];
        
       
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:sure];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
