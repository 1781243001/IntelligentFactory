//
//  FunctionButton.m
//  ISTProject
//
//  Created by My Book on 17/6/13.
//  Copyright © 2017年 steven_l. All rights reserved.
//

#import "FunctionButton.h"

@interface FunctionButton(){
    FunctionButton *btn;
}
@property (nonatomic,strong) UILabel *figureLabel;
@end

@implementation FunctionButton

-(instancetype)initWithFrame:(CGRect)frame
                    withType:(UIButtonType)buttonType
                       image:(NSString *)imageString
                       block:(functionBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _block = block;
        [self setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:imageString] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.figureLabel];
    }
    return self;
}

-(void)btnClick:(UIButton *)sender{
   
    _block(self);
}

-(UILabel *)figureLabel{
    
    if (!_figureLabel) {
        _figureLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2+3, -self.frame.size.width/3, 16, 16)];
        _figureLabel.font = [UIFont systemFontOfSize:12];
        _figureLabel.backgroundColor = [UIColor redColor];
        _figureLabel.textColor = [UIColor whiteColor];
        _figureLabel.layer.cornerRadius = 8;
        _figureLabel.hidden = YES;
        _figureLabel.layer.masksToBounds = YES;
        _figureLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _figureLabel;
}

-(void)setFigureLabelText:(NSString *)sting{
    NSInteger sum =[sting integerValue];
    if (sum > 99 ) {
        _figureLabel.frame = CGRectMake(self.frame.size.width/2, -self.frame.size.width/3, 25, 16);
        sting = @"99+";
    }
    if (sting.length) {
        _figureLabel.text = sting;
        _figureLabel.hidden = NO;
    }
    
}
@end
