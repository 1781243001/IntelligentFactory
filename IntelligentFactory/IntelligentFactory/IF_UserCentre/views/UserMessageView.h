//
//  UserMessageView.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/19.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickHeaderBlock)();
@interface UserMessageView : UIImageView

@property (nonatomic,strong) UIImageView *headerImage;

@property (nonatomic,strong) UILabel *usenameLabel;

-(instancetype)initWithFrame:(CGRect)frame block:(clickHeaderBlock)block;

@end
