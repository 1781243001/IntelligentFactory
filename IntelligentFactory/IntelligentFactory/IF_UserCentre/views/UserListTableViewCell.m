//
//  UserListTableViewCell.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/19.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "UserListTableViewCell.h"

@interface UserListTableViewCell()

@property (nonatomic,strong) UILabel *userTitleLabel;

@property (nonatomic,strong) UILabel *usernameLabel;

@property (nonatomic,strong) UILabel *outloginLabel;

@property (nonatomic,strong) UIImageView *iconImageV;

@end

@implementation UserListTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.iconImageV];
        [self addSubview:self.userTitleLabel];
        [self addSubview:self.usernameLabel];
//        [self addSubview:self.outloginLabel];
    }
    return self;
}

-(UIImageView *)iconImageV{
    if (!_iconImageV) {
        _iconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    }
    return _iconImageV;
}

-(UILabel *)userTitleLabel{
    if (!_userTitleLabel) {
        _userTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageV.frame)+10, 0, 50, CGRectGetHeight(self.frame))];
        _userTitleLabel.textColor = [UIColor hexString:@"333333"];
        _userTitleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _userTitleLabel;
}

-(UILabel *)usernameLabel{
    if (!_usernameLabel) {
        _usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_userTitleLabel.frame) + CGRectGetWidth(_userTitleLabel.frame), 0, kScreen_Width - CGRectGetMaxX(_userTitleLabel.frame) - CGRectGetWidth(_userTitleLabel.frame) - CGRectGetMinX(_iconImageV.frame), CGRectGetHeight(_userTitleLabel.frame))];
        _usernameLabel.textAlignment = NSTextAlignmentRight;
        _usernameLabel.textColor = [UIColor hexString:@"969696"];
        _usernameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _usernameLabel;
}

-(UILabel *)outloginLabel{
    if (!_outloginLabel) {
        _outloginLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,  kScreen_Width, CGRectGetHeight(self.frame))];
        _outloginLabel.textAlignment = NSTextAlignmentCenter;
        _outloginLabel.textColor = [UIColor blackColor];
        _outloginLabel.font = [UIFont systemFontOfSize:18];
    }
    return _outloginLabel;
}


-(void)setUserMessageDataDic:(NSDictionary *)dict
                       title:(NSString *)passName{

    _usernameLabel.text = passName;
    _userTitleLabel.text= [dict objectForKey:@"title"];
    _iconImageV.image = [UIImage imageNamed:[dict objectForKey:@"image"]];

}

-(void)outlogin{
    _outloginLabel.text = @"退出登录";
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
