//
//  RequestValue.h
//  AFNetworkingTest
//
//  Created by My Book on 17/6/26.
//  Copyright © 2017年 pshao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestValue : NSObject

/**
 地址

 - RequestloginType: 登陆接口
 */
typedef NS_ENUM(NSUInteger, RequestUrlType) {
    
    RequestloginType = 0,//登陆
    RequestUpdateCheck,//更新
    RequestDownRource,//下载资源包
    RequestMeasureListType,//计量列表
    RequestFeedbackidea,//意见反馈
};

typedef NS_ENUM(NSUInteger, RequestWayType) {
    
    RequestGet = 0,
    RequestPost,
};




@end
