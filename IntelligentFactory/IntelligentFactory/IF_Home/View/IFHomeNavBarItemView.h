//
//  IFHomeNavBarItemView.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/12.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^userDetailsBlock)();

@interface IFHomeNavBarItemView : UIView


/**
 创建视图

 @param userMessageImage 用户头像
 @param title 用户名字
 @param block 触发事件
 @return 自己个
 */
-(instancetype)initWithFrame:(CGRect)frame
                 userMessage:(NSString *)userMessageImage
                    andTitle:(NSString *)title
                       block:(userDetailsBlock)block;
//用户名字
@property (nonatomic,strong) NSString *titleString;
//用户头像
@property (nonatomic,strong) NSString *imgString;

@end
