//
//  AutoScrollView.m
//  AutoScrollView
//
//  Created by My Book on 2017/7/17.
//  Copyright (c) 2017年 Iphone. All rights reserved.
//

#import "AutoScrollView.h"

@interface AutoScrollView (){
    loginBlock _loginblock;
}
@property (nonatomic,strong) loginTextFileView *account;
@property (nonatomic,strong) loginTextFileView *password;
@property (nonatomic,strong) UILabel *latestEdition;//最新版本号
@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UILabel *appNameLabel;

- (void)keyboardWillShow:(NSNotification *)notification;

- (void)keyboardWillHide:(NSNotification *)notification;

@end

@implementation AutoScrollView


-(instancetype)initWithFrame:(CGRect)frame block:(loginBlock)block{
    if (self = [super initWithFrame:frame]) {
        _loginblock = block;
        [self addSubview:self.logoImageView];
        [self addSubview:self.appNameLabel];
        [self addSubview:self.account];
        [self addSubview:self.password];
        [self addSubview:self.loginBtn];
        [self addSubview:self.latestEdition];
        [self setacountText];
    }
    return self;
}

-(void)setacountText{
    KeychainItemWrapper *wrapper = [AppDelegate sharedApplication].wrapper;
    NSString *password = [wrapper objectForKey:(id)kSecAttrAccount];
    if (password.length>0) {
        UITextField *pass = [self viewWithTag:accountNumberFormat];
        pass.text = password;
    }
}

-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width - 62)/2, 80, 62, 65)];
        _logoImageView.image = [UIImage imageNamed:@"login_image"];
    }
    return _logoImageView;
}

-(UILabel *)appNameLabel{
    
    if (!_appNameLabel) {
        _appNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_logoImageView.frame)+10, kScreen_Width, 40)];
//        NSString *titleDetail = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        _appNameLabel.text = @"智能制造移动应用";
        _appNameLabel.textColor = [UIColor hexString:@"333333"];
        _appNameLabel.font = [UIFont systemFontOfSize:22.0f];
        _appNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _appNameLabel;
}

-(loginTextFileView *)account{
    if (!_account) {
        _account = [[loginTextFileView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_appNameLabel.frame)+60, kScreen_Width-60, 40) type:accountNumberFormat];
    }
    return _account;
}

-(loginTextFileView *)password{
    if (!_password) {
        _password = [[loginTextFileView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_account.frame)+20, CGRectGetWidth(_account.frame), CGRectGetHeight(_account.frame)) type:passwordFormat];
    }
    return _password;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _loginBtn.frame = CGRectMake(30, CGRectGetMaxY(_password.frame)+50,kScreen_Width - 60, 40);
        [_loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _loginBtn.backgroundColor = [UIColor hexString:@"005bac"];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = CGRectGetHeight(_loginBtn.frame)/2;
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loginBtn addTarget:self action:@selector(onLogin) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginBtn;
}

-(UILabel *)latestEdition{
    if (!_latestEdition) {
        _latestEdition= [[UILabel alloc]initWithFrame:CGRectMake(0, kScreen_Height - 60, kScreen_Width, 20)];
        NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];

        NSString *string = [NSString stringWithFormat:@"智能制造移动应用 V%@",versionString];
        _latestEdition.textAlignment = NSTextAlignmentCenter;
        _latestEdition.text = string;
        _latestEdition.font = [UIFont systemFontOfSize:12.0f];
        _latestEdition.textColor = [UIColor hexString:@"333333"];
    }
    return _latestEdition;
}

-(void)onLogin{
    UITextField *account = [self viewWithTag:accountNumberFormat];
    UITextField *pass = [self viewWithTag:passwordFormat];
    NSString *accountnumber = account.text;
    NSString *password = pass.text;
    [account resignFirstResponder];
    [pass resignFirstResponder];
    if (accountnumber.length && password.length) {
         _loginblock(accountnumber,password);
    }else{
        [PromptMessage show:@"账号或密码不能为空"];
    }
    
    
}

// hide keybord when touch croll view
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
    self.contentOffset = self.previousOffset;
}


- (void)setup
{
    self.previousOffset = self.contentOffset;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)tearDown
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// scroll contentOffset when keybord will show 
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    // get keyboard rect in windwo coordinate 
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // convert keyboard rect from window coordinate to scroll view coordinate
    keyboardRect = [self convertRect:keyboardRect fromView:nil];
    
    // get keybord anmation duration
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // get first responder textfield 
    UIView *currentResponder = [self findFirstResponderBeneathView:self];
    if (currentResponder != nil)
    {
        // convert textfield left bottom point to scroll view coordinate
        CGPoint point = [currentResponder convertPoint:CGPointMake(0, currentResponder.frame.size.height) toView:self];
        
        // 计算textfield左下角和键盘上面20像素 之间是不是差值
        float scrollY = point.y - (keyboardRect.origin.y - 20);
        if (scrollY > 0) {
            [UIView animateWithDuration:animationDuration animations:^{
                //移动textfield到键盘上面20个像素
                self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y + scrollY);
            }];
        }
    }
    self.scrollEnabled = NO;
}

// roll back content offset
-(void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.contentOffset = self.previousOffset;
    }];
    self.scrollEnabled = YES;
}

- (UIView*)findFirstResponderBeneathView:(UIView*)view {
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result ) return result;
    }
    return nil;
}
@end
