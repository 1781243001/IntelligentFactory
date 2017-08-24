//
//  SelectCustomLayoutView.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/28.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedInformationModel.h"

typedef NS_ENUM(NSInteger,LayoutViewType){
    
    ScrollLayoutType = 700,//滚动
    doubleLevelLayoutType,//双平铺
    LevelLayoutType,//平铺
};

@protocol SelectCustomLayoutViewDelegate <NSObject>
@optional

-(void)reloadScrollViewSize:(float)height;

@end

@interface SelectCustomLayoutView : UIView

@property (nonatomic,weak)id<SelectCustomLayoutViewDelegate>delegate;

- (instancetype)initLayoutViewWithInfoDic:(DetailedInformationModel *)model;


@end
