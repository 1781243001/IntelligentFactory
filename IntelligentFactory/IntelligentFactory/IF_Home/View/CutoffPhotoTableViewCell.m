//
//  CutoffPhotoTableViewCell.m
//  IntelligentFactory
//
//  Created by My Book on 2017/8/9.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "CutoffPhotoTableViewCell.h"
#import "CutPhotoCell.h"
@implementation CutoffPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setData:(NSMutableArray *)photoArray{

    _photoArray = photoArray;
    _maxlength.text = [NSString stringWithFormat:@"%lu/4",(unsigned long)_photoArray.count-1];
    [_collectionView reloadData];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor hexString:@"ffffff"];
        [self addSubview:self.collectionView];
        [self addSubview:self.maxlength];
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photoArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CutPhotoCell";
    CutPhotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if ([[_photoArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        cell.imageView.image = [UIImage imageNamed:[_photoArray objectAtIndex:indexPath.row]];
    }else{
        cell.imageView.image =[_photoArray objectAtIndex:indexPath.row];;
    }
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.imageView.userInteractionEnabled = YES;
    [cell.imageView addGestureRecognizer:singleTap];
    cell.imageView.tag = [indexPath item];
    
    return cell;
}
-(void)customTime{
    if (_photoArray.count == 5) {
        [PromptMessage show:@"照片达到上限"];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(pushPhoto)]) {
        [_delegate pushPhoto];
    }

}
- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    
    if (index == (_photoArray.count)-1) {
        [self customTime];
    }
    else{
       
        
    }
}


#pragma mark --UICollectionViewDelegateFlowLayout
/**
 *  定义每个UICollectionView 的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = 60;
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

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width - 50, 65) collectionViewLayout:layout];
        [_collectionView registerClass:[CutPhotoCell class] forCellWithReuseIdentifier:@"CutPhotoCell"];
        _collectionView.delegate  = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

-(UILabel *)maxlength{

    if (!_maxlength) {
        _maxlength = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_collectionView.frame)+10, 40, 30, 15)];
        _maxlength.textColor = [UIColor lightGrayColor];
        _maxlength.textAlignment = NSTextAlignmentRight;
        _maxlength.font = [UIFont systemFontOfSize:12.f];
        _maxlength.text = @"0/4";
    }
    return _maxlength;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
