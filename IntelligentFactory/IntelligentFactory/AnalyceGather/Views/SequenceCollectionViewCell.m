//
//  SequenceCollectionViewCell.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/7.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "SequenceCollectionViewCell.h"
@interface SequenceCollectionViewCell (){
    
    DeleteBlock _block;
    
}

@property (nonatomic,strong)UILabel *textLabel;

@end

@implementation SequenceCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor hexString:@"#F5F5F5"];
        [self addSubview:self.textLabel];
        [self addSubview:self.cancelView];
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(self.frame.size.width, self.frame.size.height));
        }];
        [_cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_textLabel.mas_left).offset(-5);
            make.top.equalTo(_textLabel.mas_top).offset(-5);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
    }
    return self;
}


-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _textLabel.font = [UIFont systemFontOfSize:12.0f];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.backgroundColor = [UIColor whiteColor];
        _textLabel.textColor = [UIColor hexString:@"#333333"];
        _textLabel.layer.borderColor = [UIColor hexString:@"#D7D7D8"].CGColor;
        _textLabel.layer.borderWidth = 0.5f;
        _textLabel.layer.masksToBounds = YES;
        _textLabel.layer.cornerRadius = 4;
//        UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
//        _textLabel.backgroundColor = color;
    }
    return _textLabel;
}

-(UIImageView *)cancelView{
    
    if (!_cancelView) {
        _cancelView = [[UIImageView alloc]init];
        _cancelView.image = [UIImage imageNamed:@"sequence_close.png"];
    }
    return _cancelView;
}

-(void)setData:(NSString *)title
      isCancel:(BOOL)isCancel{
    _textLabel.text = title;
    [_cancelView setHidden:isCancel];
}

-(void)setModelArr:(DetailedInformationModel *)model
          isCancel:(BOOL)isCancel{
    _textLabel.text = model.text;
//    [_cancelView setHidden:YES];
}

@end
