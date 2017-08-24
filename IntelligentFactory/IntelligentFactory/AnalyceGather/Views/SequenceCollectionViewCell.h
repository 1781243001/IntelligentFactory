//
//  SequenceCollectionViewCell.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/7.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedInformationModel.h"
typedef void(^DeleteBlock)(NSIndexPath *indexPath);

@interface SequenceCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *cancelView;

@property (nonatomic,strong) NSIndexPath *indexPath;

-(void)setData:(NSString *)title
      isCancel:(BOOL)isCancel;
-(void)setModelArr:(DetailedInformationModel *)model
          isCancel:(BOOL)isCancel;
@end
