//
//  SelectCustomItemView.h
//  IntelligentFactory
//
//  Created by My Book on 2017/8/1.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedInformationModel.h"

typedef void(^itemClickBlock)(DetailedInformationModel *model,NSInteger ranks,CGRect rect);

@interface SelectCustomItemView : UIView

-(instancetype)initWithFrame:(CGRect)frame
                  dataSource:(NSArray *)array
                       block:(itemClickBlock)block;
@end
