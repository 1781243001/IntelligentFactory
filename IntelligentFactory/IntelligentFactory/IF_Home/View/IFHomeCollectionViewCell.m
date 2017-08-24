//
//  IFHomeCollectionViewCell.m
//  IntelligentFactory
//
//  Created by My Book on 17/6/27.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFHomeCollectionViewCell.h"

@implementation IFHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imgView];
        [self addSubview:self.textLabel];
        [self makeLayout];
    }
    return self;
}

-(void)makeLayout{
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-10);
    }];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).offset(34);
    }];
    
}

-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
//        _textLabel.textColor = [UIColor hexString:@"000"];
        _textLabel.font = [UIFont systemFontOfSize:(14)];
        _textLabel.numberOfLines= 0;
    }
    return _textLabel;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}


@end
