//
//  ProblemAndIdeaTableViewCell.h
//  IntelligentFactory
//
//  Created by My Book on 2017/8/9.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"

@protocol ProblemAndIdeaTableViewCellDelegate <NSObject>

-(void)whetherScrollView:(NSInteger)section;

@end

@interface ProblemAndIdeaTableViewCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic,strong) PlaceholderTextView *textView;

@property (nonatomic,weak) id<ProblemAndIdeaTableViewCellDelegate>delegate;

-(void)textViewConfigurationPlaceholder:(NSString *)placeholderString
                                  frame:(CGRect) rect
                              maxlength:(CGFloat)length;

@end
