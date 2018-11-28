//
//  LYWKWebViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYWKWebViewController.h"

static NSString *const estimatedProgress = @"estimatedProgress";
static NSString *const title = @"title";
static NSString *const canGoBack = @"canGoBack";

@interface LYWKWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic,strong) UIBarButtonItem *leftBarButton;
@property (nonatomic,strong) UIBarButtonItem *leftBarButtonSecond;
@property (nonatomic,strong)  UIBarButtonItem *negativeSpacer;

@property (nonatomic, strong) NSURL *url;

@end

@implementation LYWKWebViewController

- (instancetype)initWithURLString:(NSString*)urlString{
    self = [super init];
    if (self) {
        
        self.url = [NSURL URLWithString:urlString];
        
    }
    return self;
}

- (instancetype)initWithURL:(NSURL*)url{
    self = [super init];
    if (self) {
        
        self.url = url;
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self LoadRequest];
    [self addObserver];
    [self _setBarButtonItem];
    }

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark 加载网页
- (void)LoadRequest{
    //TODO:加载
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30]];
}
#pragma mark 添加KVO观察者
- (void)addObserver{
    //TODO:kvo监听，获得页面title和加载进度值，以及是否可以返回
    [self.webView addObserver:self forKeyPath:estimatedProgress options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:title options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:canGoBack options:NSKeyValueObservingOptionNew context:NULL];
}
#pragma mark 设置BarButtonItem
- (void)_setBarButtonItem{
    
    UIColor *tinColor = LYColor(@"#666666");
    
    
//    if (iOS11)
//    {
//        self.leftBarButton = [UIBarButtonItem itemWithImage:MTNAVBACKITEMICON higlightedImage:MTNAVBACKITEMICON target:self action:@selector(backBarItemAction)];
//        self.leftBarButton.tintColor = tinColor;
//        self.navigationItem.leftBarButtonItem = self.leftBarButton;
//
//        self.leftBarButtonSecond = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"webView_closeItem"] style:UIBarButtonItemStyleDone target:self action:@selector(closeBarItemAction)];
//        self.leftBarButtonSecond.imageInsets = UIEdgeInsetsMake(0, -20, 0, 20);
//        self.leftBarButtonSecond.tintColor = tinColor;
//    }else
//    {
//        self.negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
//        self.negativeSpacer.width = -5;
//
//        //设置距离左边屏幕的宽度距离
//        self.leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:MTNAVBACKITEMICON] style:UIBarButtonItemStyleDone target:self action:@selector(backBarItemAction)];
//        self.leftBarButton.tintColor = tinColor;
//
//        //设置关闭按钮，以及关闭按钮和返回按钮之间的距离
//        self.leftBarButtonSecond = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"webView_closeItem"] style:UIBarButtonItemStyleDone target:self action:@selector(closeBarItemAction)];
//        self.leftBarButtonSecond.imageInsets = UIEdgeInsetsMake(0, -20, 0, 20);
//        self.leftBarButtonSecond.tintColor = tinColor;
//
//        self.navigationItem.leftBarButtonItems = @[self.negativeSpacer,self.leftBarButton];
//    }

    
}

#pragma mark - actions
#pragma mark 关闭并上一界面
- (void)closeBarItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 返回上一个网页还是上一个Controller
- (void)backBarItemAction{
    if (self.webView.canGoBack == 1)
    {
        [self.webView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark 右侧功能按钮
- (void)rightBarActionClick{
    
//    NSMutableArray *_functionArray = [NSMutableArray array];
//
//    [_functionArray addObject:[[MTShareItem alloc] initWithImage:[UIImage imageNamed:@"Action_Copy"] title:@"复制链接" action:^(MTShareItem *item) {
//    }]];
//
//    UIImage *image = [UIImage imageNamed:[@"MTShareImage.bundle" stringByAppendingPathComponent:@"share_safari"]];
//
//    [_functionArray addObject:[[MTShareItem alloc] initWithImage:image title:@"用Safari打开" action:^(MTShareItem *item) {
//        ALERT_MSG(@"提示",@"用Safari打开",self);
//    }]];
//
//    [_functionArray addObject:[[MTShareItem alloc] initWithImage:[UIImage imageNamed:@"Action_Refresh"] title:@"刷新" action:^(MTShareItem *item) {
//    }]];
//
//    [_functionArray addObject:[[MTShareItem alloc] initWithImage:[UIImage imageNamed:@"Action_Expose"] title:@"举报" action:^(MTShareItem *item) {
//        ALERT_MSG(@"提示",@"点击了举报",self);
//    }]];
//
//    NSMutableArray *_shareArray = [NSMutableArray array];
//
//    [_shareArray addObject:MTPlatformNameSms];
//    [_shareArray addObject:MTPlatformNameEmail];
//    [_shareArray addObject:MTPlatformNameSina];
//    [_shareArray addObject:MTPlatformNameWechat];
//    [_shareArray addObject:MTPlatformNameQQ];
//    [_shareArray addObject:MTPlatformNameAlipay];
//
//    MTShareView *shareView = [[MTShareView alloc] initWithShareItems:_shareArray functionItems:_functionArray itemSize:CGSizeMake(80,100)];
//    [shareView addText:@"分享测试"];
//    //    shareView.containViewColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.4];
//    [shareView addURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    [shareView addImage:[UIImage imageNamed:@"share_alipay"]];
//    shareView.itemSpace = 10;
//    [shareView showFromControlle:self];
    
    
    //    WEAKSELF(weakSelf);
    //    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:nil cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
    //        if (buttonIndex == 1) {
    //            [weakSelf reloadWebViewAction];
    //        }else if (buttonIndex == 2){
    //
    //            [[UIApplication sharedApplication] openURL:weakSelf.webView.URL];
    //
    //        }
    //    } otherButtonTitles:@"刷新",@"用Safari打开", nil];
    //    [actionSheet show];
}
#pragma mark reload
- (void)reloadWebViewAction{
    [self.webView reload];
}



#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //加载进度值
    if ([keyPath isEqualToString:estimatedProgress])
    {
        if (object == self.webView)
        {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:1.5f
                                      delay:0.0f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self.progressView setAlpha:0.0f];
                                 }
                                 completion:^(BOOL finished) {
                                     [self.progressView setProgress:0.0f animated:NO];
                                 }];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    //网页title
    else if ([keyPath isEqualToString:title])
    {
        if (object == self.webView)
        {
            self.title = self.webView.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
        if (self.titleStr.length) {
            self.title = self.titleStr;
        }
    }
    //是否可以返回
    else if ([keyPath isEqualToString:canGoBack])
    {
        if (object == self.webView)
        {
            if (self.webView.canGoBack == 1)
            {
//                if (iOS11) {
//                    self.navigationItem.leftBarButtonItems = @[self.leftBarButton,self.leftBarButtonSecond];
//
//                }else{
//                    self.navigationItem.leftBarButtonItems = @[self.negativeSpacer,self.leftBarButton,self.leftBarButtonSecond];
//                }
            }
            else
            {
//                if (iOS11) {
//                    self.navigationItem.leftBarButtonItem = self.leftBarButton;
//                }else{
//                    self.navigationItem.leftBarButtonItems = @[self.negativeSpacer,self.leftBarButton];
//                }
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark 在这里处理短暂性的加载错误
/// 页面加载前调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
/// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    [self hideEmptyView];
}

/// 页面加载失败调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:( WKNavigation *)navigation withError:(NSError *)error{
    /*
     *-1009 没有网络连接
     *-1003
     *-999
     *101
     */
    
    if (error.code == -1099)
    {
    }
    
    if (self.webView.canGoBack == 1)
    {
        LYLog(@"self.webView.canGoBack == 1");
//        [self hideEmptyView];
    }else
    {
//        [self showEmptyDataViewWithTpye:MTShowEmptyDataTpyeNoNetwork];
        LYLog(@"self.webView.canGoBack == 0");
    }
    
}

#pragma mark - 显示错误视图点击
- (void)didTapEmptyViewAction{
//    [self hideEmptyView];
    [self LoadRequest];
}


//#pragma mark - WKWebViewDelegate
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
////    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
////    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////        completionHandler();
////    }])];
////    [self presentViewController:alertController animated:YES completion:nil];
//}
//
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
//    // target="_blank" 解决网页链接打不开问题
//    MTLog(@"createWebViewWithConfiguration");
//    if (!navigationAction.targetFrame.isMainFrame) {
//
//        [webView loadRequest:navigationAction.request];
//    }
//    return nil;
//}


#pragma mark - 懒加载
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.backgroundColor = [UIColor whiteColor];
        [_webView setUserInteractionEnabled:YES];
        // 导航代理
        _webView.navigationDelegate = self;
        // 与webview UI交互代理
        _webView.UIDelegate = self;
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
    return _webView;
}
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 4)];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progressTintColor = LYRGBACOLOR(51, 133, 255, 1);
        _progressView.clipsToBounds = YES;
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

#pragma mark 移除观察者
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:estimatedProgress];
    [self.webView removeObserver:self forKeyPath:canGoBack];
    [self.webView removeObserver:self forKeyPath:title];
}


@end
