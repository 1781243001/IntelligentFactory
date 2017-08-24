//
//  FunctionButton.h
//  ISTProject
//
//  Created by My Book on 17/6/13.
//  Copyright © 2017年 steven_l. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^functionBlock)(UIButton *sender);

@interface FunctionButton : UIButton
@property (nonatomic,copy)    functionBlock block;

/**
 初始化

 @param frame 坐标
 @param buttonType 类型
 @param imageString 图片
 @param block 点击回调
 @return 自己儿个
 */
-(instancetype)initWithFrame:(CGRect)frame
                    withType:(UIButtonType)buttonType
                       image:(NSString *)imageString
                       block:(functionBlock)block;

/**
 设置代办数

 @param sting 代办数
 */
-(void)setFigureLabelText:(NSString *)sting;

@end
