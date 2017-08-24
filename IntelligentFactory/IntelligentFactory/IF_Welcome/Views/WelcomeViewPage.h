//
//  WelcomeViewPage.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/25.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewPage : UIImageView
-(instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame;
- (void) setDone;
+ (BOOL)needShow;
@end
