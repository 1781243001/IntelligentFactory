//
//  SequenceCollectionReusableView.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/7.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "SequenceCollectionReusableView.h"

@implementation SequenceCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , 10)];
        imageV.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        
        [self addSubview:imageV];
        _title = [[UILabel alloc]initWithFrame:CGRectMake(20.0, 10, frame.size.width - 15.0, frame.size.height-10)];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.textColor = [UIColor hexString:@"#333333"];
        [self addSubview:_title];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        label.backgroundColor = [UIColor hexString:@"#C8C7CC"];
        [self addSubview:label];
    }
    return self;
}


@end
