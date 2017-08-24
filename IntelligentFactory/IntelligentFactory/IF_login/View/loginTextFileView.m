//
//  loginTextFileView.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/17.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "loginTextFileView.h"

@implementation loginTextFileView


-(instancetype)initWithFrame:(CGRect)frame type:(loginTextFileType)type{

    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = [UIColor hexString:@"#D7D7D8"].CGColor;
        self.layer.borderWidth = 0.5f;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.height/2;
        self.userInteractionEnabled = YES;
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, frame.size.height-20, frame.size.height-20)];
        [self addSubview:imageV];
        UITextField *textFile = [[UITextField alloc]init];
        textFile.font = [UIFont systemFontOfSize:14.f];

        [self addSubview:textFile];
        switch (type) {
            case accountNumberFormat:{
                imageV.image = [UIImage imageNamed:@"icon_accout.png"];
                textFile.placeholder = @"请在此输入账号";
                textFile.clearButtonMode = UITextFieldViewModeWhileEditing;
                textFile.frame = CGRectMake(CGRectGetMaxX(imageV.frame)+5, 5, frame.size.width - CGRectGetMaxX(imageV.frame)-25, CGRectGetHeight(frame)-10);
                textFile.tag = accountNumberFormat;
            }
                break;
            case passwordFormat:{
                imageV.image = [UIImage imageNamed:@"icon_password.png"];
                textFile.placeholder = @"请在此输入密码";
                textFile.secureTextEntry = YES;
                textFile.tag = passwordFormat;
                textFile.frame = CGRectMake(CGRectGetMaxX(imageV.frame)+5, 5, frame.size.width - CGRectGetMaxX(imageV.frame)-50, CGRectGetHeight(frame)-10);
                UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                btn.frame = CGRectMake(CGRectGetMaxX(textFile.frame), (CGRectGetHeight(frame) - 14)/2, 24, 14);
                [btn setBackgroundImage:[UIImage imageNamed:@"hidePwd"] forState:(UIControlStateNormal)];
                [btn setBackgroundImage:[UIImage imageNamed:@"showPwd"] forState:(UIControlStateSelected)];
                [btn addTarget:self action:@selector(showOrHidePwd:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
            }
                break;
            default:
                break;
        }
        textFile.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textFile.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textFile.returnKeyType = UIReturnKeyDone;
        textFile.delegate = self;
        [textFile setAutocorrectionType:UITextAutocorrectionTypeNo];
        textFile.backgroundColor = [UIColor clearColor];
        [textFile setValue:[UIColor hexString:@"969696"] forKeyPath:@"_placeholderLabel.textColor"];
        [textFile setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    }
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)showOrHidePwd:(UIButton *)sender{
    UITextField *password = [self viewWithTag:120];
    if (sender.selected) {
        [sender setBackgroundImage:[UIImage imageNamed:@"hidePwd"] forState:(UIControlStateNormal)];
        password.secureTextEntry = YES;
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"showPwd"] forState:(UIControlStateNormal)];
        password.secureTextEntry = NO;
    }
    sender.selected = !sender.selected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
