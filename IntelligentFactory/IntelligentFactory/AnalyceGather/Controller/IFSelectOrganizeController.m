//
//  IFSelectOrganizeController.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/26.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFSelectOrganizeController.h"
#import "SequenceCollectionViewCell.h"
#import "SequenceTopCollectionReusableView.h"
#import "SelectCustomLayoutView.h"
#import "IFWebRequestViewModel.h"
#import "FunctionButton.h"
@interface IFSelectOrganizeController ()<UICollectionViewDelegate,UICollectionViewDataSource,SelectCustomLayoutViewDelegate>{
    //适用autolayout
    UIView *_containerView;
    SelectCustomLayoutView *_layoutView;
}
@property (nonatomic,strong)UIScrollView *bottomScrollView;

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSMutableArray *tempArr;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong)UILongPressGestureRecognizer *longPressGes;
@property (nonatomic,strong)NSMutableArray *cellAttributesArray;

@end

static UIView *snapedView;              //截图快照
static NSIndexPath *currentIndexPath;   //当前路径
static NSIndexPath *oldIndexPath;       //旧路径


@implementation IFSelectOrganizeController


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)cellAttributesArray {
    if(_cellAttributesArray == nil) {
        _cellAttributesArray = [[NSMutableArray alloc] init];
    }
    return _cellAttributesArray;
}

-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init ];
    }
    return _dataSource;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAddData:) name:SelectDeploy object:nil];
    }
    return self;
}

-(void)notificationAddData:(NSNotification *)notification{
    
    DetailedInformationModel *model = notification.object;
    if (_selelctArr.count < 20) {
        for (DetailedInformationModel *mo in _selelctArr) {
            if (model.ID == mo.ID) {
                [PromptMessage show:@"已存在"];
                return;
            }
        }
        [_selelctArr addObject:model];
    }else{
        [PromptMessage show:@"已达到上限"];
    }
    
    float high =(self.selelctArr.count/3 + ((_selelctArr.count %3) >0?1:0)) * 50 + 44 +(self.selelctArr.count > 0?20:0);
    [_collectionView reloadData];
    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, high));
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationBar];
    [self filePathData];
    [self requsetOrganize:_navigationTitle];
}

-(void)navigationBar{
    self.navigationItem.title = [NSString stringWithFormat:@"%@%@", _navigationTitle,@"区域配置"];
    WEAKSELF;
    FunctionButton  *button = [[FunctionButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30) withType:(UIButtonTypeCustom) image:@"sequence_delete.png" block:^(UIButton *sender) {
        NSString *newFilePath = [weakSelf newFilePath:weakSelf.navigationTitle];
        BOOL success = [NSKeyedArchiver archiveRootObject:weakSelf.selelctArr toFile:newFilePath];
        DHLog(@"%d",success);
        if ([weakSelf.organizeDeleagate respondsToSelector:@selector(selelctOrganize:)]) {
            [weakSelf.organizeDeleagate selelctOrganize:weakSelf.selelctArr];
        };
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIBarButtonItem *iten = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[iten];
 
}

-(void)requsetOrganize:(NSString *)name{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WEAKSELF;
    if ([name isEqualToString:@"计量分析"]) {
        [IFWebRequestViewModel reqestWebViewDataModleblock:^(id dataObj,NSError *error) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            if (error) {
                
            }else{
                if ([dataObj  isKindOfClass:[NSString class]]) {
                    
                }else{
                    weakSelf.dataSource =[(InformationDataModel *)dataObj areaList];
                }
            }
            [weakSelf initSubviews];
        }];

    }else{
    
        [IFWebRequestViewModel reqestProductConsumeDataModleblock:^(id dataObj,NSError *error) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            if (error) {
                
            }else{
                weakSelf.dataSource =[(InformationDataModel *)dataObj treeList];
            }
            [weakSelf initSubviews];
        }];
    }
}
#pragma mark 获取缓存数据
-(void)filePathData{
    NSString* newFilePath = [self newFilePath:_navigationTitle];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:newFilePath]) //如果存在
    {
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:newFilePath];
        
        if (array.count)
        {
            _selelctArr = [NSMutableArray arrayWithArray:array];
        }
    }
}

-(NSString *)newFilePath:(NSString *)name{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *newFilePath = @"";
    if ([name isEqualToString:@"计量分析"]) {
        newFilePath = [filePath stringByAppendingPathComponent:@"measure.txt"];
    }
    else{
        newFilePath = [filePath stringByAppendingPathComponent:@"product.txt"];
    }
    return newFilePath;
}

#pragma mark -创建视图
-(void)initSubviews{
    [self.view addSubview:self.bottomScrollView];
    _containerView = [UIView new];
    [_bottomScrollView addSubview:_containerView];
    _containerView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bottomScrollView);
        make.width.equalTo(_bottomScrollView);
    }];
    [_containerView addSubview:self.collectionView];
    float high =(self.selelctArr.count/3 + ((_selelctArr.count %3) >0?1:0)) * 50 + 44 +(self.selelctArr.count > 0?20:0);
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_containerView);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, high));
    }];
    _layoutView= [[SelectCustomLayoutView alloc]initLayoutViewWithInfoDic:[_dataSource firstObject]];
    [_containerView addSubview:_layoutView];
    _layoutView.delegate = self;
    float height = CGRectGetHeight(_layoutView.frame);
    UIImageView *lineView = [[UIImageView alloc]init];
    lineView.image = [UIImage imageNamed:@"selectOriganitian.png"];
    [_containerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom);
        make.left.mas_equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, 7));
    }];
    [_layoutView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(lineView.mas_bottom);
        make.left.mas_equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, height));
    }];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_layoutView.mas_bottom);
    }];
    
}
-(void)reloadScrollViewSize:(float)height{
    [_layoutView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, height));
    }];
}


#pragma mark UICollectionView 代理方法

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selelctArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SequenceCollectionViewCell *tagcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SequenceCell" forIndexPath:indexPath];

    [tagcell setModelArr:_selelctArr[indexPath.row] isCancel:NO];
    _longPressGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    _longPressGes.minimumPressDuration = 0.5f;
    [tagcell addGestureRecognizer:_longPressGes];
    
    
    return tagcell;
}
- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    [self action:longPress];
}
-(void)action:(UILongPressGestureRecognizer *)longPress{
    SequenceCollectionViewCell *cell = (SequenceCollectionViewCell *)longPress.view;
    [_collectionView bringSubviewToFront:cell];
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            [self.cellAttributesArray removeAllObjects];
            for (int i = 0; i < _selelctArr.count; i++) {
                [self.cellAttributesArray addObject:[_collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
            }
            oldIndexPath = [_collectionView indexPathForItemAtPoint:[longPress locationInView:_collectionView]];
            if (oldIndexPath == nil) {
                break;
            }
            UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:oldIndexPath];
            //使用系统截图功能，得到cell的截图视图
            snapedView = [cell snapshotViewAfterScreenUpdates:NO];
            snapedView.frame = cell.frame;
            [_collectionView addSubview:snapedView];
            
            //截图后隐藏当前cell
            cell.hidden = YES;
            
            
        }
            
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            CGPoint currentPoint = [longPress locationInView:_collectionView];
            snapedView.center = CGPointMake(currentPoint.x, currentPoint.y);
            
            //计算截图视图和哪个cell相交
            for (SequenceCollectionViewCell *cell in [_collectionView visibleCells]) {
                //当前隐藏的_bomttomcollectionViewcell就不需要交换了，直接continue
                if ([_collectionView indexPathForCell:cell] == oldIndexPath || cell.cancelView.hidden) {
                    continue;
                }
                //计算中心距
                CGFloat space = sqrtf(pow(snapedView.center.x - cell.center.x, 2) + powf(snapedView.center.y - cell.center.y, 2));
                //如果相交一半就移动
                if (space <= snapedView.bounds.size.width / 2 ) {
                    currentIndexPath = [_collectionView indexPathForCell:cell];
                    //移动 会调用willMoveToIndexPath方法更新数据源
                    [_collectionView moveItemAtIndexPath:oldIndexPath toIndexPath:currentIndexPath];
                    //设置移动后的起始indexPath
                    oldIndexPath = currentIndexPath;
                    break;
                }
            }
            
        }
            
            break;
            
        case UIGestureRecognizerStateEnded: {
            
            UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:oldIndexPath];
            //结束动画过程中停止交互，防止出问题
            _collectionView.userInteractionEnabled = NO;
            //给截图视图一个动画移动到隐藏cell的新位置
            //            [UIView animateWithDuration:0.25 animations:^{
            snapedView.center = cell.center;
            snapedView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            //            } completion:^(BOOL finished) {
            //移除截图视图、显示隐藏的cell并开启交互
            [snapedView removeFromSuperview];
            cell.hidden = NO;
            _collectionView.userInteractionEnabled = YES;
            //            }];
        }
            
            break;
            
        default:
            break;
    }
    
}

/**
 每个cell 的大小，随着字体大小改变width
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.view.frame.size.width-90)/3,30);
}

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 30.0f;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 15, 20, 15);
}
/**
 collectionView头尺寸
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.view.frame.size.width, 44.0);
        
}

/**
 collection的每个section的头视图
 */
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
            SequenceTopCollectionReusableView *topColl = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"topHeader" forIndexPath:indexPath];
            topColl.title.text = @"选定管网清单";
            WEAKSELF;
            topColl.block = ^{
                DHLog(@"回调了");
            };
            return topColl;
    }
    
    return nil;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self startMoveClickedCellAtIndexpath:indexPath];
}


/**
 点击cell的事件
 */
-(void)startMoveClickedCellAtIndexpath:(NSIndexPath *)indexPath
{
    
//    SequenceCollectionViewCell *movedCell = (SequenceCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
//    
//    UICollectionViewLayoutAttributes *endAttributes = nil;
//    
//    NSIndexPath *endIndexPath = nil;
    [_selelctArr removeObjectAtIndex:indexPath.row];
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    float height =(self.selelctArr.count/3 + ((_selelctArr.count %3) >0?1:0)) * 50 + 44 +(self.selelctArr.count > 0?20:0);
    
    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
//    [self.selelctArr addObject:[self.addContenArr objectAtIndex:indexPath.row]];
    
//    endIndexPath = [NSIndexPath indexPathForItem:_selelctArr.count - 1 inSection:1];
    
//    [_collectionView insertItemsAtIndexPaths:@[endIndexPath]];
//
//    endAttributes = [_collectionView layoutAttributesForItemAtIndexPath:endIndexPath];
    
//    SequenceCollectionViewCell __weak *endCell = (SequenceCollectionViewCell *)[_collectionView cellForItemAtIndexPath:endIndexPath];
//
//    typeof(self) __weak weakSelf = self;
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        movedCell.center = endAttributes.center;
//        
//    } completion:^(BOOL finished) {
//        endCell.hidden = NO;
//        movedCell.hidden = YES;
//        if (indexPath.section == 0) {
//            
//            [weakSelf.selelctArr removeObjectAtIndex:indexPath.row];
//            [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
//            
//        }else{
//            
//            [weakSelf.contentArr removeObjectAtIndex:indexPath.row];
//            [weakSelf.bomttomcollectionView deleteItemsAtIndexPaths:@[indexPath]];
//            
//        }
//    }];
    
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor hexString:@"#F5F5F5"];
        
        [_collectionView registerClass:[SequenceCollectionViewCell class] forCellWithReuseIdentifier:@"SequenceCell"];
        [_collectionView registerClass:[SequenceTopCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topHeader"];
    }
    return _collectionView;
}



-(UIScrollView *)bottomScrollView{
    
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64)];
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.showsVerticalScrollIndicator = NO;
        _bottomScrollView.bounces = NO;
    }
    return _bottomScrollView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)tempArr{
    if (!_tempArr) {
        _tempArr = [NSMutableArray arrayWithObjects:
                    @{@"id":@"1",
                      @"text":@"天津石化",
                      @"iconCls":@"icon-blank",
                      @"state":@"closed",
                      @"parentId":@"-1",
                      @"remark":@"",
                      @"children":@[
                              @{@"id":@"2",
                                @"text":@"炼油",
                                @"iconCls":@"con-blank",
                                @"state":@"closed",
                                @"parentId":@"1",
                                @"remark":@"",
                                @"children":@[
                                        
                                        @{@"id":@"3",
                                          @"text":@"联合一车间a",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置z1",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            ]},                                                  @{@"id":@"4",
                                                                                                                   @"text":@"1＃常减压装置z2",
                                                                                                                   @"iconCls":@"icon-blank",
                                                                                                                   @"state":@"closed",
                                                                                                                   @"parentId":@"14",
                                                                                                                   @"remark":@"",
                                                                                                                   @"children":@[
                                                                                                                           ]},                                                  @{@"id":@"4",
                                                                                                                                                                                  @"text":@"1＃常减压装置z3",
                                                                                                                                                                                  @"iconCls":@"icon-blank",
                                                                                                                                                                                  @"state":@"closed",
                                                                                                                                                                                  @"parentId":@"14",
                                                                                                                                                                                  @"remark":@"",
                                                                                                                                                                                  @"children":@[
                                                                                                                                                                                          ]},                                                  @{@"id":@"4",
                                                                                                                                                                                                                                                 @"text":@"1＃常减压装置z4",
                                                                                                                                                                                                                                                 @"iconCls":@"icon-blank",
                                                                                                                                                                                                                                                 @"state":@"closed",
                                                                                                                                                                                                                                                 @"parentId":@"14",
                                                                                                                                                                                                                                                 @"remark":@"",
                                                                                                                                                                                                                                                 @"children":@[
                                                                                                                                                                                                                                                         ]},@{@"id":@"4",
                                                                                                                                                                                                                                                              @"text":@"1＃常减压装置z4",
                                                                                                                                                                                                                                                              @"iconCls":@"icon-blank",
                                                                                                                                                                                                                                                              @"state":@"closed",
                                                                                                                                                                                                                                                              @"parentId":@"14",
                                                                                                                                                                                                                                                              @"remark":@"",
                                                                                                                                                                                                                                                              @"children":@[
                                                                                                                                                                                                                                                                      ]},@{@"id":@"4",
                                                                                                                                                                                                                                                                           @"text":@"1＃常减压装置z4",
                                                                                                                                                                                                                                                                           @"iconCls":@"icon-blank",
                                                                                                                                                                                                                                                                           @"state":@"closed",
                                                                                                                                                                                                                                                                           @"parentId":@"14",
                                                                                                                                                                                                                                                                           @"remark":@"",
                                                                                                                                                                                                                                                                           @"children":@[
                                                                                                                                                                                                                                                                                   ]},@{@"id":@"4",
                                                                                                                                                                                                                                                                                        @"text":@"1＃常减压装置z4",
                                                                                                                                                                                                                                                                                        @"iconCls":@"icon-blank",
                                                                                                                                                                                                                                                                                        @"state":@"closed",
                                                                                                                                                                                                                                                                                        @"parentId":@"14",
                                                                                                                                                                                                                                                                                        @"remark":@"",
                                                                                                                                                                                                                                                                                        @"children":@[
                                                                                                                                                                                                                                                                                                ]}

                                                  ]},
                                        @{@"id":@"3",
                                          @"text":@"联合一车间a",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置z1",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            ]},                                                  @{@"id":@"4",
                                                                                                                   @"text":@"1＃常减压装置z2",
                                                                                                                   @"iconCls":@"icon-blank",
                                                                                                                   @"state":@"closed",
                                                                                                                   @"parentId":@"14",
                                                                                                                   @"remark":@"",
                                                                                                                   @"children":@[
                                                                                                                           ]}
                                                  
                                                  ]},

                                        @{@"id":@"3",
                                          @"text":@"联合一车间b",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置z1",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            ]},                                                  @{@"id":@"4",
                                                                                                                   @"text":@"1＃常减压装置z2",
                                                                                                                   @"iconCls":@"icon-blank",
                                                                                                                   @"state":@"closed",
                                                                                                                   @"parentId":@"14",
                                                                                                                   @"remark":@"",
                                                                                                                   @"children":@[
                                                                                                                           ]}
                                                  
                                                  ]},
                                        @{@"id":@"3",
                                          @"text":@"联合一车间b",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置z1",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            ]},                                                  @{@"id":@"4",
                                                                                                                   @"text":@"1＃常减压装置z2",
                                                                                                                   @"iconCls":@"icon-blank",
                                                                                                                   @"state":@"closed",
                                                                                                                   @"parentId":@"14",
                                                                                                                   @"remark":@"",
                                                                                                                   @"children":@[
                                                                                                                           ]}
                                                  
                                                  ]},
                                        @{@"id":@"3",
                                          @"text":@"联合一车间b",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置z1",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            ]},                                                  @{@"id":@"4",
                                                                                                                   @"text":@"1＃常减压装置z2",
                                                                                                                   @"iconCls":@"icon-blank",
                                                                                                                   @"state":@"closed",
                                                                                                                   @"parentId":@"14",
                                                                                                                   @"remark":@"",
                                                                                                                   @"children":@[
                                                                                                                           ]}
                                                  
                                                  ]},
                                        
                                        @{@"id":@"3",
                                          @"text":@"联合一车间",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            @{@"id":@"5",
                                                              @"text":@"1＃常减压装置a",
                                                              @"iconCls":@"icon-blank",
                                                              @"state":@"closed",
                                                              @"parentId":@"14",
                                                              @"remark":@"",
                                                              @"children":@[
                                                                      
                                                                      ]},@{@"id":@"5",
                                                                           @"text":@"1＃常减压装置b",
                                                                           @"iconCls":@"icon-blank",
                                                                           @"state":@"closed",
                                                                           @"parentId":@"14",
                                                                           @"remark":@"",
                                                                           @"children":@[
                                                                                   
                                                                                   ]}
                                                            ,@{@"id":@"5",
                                                               @"text":@"1＃常减压装置c",
                                                               @"iconCls":@"icon-blank",
                                                               @"state":@"closed",
                                                               @"parentId":@"14",
                                                               @"remark":@"",
                                                               @"children":@[
                                                                       
                                                                       ]}
                                                            ,@{@"id":@"5",
                                                               @"text":@"1＃常减压装置d",
                                                               @"iconCls":@"icon-blank",
                                                               @"state":@"closed",
                                                               @"parentId":@"14",
                                                               @"remark":@"",
                                                               @"children":@[
                                                                       
                                                                       ]}
                                                            ,@{@"id":@"5",
                                                               @"text":@"1＃常减压装置e",
                                                               @"iconCls":@"icon-blank",
                                                               @"state":@"closed",
                                                               @"parentId":@"14",
                                                               @"remark":@"",
                                                               @"children":@[
                                                                       
                                                                       ]}
                                                            ,@{@"id":@"5",
                                                               @"text":@"1＃常减压装置f",
                                                               @"iconCls":@"icon-blank",
                                                               @"state":@"closed",
                                                               @"parentId":@"14",
                                                               @"remark":@"",
                                                               @"children":@[
                                                                       
                                                                       ]}
                                                            
                                                            ]},
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            @{@"id":@"5",
                                                              @"text":@"1＃常减压装置a",
                                                              @"iconCls":@"icon-blank",
                                                              @"state":@"closed",
                                                              @"parentId":@"14",
                                                              @"remark":@"",
                                                              @"children":@[
                                                                      
                                                                      ]},@{@"id":@"5",
                                                                           @"text":@"1＃常减压装置b",
                                                                           @"iconCls":@"icon-blank",
                                                                           @"state":@"closed",
                                                                           @"parentId":@"14",
                                                                           @"remark":@"",
                                                                           @"children":@[
                                                                                   
                                                                                   ]}
                                                            ,@{@"id":@"5",
                                                               @"text":@"1＃常减压装置c",
                                                               @"iconCls":@"icon-blank",
                                                               @"state":@"closed",
                                                               @"parentId":@"14",
                                                               @"remark":@"",
                                                               @"children":@[
                                                                       
                                                                       ]}
                                                            
                                                            
                                                            
                                                            
                                                            ]}
                                                  
                                                  ]},
                                        
                                        
                                        ]},
                              @{@"id":@"2",
                                @"text":@"炼油",
                                @"iconCls":@"con-blank",
                                @"state":@"closed",
                                @"parentId":@"1",
                                @"remark":@"",
                                @"children":@[
                                        
                                        @{@"id":@"3",
                                          @"text":@"联合一车间a",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置z1",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            ]},                                                  @{@"id":@"4",
                                                                                                                   @"text":@"1＃常减压装置z2",
                                                                                                                   @"iconCls":@"icon-blank",
                                                                                                                   @"state":@"closed",
                                                                                                                   @"parentId":@"14",
                                                                                                                   @"remark":@"",
                                                                                                                   @"children":@[
                                                                                                                           ]},                                                  @{@"id":@"4",
                                                                                                                                                                                  @"text":@"1＃常减压装置z3",
                                                                                                                                                                                  @"iconCls":@"icon-blank",
                                                                                                                                                                                  @"state":@"closed",
                                                                                                                                                                                  @"parentId":@"14",
                                                                                                                                                                                  @"remark":@"",
                                                                                                                                                                                  @"children":@[
                                                                                                                                                                                          ]},                                                  @{@"id":@"4",
                                                                                                                                                                                                                                                 @"text":@"1＃常减压装置z4",
                                                                                                                                                                                                                                                 @"iconCls":@"icon-blank",
                                                                                                                                                                                                                                                 @"state":@"closed",
                                                                                                                                                                                                                                                 @"parentId":@"14",
                                                                                                                                                                                                                                                 @"remark":@"",
                                                                                                                                                                                                                                                 @"children":@[
                                                                                                                                                                                                                                                         ]},@{@"id":@"4",
                                                                                                                                                                                                                                                              @"text":@"1＃常减压装置z4",
                                                                                                                                                                                                                                                              @"iconCls":@"icon-blank",
                                                                                                                                                                                                                                                              @"state":@"closed",
                                                                                                                                                                                                                                                              @"parentId":@"14",
                                                                                                                                                                                                                                                              @"remark":@"",
                                                                                                                                                                                                                                                              @"children":@[
                                                                                                                                                                                                                                                                      ]},@{@"id":@"4",
                                                                                                                                                                                                                                                                           @"text":@"1＃常减压装置z4",
                                                                                                                                                                                                                                                                           @"iconCls":@"icon-blank",
                                                                                                                                                                                                                                                                           @"state":@"closed",
                                                                                                                                                                                                                                                                           @"parentId":@"14",
                                                                                                                                                                                                                                                                           @"remark":@"",
                                                                                                                                                                                                                                                                           @"children":@[
                                                                                                                                                                                                                                                                                   ]},@{@"id":@"4",
                                                                                                                                                                                                                                                                                        @"text":@"1＃常减压装置z4",
                                                                                                                                                                                                                                                                                        @"iconCls":@"icon-blank",
                                                                                                                                                                                                                                                                                        @"state":@"closed",
                                                                                                                                                                                                                                                                                        @"parentId":@"14",
                                                                                                                                                                                                                                                                                        @"remark":@"",
                                                                                                                                                                                                                                                                                        @"children":@[
                                                                                                                                                                                                                                                                                                ]}
                                                  
                                                  ]},
                                        @{@"id":@"3",
                                          @"text":@"联合一车间a",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置z1",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            ]},                                                  @{@"id":@"4",
                                                                                                                   @"text":@"1＃常减压装置z2",
                                                                                                                   @"iconCls":@"icon-blank",
                                                                                                                   @"state":@"closed",
                                                                                                                   @"parentId":@"14",
                                                                                                                   @"remark":@"",
                                                                                                                   @"children":@[
                                                                                                                           ]}
                                                  
                                                  ]},
                                        
                                        @{@"id":@"3",
                                          @"text":@"联合一车间b",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置z1",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            ]},                                                  @{@"id":@"4",
                                                                                                                   @"text":@"1＃常减压装置z2",
                                                                                                                   @"iconCls":@"icon-blank",
                                                                                                                   @"state":@"closed",
                                                                                                                   @"parentId":@"14",
                                                                                                                   @"remark":@"",
                                                                                                                   @"children":@[
                                                                                                                           ]}
                                                  
                                                  ]},
                                        @{@"id":@"3",
                                          @"text":@"联合一车间b",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置z1",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            ]},                                                  @{@"id":@"4",
                                                                                                                   @"text":@"1＃常减压装置z2",
                                                                                                                   @"iconCls":@"icon-blank",
                                                                                                                   @"state":@"closed",
                                                                                                                   @"parentId":@"14",
                                                                                                                   @"remark":@"",
                                                                                                                   @"children":@[
                                                                                                                           ]}
                                                  
                                                  ]},
                                        @{@"id":@"3",
                                          @"text":@"联合一车间b",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置z1",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            ]},                                                  @{@"id":@"4",
                                                                                                                   @"text":@"1＃常减压装置z2",
                                                                                                                   @"iconCls":@"icon-blank",
                                                                                                                   @"state":@"closed",
                                                                                                                   @"parentId":@"14",
                                                                                                                   @"remark":@"",
                                                                                                                   @"children":@[
                                                                                                                           ]}
                                                  
                                                  ]},
                                        
                                        @{@"id":@"3",
                                          @"text":@"联合一车间",
                                          @"iconCls":@"icon-blank",
                                          @"state":@"closed",
                                          @"parentId":@"2",
                                          @"remark":@"",
                                          @"children":@[
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            @{@"id":@"5",
                                                              @"text":@"1＃常减压装置a",
                                                              @"iconCls":@"icon-blank",
                                                              @"state":@"closed",
                                                              @"parentId":@"14",
                                                              @"remark":@"",
                                                              @"children":@[
                                                                      
                                                                      ]},@{@"id":@"5",
                                                                           @"text":@"1＃常减压装置b",
                                                                           @"iconCls":@"icon-blank",
                                                                           @"state":@"closed",
                                                                           @"parentId":@"14",
                                                                           @"remark":@"",
                                                                           @"children":@[
                                                                                   
                                                                                   ]}
                                                            ,@{@"id":@"5",
                                                               @"text":@"1＃常减压装置c",
                                                               @"iconCls":@"icon-blank",
                                                               @"state":@"closed",
                                                               @"parentId":@"14",
                                                               @"remark":@"",
                                                               @"children":@[
                                                                       
                                                                       ]}
                                                            ,@{@"id":@"5",
                                                               @"text":@"1＃常减压装置d",
                                                               @"iconCls":@"icon-blank",
                                                               @"state":@"closed",
                                                               @"parentId":@"14",
                                                               @"remark":@"",
                                                               @"children":@[
                                                                       
                                                                       ]}
                                                            ,@{@"id":@"5",
                                                               @"text":@"1＃常减压装置e",
                                                               @"iconCls":@"icon-blank",
                                                               @"state":@"closed",
                                                               @"parentId":@"14",
                                                               @"remark":@"",
                                                               @"children":@[
                                                                       
                                                                       ]}
                                                            ,@{@"id":@"5",
                                                               @"text":@"1＃常减压装置f",
                                                               @"iconCls":@"icon-blank",
                                                               @"state":@"closed",
                                                               @"parentId":@"14",
                                                               @"remark":@"",
                                                               @"children":@[
                                                                       
                                                                       ]}
                                                            
                                                            ]},
                                                  @{@"id":@"4",
                                                    @"text":@"1＃常减压装置",
                                                    @"iconCls":@"icon-blank",
                                                    @"state":@"closed",
                                                    @"parentId":@"14",
                                                    @"remark":@"",
                                                    @"children":@[
                                                            @{@"id":@"5",
                                                              @"text":@"1＃常减压装置a",
                                                              @"iconCls":@"icon-blank",
                                                              @"state":@"closed",
                                                              @"parentId":@"14",
                                                              @"remark":@"",
                                                              @"children":@[
                                                                      
                                                                      ]},@{@"id":@"5",
                                                                           @"text":@"1＃常减压装置b",
                                                                           @"iconCls":@"icon-blank",
                                                                           @"state":@"closed",
                                                                           @"parentId":@"14",
                                                                           @"remark":@"",
                                                                           @"children":@[
                                                                                   
                                                                                   ]}
                                                            ,@{@"id":@"5",
                                                               @"text":@"1＃常减压装置c",
                                                               @"iconCls":@"icon-blank",
                                                               @"state":@"closed",
                                                               @"parentId":@"14",
                                                               @"remark":@"",
                                                               @"children":@[
                                                                       
                                                                       ]}
                                                            
                                                            
                                                            
                                                            
                                                            ]}
                                                  
                                                  ]},
                                        
                                        
                                        ]},
                              ]},
                    nil];
    }
    return _tempArr;
}

-(NSMutableArray *)selelctArr{
    if (!_selelctArr) {
        _selelctArr = [NSMutableArray array];
    }
    return _selelctArr;
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
