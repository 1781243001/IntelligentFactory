//
//  AnalyceLayoutView.m
//  IntelligentFactory
//
//  Created by My Book on 2017/8/8.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "AnalyceLayoutView.h"
#import "SequenceCollectionViewCell.h"
#import "SequenceTopCollectionReusableView.h"
#import "AnalyceLayoutView.h"
#import "RegionListView.h"
@interface AnalyceLayoutView()<UICollectionViewDelegate,UICollectionViewDataSource,RegionListViewDelegate>{
    DetailedInformationModel *_model;
    NSArray *_treeArray;
    UIView *_containerView;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong)UILongPressGestureRecognizer *longPressGes;
@property (nonatomic,strong)NSMutableArray *cellAttributesArray;
@property (nonatomic,strong) RegionListView *regionListView;
@property (nonatomic,strong) NSMutableArray *selelctArr;//选中数组

@end
static UIView *snapedView;              //截图快照
static NSIndexPath *currentIndexPath;   //当前路径
static NSIndexPath *oldIndexPath;       //旧路径

@implementation AnalyceLayoutView

- (instancetype)initLayoutViewWithInfoDic:(DetailedInformationModel *)model
                             AndTreeArray:(NSArray *)treeArray
                              selectArray:(NSMutableArray *)array{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAddData:) name:SelectDeploy object:nil];
        _model = model;
        _treeArray = treeArray;
        _selelctArr = array;
        [self initSubview];
        
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
        if ([self.analyDelegate respondsToSelector:@selector(returnAnalyceArray:)]) {
            [_analyDelegate returnAnalyceArray:_selelctArr];
        }
    }else{
        [PromptMessage show:@"已达到上限"];
    }
    
    float high =(self.selelctArr.count/3 + ((_selelctArr.count %3) >0?1:0)) * 50 + 44 +(self.selelctArr.count > 0?20:0);
    [_collectionView reloadData];
    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, high));
    }];
    
}

-(void)initSubview{

    _containerView = [UIView new];
    [self addSubview:_containerView];
    _containerView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self);
    }];
    [_containerView addSubview:self.collectionView];
    float high =(self.selelctArr.count/3 + ((_selelctArr.count %3) >0?1:0)) * 50 + 44 +(self.selelctArr.count > 0?20:0);
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, high));
    }];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectOriganitian.png"]];
    [_containerView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom);
        make.left.equalTo(_collectionView.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, 10));
    }];
    [_containerView addSubview:self.regionListView];
    float height = CGRectGetHeight(_regionListView.frame);
    [_regionListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image.mas_bottom);
        make.left.equalTo(image.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, height));
    }];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_regionListView.mas_bottom);
    }];
    
}

-(void)RegionListViewHeight:(CGFloat)height{
    
    [_regionListView mas_updateConstraints:^(MASConstraintMaker *make) {

        make.size.mas_equalTo(CGSizeMake(kScreen_Width, height));
    }];
    
}
-(RegionListView *)regionListView{
    
    if (!_regionListView) {
        _regionListView = [[RegionListView alloc]initLayoutViewWithInfoDic:_model AndTreeArray:_treeArray];
        _regionListView.delegate = self;
    }
    return _regionListView;
}

-(NSMutableArray *)selelctArr{
    
    if (!_selelctArr) {
        _selelctArr  = [[NSMutableArray alloc]init];
    }
    return _selelctArr;
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
    return CGSizeMake((self.frame.size.width-90)/3,30);
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
    return CGSizeMake(self.frame.size.width, 44.0);
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
    [_selelctArr removeObjectAtIndex:indexPath.row];
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    float height =(self.selelctArr.count/3 + ((_selelctArr.count %3) >0?1:0)) * 50 + 44 +(self.selelctArr.count > 0?20:0);
    
    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
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


@end
