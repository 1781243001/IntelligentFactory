//
//  IFHomeNavBarItemView.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/12.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFHomeNavBarItemView.h"

@interface IFHomeNavBarItemView(){
    userDetailsBlock _block;
}
@property (nonatomic,strong) UIImageView *userImgView;
@property (nonatomic,strong) UILabel *userNameLable;
@end

@implementation IFHomeNavBarItemView

-(UILabel *)userNameLable{
    
    if (!_userNameLable) {
        _userNameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_userImgView.frame)+5, 0, self.bounds.size.width-CGRectGetWidth(_userImgView.frame),  self.bounds.size.height)];
        _userNameLable.textColor = [UIColor whiteColor];
        _userNameLable.font = [UIFont systemFontOfSize:13.f];
        _userNameLable.textAlignment = NSTextAlignmentLeft;
    }
    return _userNameLable;
}

-(UIImageView *)userImgView{
    
    if (!_userImgView) {
        _userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 20, 20)];
    }
    return _userImgView;
}

-(instancetype)initWithFrame:(CGRect)frame
                 userMessage:(NSString *)userMessageImage
                    andTitle:(NSString *)title
                       block:(userDetailsBlock)block{

    if (self = [super initWithFrame:frame]) {
        _block = block;
        [self addSubview:self.userImgView];
        [self addSubview:self.userNameLable];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        _userImgView.image = [UIImage imageNamed:userMessageImage];
        _userNameLable.text = [self stringAddTitle:title];        
    }
    return  self;
}

-(NSString *)stringAddTitle:(NSString *)title{
    
    return [NSString stringWithFormat:@"欢迎你,%@",title];
    
}

-(void)tapClick{
    _block();
}


-(void)setImgString:(NSString *)imgString{
    _userImgView.image = [UIImage imageNamed:imgString];
}

-(void)setTitleString:(NSString *)titleString{
    _userNameLable.text = [self stringAddTitle:titleString];
}

@end
