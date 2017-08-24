//
//  CutoffPhotoTableViewCell.h
//  IntelligentFactory
//
//  Created by My Book on 2017/8/9.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CutoffPhotoTableViewCellDetagate <NSObject>

-(void)pushPhoto;

@end

@interface CutoffPhotoTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,weak) id<CutoffPhotoTableViewCellDetagate>delegate;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UILabel *maxlength;

@property (nonatomic,strong) NSMutableArray *photoArray;
-(void)setData:(NSMutableArray *)photoArray;
@end
