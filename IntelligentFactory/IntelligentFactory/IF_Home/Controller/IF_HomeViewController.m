//
//  IF_HomeViewController.m
//  IntelligentFactory
//
//  Created by My Book on 17/6/27.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IF_HomeViewController.h"
#import "IFHomeCollectionViewCell.h"
#import "IFHomeCollectionReusableView.h"
#import "IFHomeViewModel.h"
#import "IF_WebHtmlViewController.h"
#import "IF_WKWebHtmlViewController.h"
#import "IFSequenceViewController.h"
#import "IFHomeNavBarItemView.h"
#import "FunctionButton.h"
#import "IF_UserCentreViewController.h"
#import "IFSelectOrganizeController.h"
#import "FeedbackIdeaViewController.h"
@interface IF_HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIWebViewDelegate>
{
    IFHomeViewModel *_homeViewModel;
    NSString *_string;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIImageView *headerView;
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@end

@implementation IF_HomeViewController



- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"";
    [self createWholeView];
       
    //    [wrapper resetKeychainItem];

//    for (int i = 0; i < 3; i++) {
//        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        btn.frame = CGRectMake(100, 100+55*i, 100, 50);
//        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:(UIControlStateNormal)];
//        [btn addTarget:self action:@selector(lalal:) forControlEvents:(UIControlEventTouchUpInside)];
//        [self.view addSubview:btn];
//        btn.backgroundColor = [UIColor yellowColor];
//        btn.tag = i;
//        btn.titleLabel.font = [UIFont fontForFontName:FontNameBaskervilleSemiBoldItalic size:17];
//    }
    
}

#pragma mark ---创建视图
-(void)createWholeView{
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    [self collectionListView];
    [self naivigationItemView];
}

-(void)collectionListView{
    [self.view addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
-(void)naivigationItemView{
    //    NSData *imageData = [NSData dataWithContentsOfFile:@""];
    //    [UIImage imageWithData:imageData];
    NSString *userNameString = @"智能工厂";
    WEAKSELF;
    IFHomeNavBarItemView *item = [[IFHomeNavBarItemView alloc]
                                  initWithFrame:CGRectMake(0, 0, kScreen_Width/2, 30)
                                    userMessage:@"home_mine"
                                       andTitle:userNameString
                                          block:^{
                                              IF_UserCentreViewController *user = [[IF_UserCentreViewController alloc]init];
                                              [weakSelf.navigationController pushViewController:user animated:YES];
                                  }];
    UIBarButtonItem *headerItem = [[UIBarButtonItem alloc]initWithCustomView:item];

    self.navigationItem.leftBarButtonItems = @[headerItem];
    
    FunctionButton *FB = [[FunctionButton  alloc] initWithFrame:CGRectMake(0, 0, 25, 25) withType:(UIButtonTypeCustom) image:@"home_feedback" block:^(UIButton *sender) {
//        IFSelectOrganizeController *svc = [[IFSelectOrganizeController alloc]init];
//        UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:svc];
//        [weakSelf.navigationController presentViewController:na animated:YES completion:nil];

        FeedbackIdeaViewController *feed = [[FeedbackIdeaViewController alloc]init];
        [weakSelf.navigationController pushViewController:feed animated:YES];
    }];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:FB];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (NSString *)getTimeNow
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    return [[NSString alloc] initWithFormat:@"%@", date];
}
-(void)lalal:(UIButton *)btn{
    [self shakeView:btn];
    switch (btn.tag) {
        case 0:{
            if (IOS_VERSION < 9) {
                IF_WebHtmlViewController *web = [[IF_WebHtmlViewController alloc]init];
                web.urlstring = [NSString stringWithFormat:@"%@/zhiNengGongChnang/index.html",[FileService themeResouceDir]];
                [self.navigationController pushViewController:web animated:YES];
//                
            }else{
                IF_WKWebHtmlViewController *web = [[IF_WKWebHtmlViewController alloc]init];
//                web.urlstring = [NSString stringWithFormat:@"%@/zhiNengGongChnang/index.html",[FileService themeResouceDir]];
                web.urlstring = @"http://192.168.1.130:8080/";
                [self.navigationController pushViewController:web animated:YES];
            }
        }
            break;
        case 1:{
            IFSequenceViewController *sequence = [[IFSequenceViewController alloc]init];
            sequence.seqenceBlock = ^(NSMutableArray *array){
                DHLog(@"%@",array);
            };
            [self.navigationController pushViewController:sequence animated:YES];
        }
            break;
        case 2:{
            
        }
            break;
        default:
            break;
    }
}

- (void)shakeView:(UIButton *)btn{
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    [btn.layer addAnimation:shake forKey:@"shake"];
}

-(void) showAlt{
    
    UIAlertView *ale = [[UIAlertView alloc]initWithTitle:_string message:[self getTimeNow] delegate:nil cancelButtonTitle:@"hao" otherButtonTitles:nil, nil];
    [ale show];
}

-(void)creatView{

    NSString *filePath = @"http://10.238.119.23/app/api/File/GetFile/version=2";
    dispatch_queue_t disqueue =  dispatch_queue_create("network", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_async(disqueue, ^{
        dispatch_group_async(group,disqueue, ^{
            dispatch_group_enter(group);//放入group
            [IFHomeViewModel reqestHomeDataModle:^{
                dispatch_group_leave(group);
            }];
        });
        dispatch_group_async(group, disqueue, ^{
            dispatch_group_enter(group);//放入group
            [IFHomeViewModel downLoadHtmlZip:filePath block:^{
                dispatch_group_leave(group);
            }];
            
        });
        
        dispatch_group_notify(group, disqueue, ^{
            // 汇总结果
            dispatch_group_enter(group);//放入group
            dispatch_async(dispatch_get_main_queue(), ^{
                //                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            dispatch_group_leave(group);
            
        });
        
    });

}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //头部大小
        flowLayout.headerReferenceSize = CGSizeMake(kScreen_Width, 40);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[IFHomeCollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, -200, kScreen_Width, 200)];
        imageV.image = [UIImage imageNamed:@"topImage.png"];
        [_collectionView addSubview:imageV];
        _collectionView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.collectionView];
        [_collectionView registerClass:[IFHomeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReuseableView"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[
                        @{@"title":@"仪表盘",@"image":@"home_instrumentBoard"},
                        @{@"title":@"产耗分析",@"image":@"home_drain"},
                        @{@"title":@"计量分析",@"image":@"home_measure"},
                        @{@"title":@"能源指标",@"image":@"home_energy"},
                        @{@"title":@"差异分析",@"image":@"home_difference"},
                        @{@"title":@"动力在线优化",@"image":@"home_impetus"}];
        
    }
    return _dataSource;
}
#pragma mark ---UICollectionViewDataSource
/**
 *  UICollectionViewCell的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
/**
 *  section的个数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

/**
 *  每个UICollectionView展示的内容
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"myCell";
    IFHomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        
    }
    NSDictionary *dataDic = [_dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = [dataDic objectForKey:@"title"];
    cell.imgView.image = [UIImage imageNamed:[dataDic objectForKey:@"image"]];
    return cell;
}
/**
 *  头部显示的内容
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    IFHomeCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReuseableView" forIndexPath:indexPath];
    headerView.headLabel.text = @"业务功能";
    return headerView;
}

#pragma mark --UICollectionViewDelegateFlowLayout
/**
 *  定义每个UICollectionView 的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat spacing = 1;
    CGFloat itemWidth = (kScreen_Width- spacing*3)/3.0;
    CGFloat itemHeight = itemWidth;
    return CGSizeMake(itemWidth,itemHeight);
}

/**
 *  定义每个UICollectionView 的横向间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
/**
 *  定义每个UICollectionView 的 竖向间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
#pragma mark --UICollectionViewDelegate
/**
 *  UICollectionView被选中时调用的方法
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *urlString = @"";
    switch (indexPath.row) {
        case 0:
            urlString = [NSString stringWithFormat:@"%@/intelligentPlant/index.html",[FileService themeResouceDir]];
            break;
        case 1:
            urlString = [NSString stringWithFormat:@"%@/intelligentPlant/chanHaoFXDepartment.html",[FileService themeResouceDir]];
            break;
        case 2:{
            urlString = [NSString stringWithFormat:@"%@/intelligentPlant/jiLiangFXDepartment.html",[FileService themeResouceDir]];
        }
            break;
        case 3:
            urlString = [NSString stringWithFormat:@"%@/intelligentPlant/nengyuanZBdetails.html",[FileService themeResouceDir]];
            break;
        case 4:
//            urlString = [NSString stringWithFormat:@"%@/intelligentPlant/chaYiFX.html",[FileService themeResouceDir]];
            break;
        case 5:
            urlString = [NSString stringWithFormat:@"%@/intelligentPlant/dongLiZaiXianYHz.html",[FileService themeResouceDir]];
            break;
        default:
            break;
    }
//    if (!urlString || !(urlString.length > 0)) {
//        urlString = @"";
//    }
//    if (IOS_VERSION < 9) {
        IF_WebHtmlViewController *web = [[IF_WebHtmlViewController alloc]init];
        web.urlstring = urlString;
        web.navigationTitle = [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"title"];
        [self.navigationController pushViewController:web animated:YES];
//    }else{
//        IF_WKWebHtmlViewController *web = [[IF_WKWebHtmlViewController alloc]init];
//        web.urlstring = urlString;
//        web.title = [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"title"];
//        [self.navigationController pushViewController:web animated:YES];
//    }
//
}
/**
 *  返回这个UICollectionView是否可以被选择
 */
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
////定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 10, 10, 10);
//}


@end
