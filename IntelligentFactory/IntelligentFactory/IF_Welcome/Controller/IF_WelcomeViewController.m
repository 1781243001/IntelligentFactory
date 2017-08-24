//
//  IF_WelcomeViewController.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/25.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IF_WelcomeViewController.h"
#import "WelcomeViewPage.h"
@interface IF_WelcomeViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;

@end

@implementation IF_WelcomeViewController

-(UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    
    NSArray *tepArr = @[@"welcomepage1",@"welcomepage2"];
    CGRect rect = _scrollView.bounds;
    for (NSInteger i = 0; i<tepArr.count; i++) {
        WelcomeViewPage *page = [[WelcomeViewPage alloc] initWithImage:[UIImage imageNamed:tepArr[i]] frame:rect];
        [self.scrollView addSubview:page];
        rect.origin.x += rect.size.width;
        if (i == 0) {
            [page setDone];
        }else if (i == tepArr.count-1){
        
            UISwipeGestureRecognizer *swipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction)];
            swipe.direction =UISwipeGestureRecognizerDirectionLeft;
            swipe.delegate = self;
            [page addGestureRecognizer:swipe];
        }
    }
    _scrollView.contentSize = CGSizeMake(tepArr.count*CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
//    [self.view addSubview:self.pageControl];
//    _pageControl.numberOfPages = tepArr.count;
    // Do any additional setup after loading the view.
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([gestureRecognizer.view isKindOfClass:[WelcomeViewPage class]] ){
        _scrollView.scrollEnabled = NO;
        return YES;
    }else{
        
        _scrollView.scrollEnabled = YES;
        return NO;
    }
    
}
-(void)swipeAction{

    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"OnlyOne"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    AppDelegate *app = [AppDelegate sharedApplication];
    app.window.rootViewController = app.loginCon;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.center = CGPointMake(self.view.center.x, CGRectGetHeight(_scrollView.frame) - 25);
        _pageControl.bounds = CGRectMake(0, 0, 150, 50);
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
    }
    return _pageControl;
}

- (void) scrollViewDidScroll:(UIScrollView *)sender
{
    // 得到每页宽度
    CGFloat pageWidth = sender.frame.size.width;
    
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    if (currentPage == 1) {
//        sender.scrollEnabled = NO;
//    }
//    if (currentPage == 3)
//    {
//        _pageControl.hidden = YES;
//    }else
//    {
//        _pageControl.hidden = NO;
//        _pageControl.currentPage = currentPage;
//    }
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
