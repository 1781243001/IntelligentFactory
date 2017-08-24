//
//  IFSelectOrganizeController.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/26.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFBaseViewController.h"
#import "InformationDataModel.h"
#import "DetailedInformationModel.h"

@protocol selectOrganizeDelegate <NSObject>

-(void)selelctOrganize:(NSArray *)array;

@end

@interface IFSelectOrganizeController : IFBaseViewController

@property (nonatomic,strong) NSMutableArray *selelctArr;//选中数组

@property (nonatomic,weak) id<selectOrganizeDelegate>organizeDeleagate;

@property (nonatomic,strong) NSString *navigationTitle;

@end
