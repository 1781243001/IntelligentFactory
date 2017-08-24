//
//  UIView+Animation.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/24.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "UIView+Animation.h"

static const void *LoadingView_Key = "loadingView_Key";

@implementation UIView (Animation)
-(void)setLoadingView:(Animationimg *)loadingView{
    
    objc_setAssociatedObject(self, &LoadingView_Key,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Animationimg *)loadingView{
    return objc_getAssociatedObject(self, &LoadingView_Key);
}

-(void)beginLoading{
    if (!self.loadingView) { //初始化LoadingView
        self.loadingView = [[Animationimg alloc] initWithFrame:self.bounds];
        [self addSubview:self.loadingView];
        [self.loadingView startAnimation];
    }else{
        [self.loadingView startAnimation];
    }
}

- (void)endLoading{
    if (self.loadingView) {
        [self.loadingView stopLoadAnimation];
    }
}

@end
