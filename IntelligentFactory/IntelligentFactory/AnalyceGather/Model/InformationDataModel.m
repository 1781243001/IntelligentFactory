//
//  InformationDataModel.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/28.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "InformationDataModel.h"
#import "DetailedInformationModel.h"
@implementation InformationDataModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"areaList":@"DetailedInformationModel",
             @"mediumList":@"DetailedInformationModel",
             @"treeList":@"DetailedInformationModel"};
}


@end
