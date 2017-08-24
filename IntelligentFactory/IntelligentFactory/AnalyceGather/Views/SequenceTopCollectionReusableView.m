//
//  SequenceTopCollectionReusableView.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/7.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "SequenceTopCollectionReusableView.h"

@implementation SequenceTopCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(15.0, 0, frame.size.width - 15.0, frame.size.height)];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.textColor = [UIColor hexString:@"#333333"];
        [self addSubview:_title];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        label.backgroundColor = [UIColor hexString:@"#C8C7CC"];
        [self addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(self.frame.size.width - 50, 0, 44, 44);
        [btn setImage:[UIImage imageNamed:@"sequence_delete"] forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"sequence_delete"] forState:(UIControlStateSelected)];
        [btn setImageEdgeInsets:(UIEdgeInsetsMake(6, 6, 6, 6))];
        [btn addTarget:self action:@selector(deleteClickButton) forControlEvents:(UIControlEventTouchUpInside)];
        btn.hidden = YES;
        [self addSubview:btn];
    }
    return self;
}


-(void)deleteClickButton{
    
    _block();
    
}

@end
