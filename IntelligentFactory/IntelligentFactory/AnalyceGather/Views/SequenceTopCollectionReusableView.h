//
//  SequenceTopCollectionReusableView.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/7.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^topReusableViewBlock)();
@interface SequenceTopCollectionReusableView : UICollectionReusableView
@property (nonatomic,strong)UILabel *title;

@property (nonatomic,copy)topReusableViewBlock block;

@end
