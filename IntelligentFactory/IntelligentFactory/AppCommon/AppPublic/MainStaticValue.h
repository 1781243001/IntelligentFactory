//
//  MainStaticValue.h
//  IntelligentFactory
//
//  Created by My Book on 17/6/27.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kScreen_Height  MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)
#define kScreen_Width   MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define WEAKSELF typeof(self) __weak weakSelf = self;

#define NotificationNoNetwork  @"NotificationNoNetwork"

#define iphone5 ((kScreen_Width==320)?1:0)
#define iphone6 ((kScreen_Width==375)?1:0)
#define iphone6plus ((kScreen_Width==414)?1:0)
#define iphone5W 320.0
#define iphone6W 375.0
#define iphone6plusW 414.0

#define SelectDeploy @"SELECTADDDATA"



#ifdef DEBUG
#define DHLog(id,...) NSLog((@"%s [Line %d] " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DHLog(...)
#endif


