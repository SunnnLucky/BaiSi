//
//  SLBSWebViewVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/22.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSWebViewVC.h"
#import <WebKit/WebKit.h>

@interface SLBSWebViewVC ()

//占位视图
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) WKWebView * webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *frowardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@end

@implementation SLBSWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
    
    // 添加WKWebView
    WKWebView * webView = [[WKWebView alloc] init];

    _webView = webView;
    [self.contentView addSubview:webView];
    
    // 展示网页
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
    
    // kvo监听属性改变
    /*
       Observer:谁观察
       KeyPath:观察哪个属性
       options:NSKeyValueObservingOptionNew:观察新值改变
     */
    // kvo注意点:一定要移除
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听进度条
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    self.backItem.enabled = self.webView.canGoBack;
    self.frowardItem.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    self.progress.progress = self.webView.estimatedProgress;
    self.progress.hidden = self.webView.estimatedProgress >= 1;
}

-(void)dealloc{
    // 移除KVO
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _webView.frame = self.contentView.bounds;
}


#pragma mark - 按钮点击事件
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goFroward:(id)sender {
    [self.webView goForward];
}
- (IBAction)reload:(id)sender {
    [self.webView reload];
}


@end
