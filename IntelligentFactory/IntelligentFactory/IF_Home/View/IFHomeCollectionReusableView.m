//
//  IFHomeCollectionReusableView.m
//  IntelligentFactory
//
//  Created by My Book on 17/6/28.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFHomeCollectionReusableView.h"

@interface IFHomeCollectionReusableView()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation IFHomeCollectionReusableView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    
//        [self addSubview:self.imageView];
        [self addSubview:self.headLabel];
        [self makeLayout];
    }
    return self;
}

-(void)makeLayout{
//    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(10);
//        make.bottom.equalTo(self.mas_bottom).offset(-10);
//        make.left.equalTo(self).offset(10);
//        make.width.mas_equalTo(5);
//    }];
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.left.equalTo(self).offset(10);
//        make.width.mas_equalTo(5);

//        make.top.equalTo(_imageView);
//        make.bottom.equalTo(_imageView);
//        make.left.equalTo(_imageView.mas_right).offset(5);
        
    }];
}

-(UIImageView *)imageView{
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = RGBCOLOR(13, 102, 250);
    }
    return _imageView;
}

-(UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]init];
        _headLabel.textAlignment = NSTextAlignmentLeft;
        _headLabel.font = [UIFont systemFontOfSize:16.f];
        _headLabel.textColor = [UIColor hexString:@"333333"];
    }
    return _headLabel;
}

@end
