//
//  SelectCustomLayoutView.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/28.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "SelectCustomLayoutView.h"
#import "TLSegmentedControl.h"
#import "SequenceCollectionViewCell.h"
#import "SelectCustomItemView.h"
@interface SelectCustomLayoutView()<TLSegmentedControlDelegate>{
    float topMargin;
    float height;
    NSInteger _ranks;

}
@property (nonatomic, strong) DetailedInformationModel *model;
@property (nonatomic,strong)NSArray *dataSource;
@end

@implementation SelectCustomLayoutView


- (instancetype)initLayoutViewWithInfoDic:(DetailedInformationModel *)model{
    if (self = [super init]) {
        _model = model;
        self.backgroundColor = [UIColor whiteColor];
        [self initSubviews];
    }
    return  self;
}

-(void)initSubviews{
    float leftMargin = 15;
    UILabel *showTitleName = [[UILabel alloc]initWithFrame:CGRectMake(leftMargin, leftMargin, 200, 30)];
    showTitleName.textAlignment = NSTextAlignmentLeft;
    showTitleName.font = [UIFont systemFontOfSize:16];
    showTitleName.textColor = [UIColor hexString:@"333333"];
    showTitleName.text = @"区域清单";
    [self addSubview:showTitleName];
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(showTitleName.frame)+leftMargin, kScreen_Width, 0.5)];
    lineLabel.backgroundColor = [UIColor grayColor];
    [self addSubview:lineLabel];

    topMargin += leftMargin *2 + CGRectGetHeight(showTitleName.frame) + CGRectGetHeight(lineLabel.frame);
    
    [self createView:_model];
    
    self.frame = CGRectMake(0, 0, kScreen_Width, topMargin);

    
}
-(void)createView:(DetailedInformationModel *)model {
    UIView *view = nil;
    NSArray *arr = model.children;
    CGRect rect ;
    NSLog(@"title====%@",model.text);
    if (arr.count>0) {
        rect = CGRectMake(10, topMargin, kScreen_Width-20, 40);
        view =[self createSegmentBar:arr frame:rect];
        [self addSubview:view];
        topMargin += CGRectGetHeight(view.frame);
        _dataSource = arr;
        _ranks = 900;
        [self handleDataSourse:[[arr firstObject] children]];
    }

}

-(void)handleDataSourse:(NSArray *)arr{
    
    
    CGRect rect1 = CGRectMake(0, topMargin, kScreen_Width, 0);
    if (arr.count>0) {
        WEAKSELF;
        __block float margin =topMargin;
        SelectCustomItemView *itemView = [[SelectCustomItemView alloc]initWithFrame:rect1 dataSource:arr block:^(DetailedInformationModel *model,NSInteger ranks,CGRect rect) {
            UIView *lowerView = [weakSelf viewWithTag:(ranks)];
            for (UIView *view in weakSelf.subviews) {
                if (lowerView.tag - view.tag <0) {
                    [view removeFromSuperview];
                }
            }
            margin = CGRectGetHeight(rect) + CGRectGetMinY(rect);
            topMargin = margin;
            _ranks = ranks;
            [weakSelf handleDataSourse:model.children];
            if ([_delegate respondsToSelector:@selector(respondsToSelector:)]) {
                [weakSelf.delegate reloadScrollViewSize:topMargin];
            }
        
        }];
        _ranks += 1;
        itemView.tag = _ranks;
        [self addSubview:itemView];
        topMargin+= CGRectGetHeight(itemView.frame);
        [self handleDataSourse:[[arr firstObject] children]];
        
    }


    
}

-(TLSegmentedControl *)createSegmentBar:(NSArray *)showArr frame:(CGRect)rect{
    TLSegmentedControl *segmentBar = [[TLSegmentedControl alloc] initWithFrame:rect titls:showArr hideAdd:YES delegate:self];
    segmentBar.spacing = 20;
    segmentBar.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    segmentBar.pageWidth = self.bounds.size.width / 2;
    segmentBar.indicatorBarSize = CGSizeMake(10, 3);
    segmentBar.indicatorBarColor = @[(id)[UIColor orangeColor].CGColor,(id)[UIColor redColor].CGColor];
    segmentBar.segmentedTitleNormalColor = [UIColor hexString:@"333333"];
    segmentBar.segmentedTitleSelectedColor = [UIColor hexString:@"005BAC"];
    return segmentBar;
}

-(void)segmentedControl:(TLSegmentedControl *)segmentedControl didSelectIndex:(NSUInteger)index{

    
    for (UIView *view in self.subviews) {
        if (view.tag >= 900) {
            topMargin -= CGRectGetHeight(view.frame);
            [view removeFromSuperview];
        }
    }
    _ranks = 900;
    [self handleDataSourse:[[_dataSource objectAtIndex:index] children]];
    if ([_delegate respondsToSelector:@selector(respondsToSelector:)]) {
        [self.delegate reloadScrollViewSize:topMargin];
    }

}






@end
