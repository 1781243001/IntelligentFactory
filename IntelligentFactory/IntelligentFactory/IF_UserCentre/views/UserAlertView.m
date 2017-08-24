//
//  UserAlertView.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/19.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "UserAlertView.h"

@implementation UserAlertView{

    CGFloat _width;
    dispatch_source_t _timer;
    BOOL _isStop;
    AlertType _type;
}
-(instancetype)initAlertype:(AlertType)type width:(CGFloat)width block:(ChangHeaderImageBlock)block{
    if (self = [super init]) {
        _width = width;
        _block = block;
        _type = type;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self createAlertViewType:type];
    }
    return self;
}


-(void)createAlertViewType:(AlertType)type{
    NSArray *dataArr = nil;
    CGFloat height = 0;
    switch (type) {
        case UserChangePhone:
            height = 208;
            dataArr = @[
                             @{@"type":@(ClickIncidentDetele),@"title":@"更换手机号码"},
                             @{@"type":@(ClickIncidentPhoneTextFiled),@"title":@"新号码:"},
                             @{@"type":@(ClickIncidentVerifyTextFiled),@"title":@"验证码"},
                             @{@"type":@(ClickIncidentTelephoneButton),@"title":@"确定"}
                             ];
            break;
        case UserChangeTelephone:
            height = 156;
            dataArr = @[
                        @{@"type":@(ClickIncidentDetele),@"title":@"更换座机号码"},
                        @{@"type":@(ClickIncidentTelephoneTextFiled),@"title":@"新号码:"},
                        @{@"type":@(ClickIncidentTelephoneButton),@"title":@"确定"}
                        ];
            break;
        case UserChangeMail:{
        
            height = 156;
            dataArr = @[
                        @{@"type":@(ClickIncidentDetele),@"title":@"更换座邮箱"},
                        @{@"type":@(ClickIncidentTelephoneTextFiled),@"title":@"新邮箱:"},
                        @{@"type":@(ClickIncidentTelephoneButton),@"title":@"确定"}
                        ];

        
        }
            break;
    }
    
    [self createView:dataArr height:height];
}

-(void)createView:(NSArray *)aee height:(CGFloat)high{

    CGFloat height = 0;
    for (NSInteger i = 0; i < aee.count; i++) {
        NSDictionary *dict = [aee objectAtIndex:i];
        ClickIncidentType type = [[dict objectForKey:@"type"] integerValue];;
        if (type == ClickIncidentDetele) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, 40)];
            imageV.backgroundColor = [UIColor whiteColor];
            imageV.userInteractionEnabled = YES;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, _width - 80, 13)];
            label.text = [dict objectForKey:@"title"];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor hexString:@"333333"];
            [self addSubview:imageV];
            [imageV addSubview:label];
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.frame = CGRectMake(_width - 50, 0, 40, 40);
            btn.tag = ClickIncidentDetele;
            [btn setImage:[UIImage imageNamed:@"sequence_delete"] forState:(UIControlStateNormal)];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(20, 15, 10, 15)];
            [btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:btn];
            height = CGRectGetHeight(imageV.frame);
        }else if (type == ClickIncidentPhoneTextFiled)
        {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, height, _width, 50)];
            imageV.backgroundColor = [UIColor whiteColor];
            imageV.userInteractionEnabled = YES;
            [self addSubview:imageV];
            UILabel *label = [[UILabel alloc]init];
            label.text = [dict objectForKey:@"title"];
            [imageV addSubview:label];
            CGSize sizeToFit = [label sizeThatFits:CGSizeMake(65, MAXFLOAT)];
            label.frame =CGRectMake(20, (50-sizeToFit.height)/2, 65, sizeToFit.height);
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), sizeToFit.height+CGRectGetMinY(label.frame), _width -CGRectGetMaxX(label.frame)-40 , 0.5)];
            line.backgroundColor = [UIColor lightGrayColor];
            [imageV addSubview:line];
            
            UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(line.frame), CGRectGetMinY(label.frame), CGRectGetWidth(line.frame), sizeToFit.height)];
            textField.textAlignment = NSTextAlignmentCenter;
            [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            textField.tag = ClickIncidentPhoneTextFiled;
            textField.keyboardType = UIKeyboardTypePhonePad;
            [imageV addSubview:textField];
            height += CGRectGetHeight(imageV.frame);
        }else if (type == ClickIncidentVerifyTextFiled){
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, height, _width, 50)];
            imageV.backgroundColor = [UIColor whiteColor];
            imageV.userInteractionEnabled = YES;
            [self addSubview:imageV];
            UILabel *label = [[UILabel alloc]init];
            label.text =[dict objectForKey:@"title"];
            [imageV addSubview:label];
            CGSize sizeToFit = [label sizeThatFits:CGSizeMake(65, MAXFLOAT)];
            label.frame =CGRectMake(20, (50-sizeToFit.height)/2, 65, sizeToFit.height);
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), sizeToFit.height+CGRectGetMinY(label.frame), _width -CGRectGetMaxX(label.frame)-40 - 88 , 0.5)];
            line.backgroundColor = [UIColor lightGrayColor];
            [imageV addSubview:line];
            
            UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(line.frame), CGRectGetMinY(label.frame), CGRectGetWidth(line.frame), sizeToFit.height)];
            [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            textField.tag = ClickIncidentVerifyTextFiled;
            textField.keyboardType = UIKeyboardTypePhonePad;
            textField.textAlignment = NSTextAlignmentCenter;
            [imageV addSubview:textField];
            
            UIButton *SecurityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [SecurityBtn setFrame:CGRectMake(CGRectGetMaxX(textField.frame)+2, (50-sizeToFit.height)/2 + sizeToFit.height- 30, 88, 30)];
            [SecurityBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
            SecurityBtn.backgroundColor = [UIColor hexString:@"005bac"];
            SecurityBtn.layer.cornerRadius =3;
            SecurityBtn.clipsToBounds = YES;
            SecurityBtn.layer.borderWidth = 0.5;
            SecurityBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [SecurityBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            [SecurityBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [SecurityBtn addTarget:self action:@selector(getSecurity:) forControlEvents:UIControlEventTouchUpInside];
            [imageV addSubview:SecurityBtn];
            
            UILabel *redLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(label.frame)+3, CGRectGetMaxY(label.frame)  , 80, 20)];
            redLabel.hidden = YES;
            redLabel.tag = ClickIncidentVerifyWrongLabel;
            redLabel.text = @"验证码输入错误";
            redLabel.font = [UIFont systemFontOfSize:10];
            redLabel.textColor = [UIColor redColor];
            [imageV addSubview:redLabel];
            height += CGRectGetHeight(imageV.frame);
        }else if (type == ClickIncidentTelephoneButton){
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.titleLabel.textAlignment = NSTextAlignmentLeft;
            btn.frame = CGRectMake(20, height+10, _width-40, 40);
            [btn setTitle:dict[@"title"] forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            btn.tag = ClickIncidentTelephoneButton;
            [btn setBackgroundColor:[UIColor hexString:@"d7d7d8"]];
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            btn.layer.cornerRadius = 5;
            btn.clipsToBounds = YES;
            btn.enabled = NO;
            [self addSubview:btn];
            height += CGRectGetHeight(btn.frame);
        }else if ( type == ClickIncidentTelephoneTextFiled){
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, height, _width, 50)];
            imageV.backgroundColor = [UIColor whiteColor];
            imageV.userInteractionEnabled = YES;
            [self addSubview:imageV];
            UILabel *label = [[UILabel alloc]init];
            label.text =[dict objectForKey:@"title"];
            [imageV addSubview:label];
            CGSize sizeToFit = [label sizeThatFits:CGSizeMake(65, MAXFLOAT)];
            label.frame =CGRectMake(20, (50-sizeToFit.height)/2, 65, sizeToFit.height);
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), sizeToFit.height+CGRectGetMinY(label.frame), _width -CGRectGetMaxX(label.frame)-40 , 0.5)];
            line.backgroundColor = [UIColor lightGrayColor];
            [imageV addSubview:line];
            UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(line.frame), CGRectGetMinY(label.frame), CGRectGetWidth(line.frame), sizeToFit.height)];
            textField.textAlignment = NSTextAlignmentCenter;
            [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            textField.tag = ClickIncidentTelephoneTextFiled;
            if (_type != UserChangeMail) {
                textField.keyboardType = UIKeyboardTypePhonePad;
            }
            [imageV addSubview:textField];
            height += CGRectGetHeight(imageV.frame);
        }
    }
    self.frame = CGRectMake(0, 0, _width, high);

}
#pragma mark 手机号码格式
-(BOOL)IsValidatePhone:(NSString *)phone{
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

-(BOOL)IsValidateNumber:(NSString *)number{
    NSString * strNum = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    return [phoneTest evaluateWithObject:number];
}

-(void)click:(UIButton *)sender{
    UITextField *tele = [self viewWithTag:ClickIncidentTelephoneTextFiled];
    UITextField *phone = [self viewWithTag:ClickIncidentPhoneTextFiled];
    UITextField *verify = [self viewWithTag:ClickIncidentVerifyTextFiled];
    [tele resignFirstResponder];
    [phone resignFirstResponder];
    [verify resignFirstResponder];
    _block(sender.tag);
}
#pragma  mark 获取验证码
-(void)getSecurity:(UIButton *)getverificationBtn{
    
    UITextField *textfield = [self viewWithTag:ClickIncidentPhoneTextFiled];
    if (textfield.text.length==11 && [self IsValidatePhone:textfield.text]) {
        __block int time = 10;
        __block UIButton *verifybutton = getverificationBtn;
        verifybutton.enabled = NO;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(time<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [verifybutton setTitle:@"发送验证码" forState:UIControlStateNormal];
                    verifybutton.backgroundColor = [UIColor hexString:@"005bac"];
                    [verifybutton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                    verifybutton.enabled = YES;
                    
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    if (!_isStop) {
                        verifybutton.backgroundColor = [UIColor grayColor];
                        NSString *strTime = [NSString stringWithFormat:@"获取验证码(%d)",time];
                        [verifybutton setTitle:strTime forState:UIControlStateNormal];
                        verifybutton.backgroundColor = [UIColor whiteColor];
                        [verifybutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];

                    }else {
                        verifybutton.enabled = YES;
                        [verifybutton setTitle:@"获取验证码" forState:UIControlStateNormal];
                        verifybutton.backgroundColor = [UIColor hexString:@"005bac"];
                        [verifybutton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                        dispatch_source_cancel(_timer);
                        time = 0;
                        _isStop = NO;
                    }
                });
                time--;
            }
        });
        dispatch_resume(_timer);
    }
    else{
        [PromptMessage showCentre:@"手机号不正确"];
    }
    
}

#pragma mark  监听textField 改变
-(void)textFieldDidChange:(UITextField *)textField
{
    UIButton *btn = [self viewWithTag:ClickIncidentTelephoneButton];
    if (textField.tag == ClickIncidentTelephoneTextFiled) {
        if (textField.text.length > 0 && [self IsValidateNumber:textField.text]) {
            btn.enabled = YES;
            [btn setBackgroundColor:[UIColor hexString:@"005bac"]];
        }else{
            [btn setBackgroundColor:[UIColor hexString:@"d7d7d8"]];
            btn.enabled = NO;
        }
    }else{
        UITextField *textfiled = [self viewWithTag:ClickIncidentPhoneTextFiled];
        UITextField *textfiled1 = [self viewWithTag:ClickIncidentVerifyTextFiled];
        if (textField.tag == ClickIncidentPhoneTextFiled) {
            if (textField.text.length > 11) {
                textField.text = [textField.text substringToIndex:11];
            }
        }else if(textField.tag == ClickIncidentVerifyTextFiled){
            if (textField.text.length > 4) {
                textField.text = [textField.text substringToIndex:4];
            }
        }
        if (textfiled.text.length == 11 && [self IsValidatePhone:textfiled.text] && textfiled1.text.length ==4) {
            btn.enabled = YES;
            [btn setBackgroundColor:[UIColor hexString:@"005bac"]];
        }else{
            [btn setBackgroundColor:[UIColor hexString:@"d7d7d8"]];
            btn.enabled = NO;
        }
        
    }
}

@end
