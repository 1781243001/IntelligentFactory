//
//  RequsetManager.h
//  AFNetworkingTest
//
//  Created by Nile on 2017/5/18.
//  Copyright © 2017年 pshao. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^requestSuccessBlock)(id responseObj);
typedef void (^requestFailureBlock) (NSError *error);

@interface RequsetManager : AFHTTPSessionManager
+ (instancetype)sharedRequestManager;

+ (void)AFN_ReloadHeaderAuth;

+ (void)AFN_GetRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;
+ (void)AFN_PostRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;

+ (void)AFN_UpLoadRequest:(NSString *)url params:(NSDictionary *)params imageData:(NSMutableArray *)imageArray success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;



@end
