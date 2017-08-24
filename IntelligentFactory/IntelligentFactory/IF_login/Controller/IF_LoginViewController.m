//
//  IF_LoginViewController.m
//  IntelligentFactory
//
//  Created by My Book on 17/6/27.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IF_LoginViewController.h"
#import "AutoScrollView.h"
#import "IF_HomeViewController.h"
#import "KeychainItemWrapper.h"
@interface IF_LoginViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) AutoScrollView *scrollView;

@end

@implementation IF_LoginViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.scrollView setup];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.scrollView tearDown];
}



-(AutoScrollView *)scrollView{
    
    if (!_scrollView) {
        WEAKSELF;
        _scrollView = [[AutoScrollView alloc] initWithFrame:self.view.frame block:^(NSString *accountnumber, NSString *password) {
            KeychainItemWrapper *wrapper = [AppDelegate sharedApplication].wrapper;
            [wrapper setObject:accountnumber forKey:(id)kSecAttrAccount];
            [wrapper setObject:password forKey:(id)kSecValueData];

//            [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
            NSDictionary *dic = @{@"DeviceID":@"20507b8cd593f4fb",@"UserName":@"wzzhudan",@"Password":@"P%40ssw0rd1234",@"EquipType":@"Android",@"Tel":@"00000000",@"AppID":@"zb.s20160407180753244",@"IsEncrypted":@"false",@"IsApp":@"1",@"IsDev":@"0"};
//            [RequestService AFN_JSONResponseUrlType:RequestloginType requestWay:RequestPost param:dic modelClass:nil responseBlock:^(id dataObj, NSError *error) {
//                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//                if (error) {
//                    return ;
//                }
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.homeListCon];
                [AppDelegate sharedApplication].window.rootViewController = nav;
                UITextField *pass = [_scrollView viewWithTag:passwordFormat];
                pass.text = @"";
//            }];

        }];
//        UIImage *bgImg = [UIImage imageNamed:@"topImage"];
//        UIImageView *bgImgView = [[UIImageView alloc] initWithImage:bgImg];
//        bgImgView.userInteractionEnabled = YES;
//        [bgImgView setFrame:CGRectMake(0, 0, bgImg.size.width, bgImg.size.height)];
//        [_scrollView addSubview:bgImgView];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-20);

    }
    return _scrollView;
}

-(IF_HomeViewController *)homeListCon{
    if (!_homeListCon) {
        _homeListCon = [[IF_HomeViewController alloc]init];
    }
    return _homeListCon;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    [self.view addSubview:self.scrollView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    [_scrollView addGestureRecognizer:tapGestureRecognizer];
 
    // Do any additional setup after loading the view.
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];

    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
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
