//
//  loginTextFileView.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/17.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    accountNumberFormat = 119,
    passwordFormat,
} loginTextFileType;

@interface loginTextFileView : UIImageView<UITextFieldDelegate>
-(instancetype)initWithFrame:(CGRect)frame type:(loginTextFileType)type;
@end
