//
//  RegionListView.h
//  IntelligentFactory
//
//  Created by My Book on 2017/8/8.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedInformationModel.h"

@protocol RegionListViewDelegate <NSObject>

-(void)RegionListViewHeight:(CGFloat)height;

@end

@interface RegionListView : UIView
- (instancetype)initLayoutViewWithInfoDic:(DetailedInformationModel *)model
                             AndTreeArray:(NSArray *)treeArray;

@property (nonatomic,weak) id<RegionListViewDelegate>delegate;

@end
