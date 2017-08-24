//
//  RequestService.h
//  AFNetworkingTest
//
//  Created by Nile on 2017/5/18.
//  Copyright © 2017年 pshao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestValue.h"
typedef void (^responseResultBlock)(id dataObj, NSError *error);
@interface RequestService : NSObject

/**
 重新载入请求头
 */
+ (void)reloadAFNHeaderAuth;



/**
 利用AFN请求获取JSON返回

 @param urlType       传入请求类型
 @param wayType       请求方式
 @param param         请求参数
 @param modelClass    请求返回所需要转换的模型类
 @param responseBlock 请求成功|失败回调
 */

+ (void)AFN_JSONResponseUrlType:(RequestUrlType)urlType requestWay:(RequestWayType)wayType  param:(id)param modelClass:(Class)modelClass responseBlock:(responseResultBlock) responseBlock;

+ (void)AFN_UploadJSONResponseUrlType:(RequestUrlType)urlType
                                param:(id)param
                            dataArray:(NSArray *)dataArray
                           modelClass:(Class)modelClass
                        responseBlock:(responseResultBlock) responseBlock;

/**
 请求返回结果转换为模型方法  -- 此方法不需要关注,如果有Service继承此类,可以重写该方法进行数据处理

 @param responseObj 返回结果
 @param modelClass 模型类
 @return 转换成功的模型
 */
+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass;

+(NSString *)getUrlType:(RequestUrlType)urlType;

@end
