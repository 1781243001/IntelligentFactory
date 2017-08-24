//
//  UserListTableViewCell.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/19.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListTableViewCell : UITableViewCell

-(void)setUserMessageDataDic:(NSDictionary *)dict title:(NSString *)passName;
-(void)outlogin;

@end
