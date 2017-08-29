//
//  AnalyceLayoutView.h
//  IntelligentFactory
//
//  Created by My Book on 2017/8/8.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedInformationModel.h"

@protocol AnalyceLayoutViewDelegate <NSObject>

-(void)returnAnalyceArray:(NSMutableArray *)array;

@end

@interface AnalyceLayoutView : UIScrollView

/**
 初始化

 @param model 当前展示数据
 @param treeArray 平铺数据
 @param array 选中数据
 @return self
 */
- (instancetype)initLayoutViewWithInfoDic:(DetailedInformationModel *)model
                             AndTreeArray:(NSArray *)treeArray
                              selectArray:(NSMutableArray *)array;


@property (nonatomic,weak)id<AnalyceLayoutViewDelegate> analyDelegate;

@end
