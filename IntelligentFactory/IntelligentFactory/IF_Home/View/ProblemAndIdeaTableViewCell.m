//
//  ProblemAndIdeaTableViewCell.m
//  IntelligentFactory
//
//  Created by My Book on 2017/8/9.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "ProblemAndIdeaTableViewCell.h"
@implementation ProblemAndIdeaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.textView];
    }
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    if ([self.delegate respondsToSelector:@selector(whetherScrollView:)]) {
        [_delegate whetherScrollView:textView.tag];
    }
    return YES;
}
-(PlaceholderTextView *)textView{
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc]init];
        _textView.placeholderLabel.font = [UIFont systemFontOfSize:12];
        _textView.delegate =self;
        _textView.font = [UIFont systemFontOfSize:15];
    }
    return _textView;
}

-(void)textViewConfigurationPlaceholder:(NSString *)placeholderString
                                  frame:(CGRect)rect
                              maxlength:(CGFloat)length{
    _textView.placeholder = placeholderString;
    _textView.frame = rect;
    if (length > 0) {
        _textView.maxLength = length;
        _textView.wordNumLabel.hidden = NO;
    }else{
        _textView.wordNumLabel.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
