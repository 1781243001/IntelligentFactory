//
//  UserMessageView.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/19.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "UserMessageView.h"

@implementation UserMessageView{
    clickHeaderBlock _block;
}

-(instancetype)initWithFrame:(CGRect)frame block:(clickHeaderBlock)block{
    if (self = [super initWithFrame:frame]) {
        _block = block;
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"NavImage"];
        [self addSubview:self.headerImage];
        [self addSubview:self.usenameLabel];
    }
    return  self;
}

-(void)clickHeader{
    _block();
}

-(UIImageView *)headerImage{

    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 100, 100)];
        _headerImage.center = CGPointMake(self.center.x, fabs(self.center.y)-15);
        _headerImage.tag = 10000;
        NSData *image = [[NSUserDefaults standardUserDefaults] objectForKey:@"HeaderPhoto"];
        if (image) {
            _headerImage.image = [UIImage imageWithData:image];
        }else{
            _headerImage.image = [UIImage imageNamed:@"icon_accout"];
        }
        _headerImage.layer.cornerRadius = CGRectGetWidth(_headerImage.frame)/2;
        _headerImage.layer.masksToBounds = YES;
        _headerImage.userInteractionEnabled= YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeader)];
        [_headerImage addGestureRecognizer:tap];

    }
    return _headerImage;
}

-(UILabel *)usenameLabel{
    if (!_usenameLabel) {
        _usenameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerImage.frame)+5, self.bounds.size.width, 30)];
        _usenameLabel.textAlignment = NSTextAlignmentCenter;
        _usenameLabel.font = [UIFont systemFontOfSize:16];
        _usenameLabel.textColor = [UIColor whiteColor];
        _usenameLabel.text = @"智能工厂";
    }
    return _usenameLabel;
}

@end
