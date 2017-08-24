//
//  IF_WKWebHtmlViewController.m
//  IntelligentFactory
//
//  Created by My Book on 17/7/3.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IF_WKWebHtmlViewController.h"
#import "GradientProgressView.h"
#import "FunctionButton.h"
#import "IFSequenceViewController.h"
@interface IF_WKWebHtmlViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
@property (nonatomic, strong) GradientProgressView *progressView;

@end

@implementation IF_WKWebHtmlViewController

- (void)dealloc {
    DHLog(@"%@被释放了",[super class]);
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (BOOL)navigationShouldPopOnBackButton
{
    return [self goBackAction];
}

- (WKWebViewConfiguration *)wkConfig {
    if (!_wkConfig) {
        _wkConfig = [[WKWebViewConfiguration alloc] init];
        //允许视频播放
        _wkConfig.allowsAirPlayForMediaPlayback = YES;
        // 允许在线播放
        _wkConfig.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        _wkConfig.selectionGranularity = YES;
        // 是否支持记忆读取
//        _wkConfig.suppressesIncrementalRendering = YES;
        //js交互  默认是YES
        _wkConfig.preferences.javaScriptEnabled = YES;
        //字体大小
        _wkConfig.preferences.minimumFontSize = 10;
        //H5是否支持播放
//        _wkConfig.allowsPictureInPictureMediaPlayback = YES;
        //JavaScript是否可以打开
//        _wkConfig.preferences.javaScriptCanOpenWindowsAutomatically = NO;
//        _wkConfig.processPool = [[WKProcessPool alloc] init];
//        通过JS与webview内容交互配置
//        _wkConfig.userContentController = [[WKUserContentController alloc] init];
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
    }
    return _wkConfig;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:self.wkConfig];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        _wkWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        //    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}


-(GradientProgressView *)progressView{
    
    if (!_progressView) {
        _progressView = [[GradientProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 3)];
//        _progressView.trackTintColor= [UIColor clearColor];//设置未过进度部分的颜色
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationItem.title isEqualToString:@"差异分析"]) {
        WEAKSELF
        FunctionButton *showOrHidBtn = [[FunctionButton  alloc] initWithFrame:CGRectMake(0, 0, 25, 25) withType:(UIButtonTypeCustom) image:@"D_Cn_Order_Add" block:^(UIButton *sender) {
            
            IFSequenceViewController *svc = [[IFSequenceViewController alloc]init];
            UINavigationController *nc= [[UINavigationController alloc]initWithRootViewController:svc];
            svc.seqenceBlock = ^(NSMutableArray *array){
                DHLog(@"%@",array);
            };
            [weakSelf.navigationController presentViewController:nc animated:YES completion:^{
                
            }];

        }];
        
        UIBarButtonItem *rightItems = [[UIBarButtonItem alloc]initWithCustomView:showOrHidBtn];
        self.navigationItem.rightBarButtonItem = rightItems;

    }
    [self createView];
    [self loadWebViewFilePath];
}

-(void)createView{
    self.view.backgroundColor = [UIColor whiteColor];    
//    [self.navigationController.navigationBar addSubview:self.progressView];
    [self.view addSubview:self.progressView];
}

-(void)loadWebViewFilePath{

//
//    NSURL *baseURL = [NSURL URLWithString:_urlstring];
//    [_wkWebView loadHTMLString:[NSString stringWithContentsOfFile:_urlstring encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];

//    WK是不支持本地H5的JS方法的 所以用下面这是方法.只支持9.0以上。这个很恶心
    NSURL *url = [NSURL fileURLWithPath:_urlstring];
    [self.wkWebView loadFileURL:url allowingReadAccessToURL:url];
    
//    NSString *urlString = @"http://www.baidu.com";
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlstring]];
//    request.timeoutInterval = 15.0f;
//    [self.wkWebView loadRequest:request];
}

-(void)refreshData{
    DHLog(@"刷新了");
    [self loadWebViewFilePath];
}



/*
 *在WKWebViewd的代理中展示进度条，加载完成后隐藏进度条
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (_progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - WKWKNavigationDelegate Methods

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    _progressView.hidden = NO;
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_wkWebView.scrollView.mj_header endRefreshing];
    _progressView.hidden = YES;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    _progressView.hidden = YES;
}

//页面跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //允许页面跳转
    NSLog(@"%@",navigationAction.request.URL);
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark - Tool bar item action

- (BOOL)goBackAction {
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
        return NO;
    }else{
        return YES;
    }
}

- (void)goForwardAction {
    if ([self.wkWebView canGoForward]) {
        [self.wkWebView goForward];
    }
}

- (void)refreshAction {
    [self.wkWebView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
