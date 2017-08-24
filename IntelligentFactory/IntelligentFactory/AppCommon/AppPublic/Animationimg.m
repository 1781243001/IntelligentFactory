//
//  Animationimg.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/24.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "Animationimg.h"

@implementation Animationimg

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.loadImage.bounds = CGRectMake(0, 0, 60, 60);
        _loadImage.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2.5);
        [self addSubview:_loadImage];
        
        NSMutableArray *imageNSarray = [[NSMutableArray alloc] init];
        
        for (int i = 1; i<3; i++) {
            NSString *ter =[NSString stringWithFormat:@"welcomepage%d.png",i];
            [imageNSarray addObject:[UIImage imageNamed:ter]];
        }
        
        //设置动画数组
        [_loadImage setAnimationImages:imageNSarray];
        //设置动画播放次数
        [self.loadImage setAnimationRepeatCount:0];
        
        //设置动画播放时间animationDuration
        [self.loadImage setAnimationDuration:1];
        
    }
    return self;
}

#pragma mark -- 开始动画
-(void)startAnimation{
    //开始动画
    [_loadImage startAnimating];
}

-(void)stopLoadAnimation{
    
    [self removeFromSuperview];
    
}
-(UIImageView *)loadImage{
    
    if (!_loadImage) {
        _loadImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_1"]];
    }
    return _loadImage;
    
}

@end
