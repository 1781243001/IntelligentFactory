//
//  UserAlertView.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/19.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger,AlertType){
  
    UserChangePhone = 0,//手机
    UserChangeTelephone,//固话
    UserChangeMail,//邮箱
};
//控件的type
typedef NS_ENUM(NSUInteger,ClickIncidentType){
    ClickIncidentDetele = 10,//删除Button
    ClickIncidentTakephoto ,//照相Button
    ClickIncidentPhoto,//相册Button
    ClickIncidentTelephoneTextFiled,//固话TextFiled
    ClickIncidentTelephoneButton,//固话Button
    ClickIncidentPhoneTextFiled,//手机TextFiled
    ClickIncidentVerifyTextFiled,//验证码TextFiled
    ClickIncidentVerifyWrongLabel,//验证码错误
};

typedef void (^ChangHeaderImageBlock)(ClickIncidentType tag);


@interface UserAlertView : UIView<UITextFieldDelegate>
-(instancetype)initAlertype:(AlertType)type width:(CGFloat)width block:(ChangHeaderImageBlock)block;
@property (nonatomic,copy)ChangHeaderImageBlock block;

@end
