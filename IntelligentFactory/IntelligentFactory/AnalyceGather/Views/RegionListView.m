//
//  RegionListView.m
//  IntelligentFactory
//
//  Created by My Book on 2017/8/8.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "RegionListView.h"
#import "TLSegmentedControl.h"
#import "SelectCustomItemView.h"
@interface RegionListView ()<TLSegmentedControlDelegate>{
    float _topMargin;
    DetailedInformationModel *_model;
    NSArray *_treeArray;
}
@property (nonatomic,strong)TLSegmentedControl *segmentBar;
@end

@implementation RegionListView
- (instancetype)initLayoutViewWithInfoDic:(DetailedInformationModel *)model
                             AndTreeArray:(NSArray *)treeArray{
    
    if (self = [super init]) {
        _model = model;
        _treeArray = treeArray;
        self.backgroundColor = [UIColor whiteColor];
        [self initSubviews];
    }
    return  self;
}

-(void)initSubviews{
    float leftMargin = 10;
    UILabel *showTitleName = [[UILabel alloc]initWithFrame:CGRectMake(leftMargin+5, leftMargin, 200, 20)];
    showTitleName.textAlignment = NSTextAlignmentLeft;
    showTitleName.font = [UIFont systemFontOfSize:16];
    showTitleName.textColor = [UIColor hexString:@"333333"];
    showTitleName.text = @"区域清单";
    [self addSubview:showTitleName];
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(showTitleName.frame)+leftMargin, kScreen_Width, 0.5)];
    lineLabel.backgroundColor = [UIColor grayColor];
    [self addSubview:lineLabel];
    
    _topMargin += leftMargin *2 + CGRectGetHeight(showTitleName.frame) + CGRectGetHeight(lineLabel.frame);
    NSMutableArray *tempArr = [NSMutableArray array];
    if (_model.children.count > 0) {
        CGRect rect = CGRectMake(5, CGRectGetMaxY(lineLabel.frame), kScreen_Width-10,  40);
        [self createSegmentBar:rect];
        _topMargin += CGRectGetHeight(_segmentBar.frame);
        for (DetailedInformationModel *model in _treeArray) {
            if (model.remark == [[_model.children firstObject] ID]) {
                [tempArr addObject:model];
            }
        }

    }else{
        for (DetailedInformationModel *model in _treeArray) {
            
            if (model.remark == _model.ID) {
                [tempArr addObject:model];
            }
        }
        
    }
    [self createSelectCustomItem:tempArr];
    self.frame = CGRectMake(0, 0, kScreen_Width, _topMargin);
 
    
}

-(void)segmentedControl:(TLSegmentedControl *)segmentedControl didSelectIndex:(NSUInteger)index{
    NSMutableArray *tempArr = [NSMutableArray array];
    if (_model.children.count > 0) {
        for (DetailedInformationModel *model in _treeArray) {
            if (model.remark == [[_model.children objectAtIndex:index] ID]) {
                [tempArr addObject:model];
            }
        }
    }else{
        for (DetailedInformationModel *model in _treeArray) {
            
            if (model.remark == _model.ID) {
                [tempArr addObject:model];
            }
        }
    }
    SelectCustomItemView *view = [self viewWithTag:8141416];
    CGFloat height = CGRectGetHeight(view.frame);
    _topMargin -= height;
    [view removeFromSuperview];
    [self createSelectCustomItem:tempArr];
    if ([self.delegate respondsToSelector:@selector(RegionListViewHeight:)]) {
        [_delegate RegionListViewHeight:_topMargin];
    }
}

-(void)createSelectCustomItem:(NSArray *)tempArr{

    SelectCustomItemView *SelectCustomItem = [[SelectCustomItemView alloc]initWithFrame:CGRectMake(0, _topMargin, kScreen_Width, 0) dataSource:tempArr block:^(DetailedInformationModel *model, NSInteger ranks, CGRect rect) {
        NSLog(@"%@",model.text);
    }];
    SelectCustomItem.tag = 8141416;
    [self addSubview:SelectCustomItem];
    _topMargin += CGRectGetHeight(SelectCustomItem.frame);
}

-(void)createSegmentBar:(CGRect)rect{

    _segmentBar = [[TLSegmentedControl alloc] initWithFrame:rect titls:_model.children hideAdd:NO delegate:self];
    _segmentBar.spacing = 20;
    _segmentBar.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    _segmentBar.pageWidth = self.bounds.size.width / 2;
    _segmentBar.indicatorBarSize = CGSizeMake(30, 3);
    _segmentBar.indicatorBarColor = @[(id)[UIColor clearColor].CGColor,(id)[UIColor clearColor].CGColor];
    _segmentBar.segmentedTitleNormalColor = [UIColor hexString:@"333333"];
    _segmentBar.segmentedTitleSelectedColor = [UIColor hexString:@"005BAC"];
    [self addSubview:_segmentBar];

}
@end
