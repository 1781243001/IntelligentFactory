//
//  IF_WebHtmlViewController.m
//  IntelligentFactory
//
//  Created by My Book on 17/6/29.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IF_WebHtmlViewController.h"
#import "IFSelectOrganizeController.h"
#import "FunctionButton.h"
#import "FeedbackIdeaViewController.h"
@interface IF_WebHtmlViewController ()<UIWebViewDelegate,UINavigationControllerDelegate,selectOrganizeDelegate>
{
    
}
@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation IF_WebHtmlViewController

-(void)dealloc{
    DHLog(@"%@被释放了",[super class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
//    self.navigationController.navigationBar.translucent=YES;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"OEMListTop.png"]forBarMetrics:UIBarMetricsDefault];
//
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.delegate = self;
//    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
//    [self.bridge registerHandler:@"参数" handler:^(id data, WVJBResponseCallback responseCallback) {
//
//    
//    }];
//    _urlstring = [[NSBundle mainBundle]pathForResource:@"zhiNengGongChnang/index.html" ofType:nil];
//    _urlstring = [NSString stringWithFormat:@"%@/zhiNengGongChnang/date.html",[FileService themeResouceDir]];
//    NSURL *baseURL = [NSURL URLWithString:_urlstring];
//    [_webView loadHTMLString:[NSString stringWithContentsOfFile:_urlstring encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
//    _urlstring= @"http://10.246.109.109/app/resource/app/h5/jiLiangFX.html";
//    _urlstring=@"http://10.246.109.109/app/resource/app/h5/chanHaoFXDepartment.html";
    [self clearWebCache];
    
    if (_urlstring.length) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlstring] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        request.timeoutInterval = 15.0f;
        [self.webView loadRequest:request];
  
    }else{
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        imageView.image = [UIImage imageNamed:@"notdevelop.png"];
        CGPoint point = self.view.center;
        imageView.center = CGPointMake(point.x, point.y-100);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, kScreen_Width , 30)];
        label.text = @"正在建设中敬请期待...";
        label.textColor = [UIColor hexString:@"333333"];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:imageView];
        [self.view addSubview:label];
    }
    // Do any additional setup after loading the view.
}

-(void)createNavigationBar{
    self.navigationItem.title = _navigationTitle;
    WEAKSELF;
    FunctionButton *FB = [[FunctionButton  alloc] initWithFrame:CGRectMake(0, 0, 25, 25) withType:(UIButtonTypeCustom) image:@"home_feedback" block:^(UIButton *sender) {
        
        FeedbackIdeaViewController *feed = [[FeedbackIdeaViewController alloc]init];
        [weakSelf.navigationController pushViewController:feed animated:YES];
    }];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:FB];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//清楚缓存
-(void)clearWebCache{

    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies])
        
    {
        
        [storage deleteCookie:cookie];
        
    }
    
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}

- (NSData *)toJSONData:(id)theData{
    if ([NSJSONSerialization isValidJSONObject:theData]) {
        NSError *error = nil;
        NSData *jsonData =[NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
        return jsonData;
    }
    return nil;
}



-(void)refreshData{
    DHLog(@"刷新了");
    [_webView.scrollView.mj_header endRefreshing];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = [NSString stringWithFormat:@"%@",request.URL];

    if([urlStr rangeOfString:@"DepartmentData"].location !=NSNotFound){
        [self selectOrganization];
    }else if ([urlStr rangeOfString:@"&FactoryData="].location !=NSNotFound){
        NSString *string = @"&FactoryData=";
        NSRange range = [urlStr rangeOfString:string];
        NSString * urlSting = [urlStr substringToIndex:range.location] ;    NSLog(@"截取的值为：%@",urlSting);
        IF_WebHtmlViewController *web = [[IF_WebHtmlViewController alloc]init];
        web.urlstring =urlSting;
        web.navigationTitle = _navigationTitle;
        [self.navigationController pushViewController:web animated:YES];
        return NO;

    }
    return YES;
}

-(void)selectOrganization{
    IFSelectOrganizeController *svc = [[IFSelectOrganizeController alloc]init];
    svc.organizeDeleagate = self;
    svc.navigationTitle = _navigationTitle;
    UINavigationController *nc= [[UINavigationController alloc]initWithRootViewController:svc];
    [self.navigationController presentViewController:nc animated:YES completion:nil];

    
}

- (BOOL)navigationShouldPopOnBackButton
{
    return YES;
}

-(void)selelctOrganize:(NSArray *)array{
    NSMutableArray *arrayModel = [[NSMutableArray alloc]init];
    for (DetailedInformationModel *model in array) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[NSNumber numberWithInteger:model.ID] forKey:@"id"];
        [dic setValue:[model.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"text"];
        [arrayModel addObject:dic];
    }
    NSMutableData *tempJsonData = [NSMutableData dataWithData:[self toJSONData:arrayModel]];
    NSString *lal = [[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding];
    NSString *string;
    if ([_urlstring rangeOfString:@"?"].location !=NSNotFound) {
        string = [NSString stringWithFormat:@"%@&sjson=%@",_urlstring,lal];
    }else{
        string = [NSString stringWithFormat:@"%@?sjson=%@",_urlstring,lal];
    }
    NSString *str = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset = scrollView.contentOffset.y;
    if (offset<=0&&offset<=-90) {
        
        self.navigationController.navigationBar.alpha = 0;
        
    }else if(offset<=500){
        
        self.navigationController.navigationBar.alpha = offset/200;
    }

}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(00, 0, kScreen_Width, kScreen_Height-64)];
        _webView.delegate = self;
        _webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        [self.view addSubview:_webView];
//        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.bounces = NO;
        
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{

}


//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是否是自己
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
//    
//    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
//}

@end
