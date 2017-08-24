//
//  NetworkDownloader.h
//  MobileCooperativeOffice
//
//  Created by Nile on 2016/11/14.
//  Copyright © 2016年 pcitc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^downloadProgressBlock) (NSProgress *downloadProgress);
typedef void (^downloadCompleteBlock) (NSString *filePath,NSError * error);
@interface NetworkDownloader : NSObject

#pragma mark - 
#pragma mark - 类方法

+ (instancetype)sharedNetworkDownloader;

+ (void)downloadFileWithUrl:(NSString *)url andDestUrl:(NSString *)destUrl andProgressBlock:(downloadProgressBlock)progressBlock  andCompleteBlock:(downloadCompleteBlock)downloadCompleteBlock;
+ (void)cancelDownloadTasksWithUrl:(NSString *)url;
+ (void)cancelAllDownloadTask;
+ (NSURLSessionDownloadTask *)downloadTaskForUrl:(NSString *)url;
+ (NSArray<NSURLSessionDownloadTask *> *)allDownloadTask;



#pragma mark -
#pragma mark - 对象方法
- (void)downloadFileWithUrl:(NSString *)url andDestUrl:(NSString *)destUrl andProgressBlock:(downloadProgressBlock)progressBlock  andCompleteBlock:(downloadCompleteBlock)downloadCompleteBlock;

- (void)cancelDownloadTasksWithUrl:(NSString *)url;
- (void)cancelAllDownloadTask;

- (NSURLSessionDownloadTask *)downloadTaskForUrl:(NSString *)url;
- (NSArray<NSURLSessionDownloadTask *> *)allDownloadTask;

@end
