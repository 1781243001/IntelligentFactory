//
//  DetailedInformationModel.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/28.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailedInformationModel : NSObject<NSCoding>
@property (nonatomic,assign) NSInteger ID;

@property (nonatomic,strong) NSString *text;

@property (nonatomic,strong) NSString *iconCls;

@property (nonatomic,strong) NSString *state;

@property (nonatomic,strong) NSString *parentId;

@property (nonatomic,strong) NSMutableArray *children;

@property (nonatomic,assign) NSInteger remark;

@end
