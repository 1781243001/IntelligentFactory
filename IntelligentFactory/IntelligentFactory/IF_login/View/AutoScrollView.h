//
//  AutoScrollView.h
//  AutoScrollView
//
//  Created by My Book on 2017/7/17.
//  Copyright (c) 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginTextFileView.h"

typedef void (^loginBlock)(NSString *accountnumber,NSString *password);

@interface AutoScrollView : UIScrollView
@property (nonatomic,strong) UIButton *loginBtn;

@property(assign, nonatomic) CGPoint previousOffset;
-(instancetype)initWithFrame:(CGRect)frame block:(loginBlock)block;

// add the keybord notification
- (void)setup;
// remove the keybord notification
- (void)tearDown;
@end
