//
//  IFDiffereceAnalyceController.m
//  IntelligentFactory
//
//  Created by My Book on 2017/8/8.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFDiffereceAnalyceController.h"
#import "TLSegmentedControl.h"
#import "IFWebRequestViewModel.h"
#import "InformationDataModel.h"
#import "AnalyceLayoutView.h"
#import "FunctionButton.h"
@interface IFDiffereceAnalyceController ()<TLSegmentedControlDelegate,AnalyceLayoutViewDelegate>{
    
   
    
}
@property (nonatomic,strong) NSArray *mediumArray;
@property (nonatomic,strong) TLSegmentedControl *segmentBar;
@property (nonatomic,strong) NSArray *treeArray; //平铺数据
@property (nonatomic,strong) NSMutableArray *selectArray;

@end

@implementation IFDiffereceAnalyceController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSArray *)mediumArray{

    if (!_mediumArray) {
        _mediumArray = [NSArray array];
    }
    return _mediumArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationBar];
    [self requestNetWork];
}
#pragma mark 获取缓存数据
-(void)filePathData{
    NSString* newFilePath = [self newFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:newFilePath]) //如果存在
    {
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:newFilePath];
        
        if (array.count)
        {
            self.selectArray = [NSMutableArray arrayWithArray:array];
        }
    }else{
        for (int i = 0; i < _mediumArray.count; i++) {
            NSMutableArray *array = [NSMutableArray array];
            [self.selectArray addObject:array];
        }
    }
}

-(NSString *)newFilePath{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *newFilePath = [filePath stringByAppendingPathComponent:@"differeceAnalye.txt"];
    return newFilePath;
}
-(void)requestNetWork{
//    [self.view beginLoading];
    dispatch_queue_t disqueue =  dispatch_queue_create("network", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_async(disqueue, ^{
        dispatch_group_async(group,disqueue, ^{
            dispatch_group_enter(group);//放入group
            
            [IFWebRequestViewModel reqestDiffereceAnalyceMedium:^(id dataObj,NSError *error) {
                dispatch_group_leave(group);
                if (error) {
                    
                }else{
                    
                    self.mediumArray =[[[(InformationDataModel *)dataObj mediumList]firstObject] children];
                }
            }];
        });
        dispatch_group_async(group, disqueue, ^{
            dispatch_group_enter(group);//放入group
            
            [IFWebRequestViewModel reqestDiffereceAnalyceArea:^(id data, NSError *error) {
                dispatch_group_leave(group);
                if (error) {
                    
                }else{
                    if ([data  isKindOfClass:[NSString class]]) {
                        
                    }else{
                        _treeArray =[(InformationDataModel *)data treeList];

                    }
                    
                }
            }];
        });
        
        dispatch_group_notify(group, disqueue, ^{
            // 汇总结果
//            [self.view endLoading];
            
            dispatch_group_enter(group);//放入group
            dispatch_async(dispatch_get_main_queue(), ^{
                [self initSubview];
            });
            dispatch_group_leave(group);
            
        });
    });
}

-(void)navigationBar{
    self.navigationItem.title = @"差异分析管网配置";
    WEAKSELF
    FunctionButton  *button = [[FunctionButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30) withType:(UIButtonTypeCustom) image:@"sequence_delete.png" block:^(UIButton *sender) {
        NSString *newFilePath = [weakSelf newFilePath];
        [NSKeyedArchiver archiveRootObject:weakSelf.selectArray toFile:newFilePath];
        if ([weakSelf.differeceDelegate respondsToSelector:@selector(analyceReturnWebViewData:)]) {
            [weakSelf.differeceDelegate analyceReturnWebViewData:weakSelf.selectArray];
        }
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIBarButtonItem *iten = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[iten];
}

-(void)initSubview{
    if (_mediumArray.count==0) {
        return;
    }
    [self filePathData];
    [self.view addSubview:self.segmentBar];
    [self createAnalyceView:0];

}

-(void)segmentedControl:(TLSegmentedControl *)segmentedControl didSelectIndex:(NSUInteger)index{
    AnalyceLayoutView *layout = (AnalyceLayoutView *)[self.view viewWithTag:814];
    [layout removeFromSuperview];
//    [self filePathData];
    [self createAnalyceView:index];
}

-(void)createAnalyceView:(NSInteger)index{
    AnalyceLayoutView *view = [[AnalyceLayoutView alloc]initLayoutViewWithInfoDic:[_mediumArray objectAtIndex:index] AndTreeArray:_treeArray selectArray:[_selectArray objectAtIndex:index]];
    view.analyDelegate = self;
    view.tag = 814;
    view.frame = CGRectMake(0, CGRectGetMaxY(_segmentBar.frame), kScreen_Width, kScreen_Height - CGRectGetHeight(_segmentBar.frame));
    [self.view addSubview:view];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectOriganitian.png"]];
    image.frame = CGRectMake(0, 0, kScreen_Width, 10);
    [view addSubview:image];

}
#pragma mark ——选中的数据
-(void)returnAnalyceArray:(NSMutableArray *)array{

}

-(TLSegmentedControl *)segmentBar{
    
    if (!_segmentBar) {
        _segmentBar = [[TLSegmentedControl alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width-40, 50) titls:_mediumArray hideAdd:NO delegate:self];
        _segmentBar.spacing = 20;
        _segmentBar.padding = UIEdgeInsetsMake(0, 0, 0, 0);
        _segmentBar.pageWidth = self.view.bounds.size.width / 2;
        _segmentBar.indicatorBarSize = CGSizeMake(30, 3);
        _segmentBar.indicatorBarColor = @[(id)[UIColor blueColor].CGColor,(id)[UIColor blueColor].CGColor];
        _segmentBar.segmentedTitleNormalColor = [UIColor hexString:@"333333"];
        _segmentBar.segmentedTitleSelectedColor = [UIColor hexString:@"005BAC"];
    }
    return _segmentBar;
}

-(NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray  = [NSMutableArray array];
    }
    return _selectArray;
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
