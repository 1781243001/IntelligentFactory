//
//  VersionModel.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/21.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionModel : NSObject

@property (nonatomic,strong) NSString *IsHaveNewVersion;
@property (nonatomic,strong) NSString *NewResourceversion;
@property (nonatomic,assign) NSInteger IsHaveNewResourceVersion;
@property (nonatomic,strong) NSString *NewAppversion;
@end
