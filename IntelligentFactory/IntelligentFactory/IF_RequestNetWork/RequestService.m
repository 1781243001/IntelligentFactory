//
//  RequestService.m
//  AFNetworkingTest
//
//  Created by Nile on 2017/5/18.
//  Copyright © 2017年 pshao. All rights reserved.
//

#import "RequestService.h"
#import "RequsetManager.h"
#import "MJExtension.h"
#import <AdSupport/AdSupport.h>
static id dataObj;
static const NSString *kRequestBaseUrl = @"http://10.246.109.109/app/api/";

@implementation RequestService

+ (void)reloadAFNHeaderAuth{
    [RequsetManager AFN_ReloadHeaderAuth];
}
#pragma mark 添加参数
+(NSMutableDictionary *)adjustDataDic:(NSDictionary *)dataDic{
    NSString *uniqueIdentifier = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    NSMutableDictionary *requestDic = [(NSMutableDictionary *)dataDic mutableCopy];
    [requestDic setValue:uniqueIdentifier forKey:@"DeviceID"];
    [requestDic setValue:bundleId forKey:@"AppID"];
    [requestDic setValue:@"iPhone" forKey:@"EquipType"];
    [requestDic setValue:@"false" forKey:@"IsEncrypted"];
    [requestDic setValue:@"1" forKey:@"IsApp"];
    [requestDic setValue:@"0" forKey:@"IsDev"];
    [requestDic setValue:@"00000000" forKey:@"Tel"];
    return requestDic;
}

+(NSString *)getUrlType:(RequestUrlType)urlType{
    NSString *requestUrl = @"http://10.246.109.109/app/api/MobileBusiness/GetPageViewData";
    switch (urlType) {
        case RequestloginType:
            requestUrl = [NSString stringWithFormat:@"%@%@",kRequestBaseUrl,@"MobileBusiness/Login"];
            break;
        case RequestUpdateCheck:
            requestUrl = [NSString stringWithFormat:@"%@%@",kRequestBaseUrl,@"File/UpdateCheck"];
            break;
        case RequestDownRource:
            requestUrl = [NSString stringWithFormat:@"%@%@",kRequestBaseUrl,@"File/GetRourceFile"];
            break;
        case RequestMeasureListType:
            break;
        case RequestFeedbackidea:
            requestUrl = [NSString stringWithFormat:@"%@%@",kRequestBaseUrl,@"Requirement/UpdateRequirement"];

            break;
        default:
            break;
    }
    return requestUrl;
}

+ (void)AFN_JSONResponseUrlType:(RequestUrlType)urlType requestWay:(RequestWayType)wayType  param:(id)param modelClass:(Class)modelClass responseBlock:(responseResultBlock) responseBlock{
    NSString *requestUrl = [RequestService getUrlType:urlType];
//    NSMutableDictionary *requestDic = [RequestService adjustDataDic:param];
//    requestUrl = @"http://app.promace-dev.sinopec.com:8000/0001/CDS.svc/ListConsumeKpi?PageId=1&PartId=6";
    switch (wayType) {
        case RequestGet:{
            [RequsetManager AFN_GetRequest:requestUrl params:param success:^(id responseObj) {
                dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
                responseBlock(dataObj,nil);
            } failure:^(NSError *error) {
                responseBlock(nil,error);
            }];
        }
            break;
        case RequestPost:{
            [RequsetManager AFN_PostRequest:requestUrl params:param success:^(id responseObj) {
                dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
                responseBlock(dataObj,nil);
            } failure:^(NSError *error) {
                responseBlock(nil,error);
            }];
        }
            break;
    }
}
+ (void)AFN_UploadJSONResponseUrlType:(RequestUrlType)urlType
                                param:(id)param
                           dataArray:(NSMutableArray *)dataArray
                           modelClass:(Class)modelClass
                        responseBlock:(responseResultBlock) responseBlock{
    NSString *requestUrl = [RequestService getUrlType:urlType];
    [RequsetManager AFN_UpLoadRequest:requestUrl params:param imageData:dataArray success:^(id responseObj) {
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseBlock(dataObj,nil);
    } failure:^(NSError *error) {
        responseBlock(nil,error);
    }];
    
}
+ (id)convertJson:(NSString *)jsonStr
{
    if (!jsonStr) {
        return nil;
    }
    NSError * error;
    return [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
}


/**
 解密

 @param response 网络数据
 @return 解密结果
 */
+ (NSString *)decreptResponse:(NSString *)response{
    return response;
}

+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass{
    NSString *response = [[NSString alloc] initWithData:(NSData *)responseObj encoding:NSUTF8StringEncoding];
    response = [self decreptResponse:response];
    
    id tmp = [self convertJson:response];
    if ([tmp isKindOfClass:[NSString class]]) {
        tmp = [self convertJson:tmp];
    }
    if ([tmp isKindOfClass:[NSArray class]]) {
        return [modelClass mj_objectArrayWithKeyValuesArray:tmp];
    }else if([tmp isKindOfClass:[NSDictionary class]]){
        return [modelClass mj_objectWithKeyValues:tmp];
    }else{
        return response;
    }
}

@end
