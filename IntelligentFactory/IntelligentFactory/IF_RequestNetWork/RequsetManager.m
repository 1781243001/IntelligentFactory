//
//  RequsetManager.m
//  AFNetworkingTest
//
//  Created by Nile on 2017/5/18.
//  Copyright © 2017年 pshao. All rights reserved.
//

#import "RequsetManager.h"


@interface RequsetManager()
@end

@implementation RequsetManager
+ (instancetype)sharedRequestManager{
    
    static dispatch_once_t onceToken;
    static RequsetManager * manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
        manager.requestSerializer.timeoutInterval = 60.0f;
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"jwttoken"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return manager;
}

+ (void)AFN_ReloadHeaderAuth{
    [[[self sharedRequestManager] requestSerializer] setValue:@"" forHTTPHeaderField:@"jwttoken"];
}

+ (void)AFN_GetRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    RequsetManager *manager = [self sharedRequestManager];
    AFHTTPRequestSerializer *requestSerializer=[AFHTTPRequestSerializer serializer];
//    NSDictionary *params = @{@"Content-Type":@"application/x-www-form-urlencoded; charset=UTF-8",
//                                                 @"Authorization":@"hmac accesskey=\"c4313306df4042d2\", algorithm=\"hmac-sha1\", headers=\"date content-md5\", signature=\"TL4BgakG1YeocGbZT96Gdk94ngI=\"",
//                                                 @"Date":@"Mon, 14 Aug 2017 07:22:59 GMT",
//                                                 @"Content-md5":@"RDQxRDhDRDk4RjAwQjIwNEU5ODAwOTk4RUNGODQyN0U=",
//                                                };
    if (params != nil) {
        for (NSString *httpHeaderField in params.allKeys) {
            NSString *value = params[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    manager.requestSerializer = requestSerializer;
    [[self sharedRequestManager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
}

+ (void)AFN_PostRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    RequsetManager *manager = [self sharedRequestManager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [[self sharedRequestManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];

}
+ (void)AFN_UpLoadRequest:(NSString *)url
                   params:(NSDictionary *)params
                imageData:(NSMutableArray *)imageArray
                  success:(requestSuccessBlock)successHandler
                  failure:(requestFailureBlock)failureHandler{
    RequsetManager *manager = [self sharedRequestManager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:imageArray];
        [array removeLastObject];
        for (UIImage *image in array) {
            NSDate *date = [NSDate date];
            NSDateFormatter *formormat = [[NSDateFormatter alloc]init]; [formormat setDateFormat:@"HHmmss"];
            NSString *dateString = [formormat stringFromDate:date];
            NSString *fileName = [NSString stringWithFormat:@"%@.png",dateString];
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            double scaleNum = (double)300*1024/imageData.length;
            NSLog(@"图片压缩率：%f",scaleNum);
            if(scaleNum <1){
                imageData = UIImageJPEGRepresentation(image, scaleNum);
            }else{
                imageData = UIImageJPEGRepresentation(image, 0.1);
            }
            [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
}


@end
