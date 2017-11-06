//
//  WTWebViewController.m
//  LilysFriends
//
//  Created by wintel on 17/2/14.
//  Copyright © 2017年 wintelsui. All rights reserved.
//

#import "WTWebViewController.h"

@interface WTWebViewController ()
<
UIWebViewDelegate
>
{
    UIWebView *_webview;
    UIButton *_backBtn;
}
@end

@implementation WTWebViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_webview.isLoading) {
        [_webview stopLoading];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webview = [[UIWebView alloc] init];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setTitle:@"<" forState:UIControlStateNormal];
    [_backBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _backBtn.layer.cornerRadius = 20.0f;
    _backBtn.backgroundColor = [UIColor blackColor];
    [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (_webview.canGoBack) {
            [_webview goBack];
        }
    }];
    [self.view addSubview:_backBtn];
    [_backBtn setHidden:YES];
    
    [_webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10.0f);
        make.right.mas_equalTo(-10.0f);
        make.width.mas_equalTo(40.0f);
        make.height.mas_equalTo(40.0f);
    }];
    
    [self webviewLoadUrl:self.url];
}

- (void)webviewLoadUrl:(NSString *)urlString{
    [_webview stopLoading];
    
//    [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "]]
    if (urlString) {
        NSURL *url;
        if ([urlString hasPrefix:@"http"] || [urlString hasPrefix:@"ftp"]) {
//            url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "]]];
        }else{
            url = [NSURL fileURLWithPath:urlString];
        }
        if (url) {
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60];
            [_webview loadRequest:request];
        }
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *titleString = [_webview stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"title:%@",titleString);
    
    NSString *windowmsgmsg_title = [_webview stringByEvaluatingJavaScriptFromString:@"window.msg.msg_title"];
    NSLog(@"windowmsgmsg_title:%@",windowmsgmsg_title);
    if (_webview.canGoBack) {
        [_backBtn setHidden:NO];
    }else{
        [_backBtn setHidden:YES];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [PublicClass showMessage:@"加载网页失败" travel:1.5];
    if (_webview.canGoBack) {
        [_backBtn setHidden:NO];
    }else{
        [_backBtn setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
