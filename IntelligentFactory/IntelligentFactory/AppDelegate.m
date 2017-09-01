//
//  AppDelegate.m
//  IntelligentFactory
//
//  Created by My Book on 17/6/27.
//  Copyright © 2017年 Iphone. All rights reserved.
//

/**
 
 IF 是 IntelligentFactory的缩写  智能工厂的意思

  */
#import "AppDelegate.h"
#import "IF_HomeViewController.h"
#import "IF_WebHtmlViewController.h"
#import "IF_WKWebHtmlViewController.h"
#import "IFHomeViewModel.h"
#import "VersionModel.h"
#import "IFBaseNavigationController.h"
#import "IF_WelcomeViewController.h"
#import "WelcomeViewPage.h"
#import "IFDiffereceAnalyceController.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>

@interface AppDelegate ()
@property (nonatomic,strong)IF_HomeViewController *home;
@property (nonatomic,strong)IF_WebHtmlViewController *webview;
@property (nonatomic,strong)IF_WKWebHtmlViewController *WkWebView;
@property (nonatomic,strong)IF_WelcomeViewController *welcome;
@property(strong,nonatomic) AFNetworkReachabilityManager            *netManager;

@end

@implementation AppDelegate

+(AppDelegate *)sharedApplication{
    
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [AppDelegate progressWKContentViewCrash];
    [self setNavigationBarColor];
    [self network];
    [self KeychainItemWrapper];
    [self updateResources];
    [self.window makeKeyAndVisible];

//    IFDiffereceAnalyceController *ana = [[IFDiffereceAnalyceController alloc]init];
//    IFBaseNavigationController *na = [[IFBaseNavigationController alloc]initWithRootViewController:ana];
//
//    self.window.rootViewController = na;
    if ([WelcomeViewPage needShow]) {
        self.window.rootViewController = self.welcome;
    }else{
        IFBaseNavigationController *na = [[IFBaseNavigationController alloc]initWithRootViewController:self.loginCon];
        self.window.rootViewController = na;
    }
    
//    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
//    [[PgyManager sharedPgyManager] startManagerWithAppId:@"de76606411c1cba90f336d5a4896c7d8"];
    //启动更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"de76606411c1cba90f336d5a4896c7d8"];
    [[PgyUpdateManager sharedPgyManager] checkUpdate];
    return YES;
}


-(void)KeychainItemWrapper{
    _wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"intelligentFactory" accessGroup:nil];
}



-(void)clearKeychainItemWrapper{
    [_wrapper resetKeychainItem];
}

-(void)setNavigationBarColor{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavImage"] forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    

}

- (void)network{
    _netManager = [AFNetworkReachabilityManager sharedManager];
    [_netManager startMonitoring];
    [_netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                DHLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                DHLog(@"无网络");
                [PromptMessage show:@"无网络"];
                // 没有网络的时候发送通知
//                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNoNetwork object:nil];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                DHLog(@"网络数据连接");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                DHLog(@"wifi连接");
                break;
            default:
                break;
        }
    }];
}
-(IF_WKWebHtmlViewController *)WkWebView{
    if (!_WkWebView) {
        _WkWebView = [[IF_WKWebHtmlViewController alloc]init];
        
    }
    return _WkWebView;
}

-(IF_WebHtmlViewController *)webview{
    if (!_webview) {
        _webview = [[IF_WebHtmlViewController alloc]init];
    }
    return _webview;
}

-(IF_HomeViewController *)home{
    if (!_home) {
        _home = [[IF_HomeViewController alloc]init];
    }
    return _home;
}

-(IF_LoginViewController *)loginCon{
    if (!_loginCon) {
        _loginCon =[[IF_LoginViewController alloc]init];
    }
    return _loginCon;
}

-(IF_WelcomeViewController *)welcome{

    if (!_welcome) {
        _welcome = [[IF_WelcomeViewController alloc]init];
    }
    return _welcome;
}

#pragma mark 退出登陆
-(void)outLogin{
    
}

#pragma mark - 更新资源
-(void)updateResources
{
    NSString *resourceVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"Resourceversion"];
    if (!resourceVersion.length) {
        resourceVersion = @"0.0.0.1";
        NSString *string = [[NSBundle mainBundle] pathForResource:@"intelligentPlant" ofType:nil];
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/intelligentPlant",[FileService themeResouceDir]] error:nil];
        [self copyMissingFile:string toPath:[NSString stringWithFormat:@"%@",[FileService themeResouceDir]]];
    }
    NSDictionary *dic = @{@"DeviceID":@"20507b8cd593f4fb",@"EquipType":@"Android",@"Tel":@"00000000",@"AppID":@"zb.s20170704000000001",@"IsEncrypted":@"false",@"IsApp":@"1",@"IsDev":@"0",@"Resourceversion":resourceVersion,@"Appversion":@"1.0.0.0"};
    [RequestService AFN_JSONResponseUrlType:RequestUpdateCheck requestWay:RequestPost param:dic modelClass:[VersionModel class] responseBlock:^(id dataObj, NSError *error) {
        if (error) {
            return;
        }
        VersionModel *version = dataObj;
        if (version.IsHaveNewResourceVersion == 1) {
            NSString *path = [NSString stringWithFormat:@"%@/?version=%@",[RequestService getUrlType:RequestDownRource],version.NewResourceversion];
            [IFHomeViewModel downLoadHtmlZip:path block:^{
                [[NSUserDefaults standardUserDefaults]setValue:version.NewResourceversion forKey:@"Resourceversion"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }];
        }
    }];

}

/**
 *    @brief    把Resource文件夹下的save1.dat拷贝到沙盒
 *
 *    @param     sourcePath     Resource文件路径
 *    @param     toPath     把文件拷贝到XXX文件夹
 *
 *    @return    BOOL
 */
- (BOOL)copyMissingFile:(NSString *)sourcePath toPath:(NSString *)toPath
{
    BOOL retVal = YES;
    NSString * finalLocation = [toPath stringByAppendingPathComponent:[sourcePath lastPathComponent]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalLocation])
    {
        retVal = [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:finalLocation error:NULL];
    }
    return retVal;
}

- (void)applicationWillResignActive:(UIApplication *)application {
 
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


//#pragma mark 注册通知  支持ios8以上
//-(void)registerAppNotification{
//    UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
//    
//    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:type categories:nil];
//    
//    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
//}
//#ifdef __IPHONE_8_0
//- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
//{
//    //register to receive notifications
//    [application registerForRemoteNotifications];
//}
//
//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
//{
//    //handle the actions
//    if ([identifier isEqualToString:@"declineAction"]){
//    }
//    else if ([identifier isEqualToString:@"answerAction"]){
//    }
//}
//#endif
//
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    NSString* newToken = [[[NSString stringWithFormat:@"%@",deviceToken]
//                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"nsdata:%@\n 字符串token: %@",deviceToken, newToken);// 获取device token
//    //将token发送给服务器
//}
//
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//{
//    NSLog(@"RegistFail %@",error);
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
//{
//    
//}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 处理WKContentView的crash
 [WKContentView isSecureTextEntry]: unrecognized selector sent to instance 0x101bd5000
 */
+ (void)progressWKContentViewCrash {
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)) {
        const char *className = @"WKContentView".UTF8String;
        Class WKContentViewClass = objc_getClass(className);
        SEL isSecureTextEntry = NSSelectorFromString(@"isSecureTextEntry");
        SEL secureTextEntry = NSSelectorFromString(@"secureTextEntry");
        BOOL addIsSecureTextEntry = class_addMethod(WKContentViewClass, isSecureTextEntry, (IMP)isSecureTextEntryIMP, "B@:");
        BOOL addSecureTextEntry = class_addMethod(WKContentViewClass, secureTextEntry, (IMP)secureTextEntryIMP, "B@:");
        if (!addIsSecureTextEntry || !addSecureTextEntry) {
            NSLog(@"WKContentView-Crash->修复失败");
        }
    }
}

/**
 实现WKContentView对象isSecureTextEntry方法
 @return NO
 */
BOOL isSecureTextEntryIMP(id sender, SEL cmd) {
    return NO;
}

/**
 实现WKContentView对象secureTextEntry方法
 @return NO
 */
BOOL secureTextEntryIMP(id sender, SEL cmd) {
    return NO;
}

@end
