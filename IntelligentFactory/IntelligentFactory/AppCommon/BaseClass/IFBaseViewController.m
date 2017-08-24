//
//  IFBaseViewController.m
//  IntelligentFactory
//
//  Created by My Book on 17/6/27.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFBaseViewController.h"

@interface IFBaseViewController ()

@end

@implementation IFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 50;
    self.fd_prefersNavigationBarHidden = NO;
    // Do any additional setup after loading the view.
}
-(void)dealloc{
    DHLog(@"%@被释放了",[super class]);
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
