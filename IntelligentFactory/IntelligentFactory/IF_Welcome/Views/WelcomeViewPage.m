//
//  WelcomeViewPage.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/25.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "WelcomeViewPage.h"

@interface WelcomeViewPage()
@property(nonatomic,strong)UIButton *doneButton;
@end


@implementation WelcomeViewPage

-(instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.image = image;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setDone{

    [self addSubview:self.doneButton];
    
}

-(UIButton *)doneButton{

    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _doneButton.frame = CGRectMake(kScreen_Width - 70, 30, 50, 30);
        [_doneButton setTitle:@"跳过" forState:UIControlStateNormal];
        _doneButton.layer.cornerRadius = 15;
        _doneButton.layer.masksToBounds = YES;
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_doneButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(onDone) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_doneButton];
        _doneButton.userInteractionEnabled = YES;
 
    }
    return _doneButton;
}


-(void)onDone{

    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"OnlyOne"];
    AppDelegate *app = [AppDelegate sharedApplication];
    app.window.rootViewController = app.loginCon;
}

+ (BOOL)needShow
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"OnlyOne"] == nil;
}

@end
