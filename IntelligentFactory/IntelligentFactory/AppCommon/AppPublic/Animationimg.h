//
//  Animationimg.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/24.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Animationimg : UIView
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic,strong) UIImageView *loadImage;

-(void)startAnimation;


-(void)stopLoadAnimation;
@end
