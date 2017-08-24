//
//  IFBaseNavigationController.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/25.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFBaseNavigationController.h"

@interface IFBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation IFBaseNavigationController
/**
 这个方法只会在类第一次使用的时候调用
 */
//+(void)initialize{
//    [super initialize];
//    UINavigationBar* NaviBar = [UINavigationBar appearance];
//    [NaviBar setBackgroundImage:[GlobalUse createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
//    //设置主题字体颜色
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [NaviBar setTitleTextAttributes:dict];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    
//    for(UIView* view in self.navigationBar.subviews){
//        for(UIView* vi in view.subviews){
//            if([vi isKindOfClass:[UIImageView class]]){
//                [vi removeFromSuperview];
//            }
//        }
//    }

    
    // Do any additional setup after loading the view.
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count>1) {
        return YES;
    }
    return NO;
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
