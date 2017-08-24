//
//  UIView+Animation.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/24.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animationimg.h"
@interface UIView (Animation)
@property (strong, nonatomic) Animationimg *loadingView;

- (void)beginLoading;


- (void)endLoading;
@end
