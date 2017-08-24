//
//  IFSequenceViewController.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/7.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFSequenceViewController.h"
#import "SequenceCollectionViewCell.h"
#import "SequenceCollectionReusableView.h"
#import "SequenceTopCollectionReusableView.h"
#import "FunctionButton.h"
@interface IFSequenceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    BOOL _isSelecting;
}
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@property (nonatomic,strong)UICollectionView *bomttomcollectionView;

@property (nonatomic,strong)NSMutableArray *contentArr;

@property (nonatomic,strong)NSMutableArray *addContenArr;

@property (nonatomic,strong)UILongPressGestureRecognizer *longPressGes;

@property (nonatomic,strong)NSMutableArray *cellAttributesArray;

@property (nonatomic,strong)UIDatePicker *datePick;

@property (nonatomic,strong)UIBarButtonItem *rightItem;

@end

static UIView *snapedView;              //截图快照
static NSIndexPath *currentIndexPath;   //当前路径
static NSIndexPath *oldIndexPath;       //旧路径

@implementation IFSequenceViewController

-(UIDatePicker *)datePick{
    if (!_datePick) {
        _datePick = [[UIDatePicker alloc]init];
        _datePick.datePickerMode = UIDatePickerModeDate;
        _datePick.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"Chinese"];
    }
    return _datePick;
}

-(UIBarButtonItem *)rightItem{
    
    if (!_rightItem) {
        _rightItem = [[UIBarButtonItem alloc]initWithTitle:@"rightItem" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickDatePick)];
    }
    return _rightItem;
}

- (NSMutableArray *)cellAttributesArray {
    if(_cellAttributesArray == nil) {
        _cellAttributesArray = [[NSMutableArray alloc] init];
    }
    return _cellAttributesArray;
}

-(NSMutableArray *)contentArr{
    
    if (!_contentArr) {
        _contentArr = [[NSMutableArray alloc]initWithObjects:@"篮球",@"足球",@"瑜伽",@"游泳",@"狗蛋",@"小李子",@"生煎包",@"神经病",@"雪咖慕斯",@"薛之谦",@"上海",@"深圳市",@"包拯",@"天好热啊",@"翠花",@"包子",@"五星红旗",@"我爱中国", nil];
    }
    return _contentArr;
}
-(NSMutableArray *)addContenArr{
    if (!_addContenArr) {
        _addContenArr = [[NSMutableArray alloc]init];
    }
    return _addContenArr;
}

-(UICollectionView *)bomttomcollectionView{
    
    if (!_bomttomcollectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _bomttomcollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:_flowLayout];
        
        _bomttomcollectionView.delegate = self;
        _bomttomcollectionView.dataSource = self;
        
        _bomttomcollectionView.backgroundColor = [UIColor whiteColor];
        
        [_bomttomcollectionView registerClass:[SequenceCollectionViewCell class] forCellWithReuseIdentifier:@"SequenceCell"];
        [_bomttomcollectionView registerClass:[SequenceCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"mineHeader"];
        [_bomttomcollectionView registerClass:[SequenceTopCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topHeader"];
    }
    return _bomttomcollectionView;
}

-(void)onBackItem{
    UIButton* showOrHidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showOrHidBtn setBackgroundImage:[UIImage imageNamed:@"D_Cn_Order_Add"] forState:UIControlStateNormal];
//    [showOrHidBtn setImage:[UIImage imageNamed:@"D_Cn_Order_Add"] forState:UIControlStateNormal];
    [showOrHidBtn addTarget:self action:@selector(showOrHiddenTextView:) forControlEvents:UIControlEventTouchUpInside];
    showOrHidBtn.frame = CGRectMake(0, 0, 30, 30);
    
//    [self.view addSubview:showOrHidBtn];
    
//    FunctionButton *FB = [[FunctionButton  alloc] initWithFrame:CGRectMake(0, 0, 25, 25) withType:(UIButtonTypeCustom) image:@"D_Cn_Order_Add" block:^(UIButton *sender) {
//       
//    }];
    
    UIBarButtonItem *rightItems = [[UIBarButtonItem alloc]initWithCustomView:showOrHidBtn];
    self.navigationItem.rightBarButtonItem = rightItems;
}
-(void)showOrHiddenTextView:(UIButton *)sender{

    self.seqenceBlock(_addContenArr);
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
//    self.navigationItem.rightBarButtonItems = @[self.rightItem];
//    [self onBackItem];
    [self.view addSubview:self.bomttomcollectionView];
}


#pragma mark rightItem 点击
-(void)clickDatePick{
    [self customTime];
}

-(void)customTime{
    UIAlertController *alert;
    if (!alert) {
        alert = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
          
        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSDate *date = [_datePick date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy/MM/dd"];
            self.rightItem.title = [formatter stringFromDate:date];
        }];

        [alert.view addSubview:self.datePick];
        _datePick.frame = CGRectMake(0, 0, alert.view.bounds.size.width-20, 216);
        [alert addAction:cancel];
        [alert addAction:sure];
    }
    [self presentViewController:alert animated:YES completion:^{
    }];
}
#pragma mark UICollectionView 代理方法

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return self.addContenArr.count;
    }
    else
    {
        
        return self.contentArr.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SequenceCollectionViewCell *tagcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SequenceCell" forIndexPath:indexPath];
    if(indexPath.section == 0)
    {
        [tagcell setData:_addContenArr[indexPath.row] isCancel:NO];
        _longPressGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        _longPressGes.minimumPressDuration = 0.5f;
        [tagcell addGestureRecognizer:_longPressGes];
        
    }
    else
    {
        [tagcell setData:_contentArr[indexPath.row]  isCancel:YES];
    }
    
    return tagcell;
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
    
    if (section ==0) {
        return CGSizeMake(self.view.frame.size.width, 44.0);
  
    }
    
    return CGSizeMake(self.view.frame.size.width, 64.0);
}

/**
 collection的每个section的头视图
 */
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if(indexPath.section == 0)
        {
            SequenceTopCollectionReusableView *topColl = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"topHeader" forIndexPath:indexPath];
            topColl.title.text = @"选定管网清单";
            WEAKSELF;
            topColl.block = ^{
                DHLog(@"回调了");
                weakSelf.seqenceBlock(_addContenArr);
                [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            };
            return topColl;
        }
        else
        {
            SequenceCollectionReusableView *reusaColl = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"mineHeader" forIndexPath:indexPath];
            reusaColl.title.text = @"点击添加更多蒸汽管网";
            
            return reusaColl;
        }
        
    }
    
    return nil;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSelecting) {
        return;
    }
    [self startMoveClickedCellAtIndexpath:indexPath];
}


/**
 点击cell的事件
 */
-(void)startMoveClickedCellAtIndexpath:(NSIndexPath *)indexPath
{
    
    SequenceCollectionViewCell *movedCell = (SequenceCollectionViewCell *)[_bomttomcollectionView cellForItemAtIndexPath:indexPath];
    
    UICollectionViewLayoutAttributes *endAttributes = nil;
    
    NSIndexPath *endIndexPath = nil;
    if (indexPath.section == 0) {
        
        //        if(_isLongPress)
        //        {
        
        [self.contentArr addObject:[self.addContenArr objectAtIndex:indexPath.row]];
        
        endIndexPath = [NSIndexPath indexPathForItem:_contentArr.count - 1 inSection:1];
        
        [self.bomttomcollectionView insertItemsAtIndexPaths:@[endIndexPath]];
        
    }else{
        
        [self.addContenArr addObject:[self.contentArr objectAtIndex:indexPath.row]];
        
        endIndexPath = [NSIndexPath indexPathForItem:_addContenArr.count - 1 inSection:0];
        
        [self.bomttomcollectionView insertItemsAtIndexPaths:@[endIndexPath]];
        
    }
    
    endAttributes = [_bomttomcollectionView layoutAttributesForItemAtIndexPath:endIndexPath];
    
    SequenceCollectionViewCell __weak *endCell = (SequenceCollectionViewCell *)[_bomttomcollectionView cellForItemAtIndexPath:endIndexPath];
    
    typeof(self) __weak weakSelf = self;
    _isSelecting = YES;
    [UIView animateWithDuration:0.3 animations:^{
        
        movedCell.center = endAttributes.center;
        
    } completion:^(BOOL finished) {
        endCell.hidden = NO;
        movedCell.hidden = YES;
        if (indexPath.section == 0) {
            
            [weakSelf.addContenArr removeObjectAtIndex:indexPath.row];
            [weakSelf.bomttomcollectionView deleteItemsAtIndexPaths:@[indexPath]];
            
        }else{
            
            [weakSelf.contentArr removeObjectAtIndex:indexPath.row];
            [weakSelf.bomttomcollectionView deleteItemsAtIndexPaths:@[indexPath]];
            
        }
        _isSelecting = NO;
    }];
    
}

-(void)action:(UILongPressGestureRecognizer *)longPress{
    SequenceCollectionViewCell *cell = (SequenceCollectionViewCell *)longPress.view;
    [_bomttomcollectionView bringSubviewToFront:cell];
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            [self.cellAttributesArray removeAllObjects];
            for (int i = 0; i < self.addContenArr.count; i++) {
                [self.cellAttributesArray addObject:[_bomttomcollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
            }
            oldIndexPath = [_bomttomcollectionView indexPathForItemAtPoint:[longPress locationInView:_bomttomcollectionView]];
            if (oldIndexPath == nil) {
                break;
            }
            UICollectionViewCell *cell = [_bomttomcollectionView cellForItemAtIndexPath:oldIndexPath];
            //使用系统截图功能，得到cell的截图视图
            snapedView = [cell snapshotViewAfterScreenUpdates:NO];
            snapedView.frame = cell.frame;
            [_bomttomcollectionView addSubview:snapedView];
            
            //截图后隐藏当前cell
            cell.hidden = YES;
            
            
        }
            
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            CGPoint currentPoint = [longPress locationInView:_bomttomcollectionView];
            snapedView.center = CGPointMake(currentPoint.x, currentPoint.y);
            
            //计算截图视图和哪个cell相交
            for (SequenceCollectionViewCell *cell in [_bomttomcollectionView visibleCells]) {
                //当前隐藏的_bomttomcollectionViewcell就不需要交换了，直接continue
                if ([_bomttomcollectionView indexPathForCell:cell] == oldIndexPath || cell.cancelView.hidden) {
                    continue;
                }
                //计算中心距
                CGFloat space = sqrtf(pow(snapedView.center.x - cell.center.x, 2) + powf(snapedView.center.y - cell.center.y, 2));
                //如果相交一半就移动
                if (space <= snapedView.bounds.size.width / 2 ) {
                    currentIndexPath = [_bomttomcollectionView indexPathForCell:cell];
                    //移动 会调用willMoveToIndexPath方法更新数据源
                    [_bomttomcollectionView moveItemAtIndexPath:oldIndexPath toIndexPath:currentIndexPath];
                    //设置移动后的起始indexPath
                    oldIndexPath = currentIndexPath;
                    break;
                }
            }
            
        }
            
            break;
            
        case UIGestureRecognizerStateEnded: {
            
            UICollectionViewCell *cell = [_bomttomcollectionView cellForItemAtIndexPath:oldIndexPath];
            //结束动画过程中停止交互，防止出问题
            _bomttomcollectionView.userInteractionEnabled = NO;
            //给截图视图一个动画移动到隐藏cell的新位置
            //            [UIView animateWithDuration:0.25 animations:^{
            snapedView.center = cell.center;
            snapedView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            //            } completion:^(BOOL finished) {
            //移除截图视图、显示隐藏的cell并开启交互
            [snapedView removeFromSuperview];
            cell.hidden = NO;
            _bomttomcollectionView.userInteractionEnabled = YES;
            //            }];
        }
            
            break;
            
        default:
            break;
    }
    
}

-(void)iOS9_Action:(UILongPressGestureRecognizer *)longPress
{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:{//手势开始
            //判断手势落点位置是否在Item上
            NSIndexPath *indexPath = [_bomttomcollectionView indexPathForItemAtPoint:[longPress locationInView:_bomttomcollectionView]];
            if (indexPath == nil) {
                break;
            }
            UICollectionViewCell *cell = [_bomttomcollectionView cellForItemAtIndexPath:indexPath];
            [_bomttomcollectionView bringSubviewToFront:cell];
            //在Item上则开始移动该Item的cell
            [_bomttomcollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:{//手势改变
            //移动过程当中随时更新cell位置
            [_bomttomcollectionView updateInteractiveMovementTargetPosition:[longPress locationInView:_bomttomcollectionView]];
        }
            break;
        case UIGestureRecognizerStateEnded:{//手势结束
            //移动结束后关闭cell移动
            [_bomttomcollectionView endInteractiveMovement];
        }
            break;
        default://手势其他状态
            [_bomttomcollectionView cancelInteractiveMovement];
            break;
    }
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    //返回YES允许其item移动
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //取出源item数据 更新
    id objc = [_addContenArr objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [_addContenArr removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [_addContenArr insertObject:objc atIndex:destinationIndexPath.item];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
//    if (IOS_VERSION < 9.0) {
        [self action:longPress];
//    }else{
//        [self iOS9_Action:longPress];
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
