//
//  NetworkDownloader.m
//  MobileCooperativeOffice
//
//  Created by Nile on 2016/11/14.
//  Copyright © 2016年 pcitc. All rights reserved.
//

#import "NetworkDownloader.h"

static NetworkDownloader *_sharedInst = nil;

@interface NetworkDownloaderModel : NSObject
@property(nonatomic,copy)downloadProgressBlock downloadProgressBlock;
@property(nonatomic,copy)downloadCompleteBlock downloadCompleteBlock;
@property(nonatomic,strong) NSURLSessionDownloadTask * downloadTask;
@property(nonatomic,strong) NSProgress               * progress;

- (instancetype)initWithDownloadProgressBlock:(downloadProgressBlock)downloadProgressBlock andDownloadCompleteBlock:(downloadCompleteBlock)downloadCompleteBlock;
@end



@interface NetworkDownloader ()
@property(nonatomic,strong)NSMutableDictionary<NSString *,NetworkDownloaderModel *> * downloadTasks;
@end

@implementation NetworkDownloader

+ (instancetype)sharedNetworkDownloader{
    @synchronized(self){
        if(_sharedInst == nil){
            _sharedInst = [[self alloc] init];
        }
    }
    return _sharedInst;
}

+ (void)downloadFileWithUrl:(NSString *)url andDestUrl:(NSString *)destUrl andProgressBlock:(downloadProgressBlock)progressBlock  andCompleteBlock:(downloadCompleteBlock)downloadCompleteBlock{
    [[self sharedNetworkDownloader] downloadFileWithUrl:url andDestUrl:destUrl andProgressBlock:progressBlock andCompleteBlock:downloadCompleteBlock];
}


+ (void)cancelDownloadTasksWithUrl:(NSString *)url{
    [[self sharedNetworkDownloader] cancelDownloadTasksWithUrl:url];
}
+ (void)cancelAllDownloadTask{
    [[self sharedNetworkDownloader] cancelAllDownloadTask];
}
+ (NSURLSessionDownloadTask *)downloadTaskForUrl:(NSString *)url{
    return [[self sharedNetworkDownloader] downloadTaskForUrl:url];
}
+ (NSArray<NSURLSessionDownloadTask *> *)allDownloadTask{
    return [[self sharedNetworkDownloader] allDownloadTask];
}





- (NSMutableDictionary<NSString *,NetworkDownloaderModel *> *)downloadTasks{
    if (!_downloadTasks) {
        _downloadTasks = [NSMutableDictionary dictionary];
    }
    return _downloadTasks;
}

- (void)cancelDownloadTasksWithUrl:(NSString *)url{
    NSURLSessionDownloadTask * downloadTask = [self downloadTaskForUrl:url];
    if (downloadTask) {
        [downloadTask cancel];
        [self.downloadTasks removeObjectForKey:url];
    }
}

- (void)cancelAllDownloadTask{
    for (NetworkDownloaderModel * model in self.downloadTasks.allValues) {
        [model.downloadTask cancel];
    }
    [self.downloadTasks removeAllObjects];
}

- (NSURLSessionDownloadTask *)downloadTaskForUrl:(NSString *)url{
    NSURLSessionDownloadTask * downloadTask = nil;
    if ([self.downloadTasks.allKeys containsObject:url]) {
        downloadTask = [self.downloadTasks objectForKey:url].downloadTask;
    }
    return downloadTask;
}

- (NSArray<NSURLSessionDownloadTask *> *)allDownloadTask{
    NSMutableArray * resultArr = [NSMutableArray array];
    for (NetworkDownloaderModel * model in self.downloadTasks.allValues) {
        [resultArr addObject:model];
    }
    return resultArr;
}


- (void)downloadFileWithUrl:(NSString *)url andDestUrl:(NSString *)destUrl andProgressBlock:(downloadProgressBlock)progressBlock andCompleteBlock:(downloadCompleteBlock)downloadCompleteBlock{
    //如果当前下载任务中包含,则返回
    if ([self.downloadTasks.allKeys containsObject:url]) {
        return;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NetworkDownloaderModel * downloaderModel = [[NetworkDownloaderModel alloc]initWithDownloadProgressBlock:progressBlock andDownloadCompleteBlock:downloadCompleteBlock];
    
    __weak __typeof(self)weakSelf = self;
   downloaderModel.downloadTask = [ manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//       downloaderModel.progress = downloadProgress;

    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:destUrl];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
        if ([weakSelf.downloadTasks.allKeys containsObject:url]) {//如果当前任务存在
            if ([weakSelf.downloadTasks objectForKey:url].downloadCompleteBlock) {//如果成功回调存在
                [weakSelf.downloadTasks objectForKey:url].downloadCompleteBlock([filePath path],error);
                [weakSelf.downloadTasks removeObjectForKey:url];//移除任务
            }
        }

    }];
    
    [downloaderModel.downloadTask resume];//开始下载
    [self.downloadTasks addEntriesFromDictionary:@{url:downloaderModel}];
}



@end






#pragma mark - 
#pragma mark - 私有类


@implementation NetworkDownloaderModel
- (instancetype)initWithDownloadProgressBlock:(downloadProgressBlock)downloadProgressBlock andDownloadCompleteBlock:(downloadCompleteBlock)downloadCompleteBlock{
    if(self = [super init]){
        self.downloadProgressBlock = downloadProgressBlock;
        self.downloadCompleteBlock = downloadCompleteBlock;
    }
    return self;
}

- (void)setProgress:(NSProgress *)progress{
    if (progress) {
        _progress = progress;
        [self.progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([object isEqual:self.progress] && [keyPath isEqualToString:@"completedUnitCount"]) {//
        if(self.downloadProgressBlock){
            self.downloadProgressBlock(self.progress);
        }
    }
}


- (void)dealloc{
    [self.progress removeObserver:self forKeyPath:@"completedUnitCount"];
}

@end



