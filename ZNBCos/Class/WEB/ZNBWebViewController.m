//
//  ZNBWebViewController.m
//  ZNBCos
//
//  Created by mac on 2017/7/10.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBWebViewController.h"
#import <WebKit/WebKit.h>
@interface ZNBWebViewController ()<WKNavigationDelegate>
@property (weak, nonatomic) WKWebView *webView;

@end

@implementation ZNBWebViewController

- (WKWebView *)webView
{
    if (_webView == nil) {
        WKWebView *webView = [[WKWebView alloc] init];
        _webView = webView;
        
        [self.view addSubview:webView];
        webView.navigationDelegate = self;
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view).offset(0);
        }];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackGroundColor;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSInteger total = [[NSUserDefaults standardUserDefaults] integerForKey:@"total"];
    total += 1;
    [[NSUserDefaults standardUserDefaults] setInteger:total forKey:@"total"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [SVProgressHUD dismiss];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [MobClick beginLogPageView:@"web界面"];
}


- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"web界面"];
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
