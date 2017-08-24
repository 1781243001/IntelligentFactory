//
//  IFHomeViewModel.m
//  IntelligentFactory
//
//  Created by My Book on 17/6/27.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFHomeViewModel.h"
@implementation IFHomeViewModel

+(void)reqestHomeDataModle:(currentBlock)block{
    NSDictionary *dic = @{@"userid":@"t-liqiang",
                          @"password":@"t-liqiang"};
    [RequestService AFN_JSONResponseUrlType:RequestloginType requestWay:RequestPost param:dic modelClass:nil responseBlock:^(id dataObj, NSError *error) {
        if (error) {
            NSLog(@"失败");
            return ;
        }
        block();
    }];
}

+(void)downLoadHtmlZip:(NSString *)filePath
                 block:(currentBlock)block{
    
    [self startDownloadRequest:filePath block:block];
}

+ (void)startDownloadRequest:(NSString *)filePath
                       block:(currentBlock)block{
    NSString *stringName = @"compress.zip";
    NSString *string = [NSString stringWithFormat:@"%@/%@",[FileService themeResouceDir],stringName];
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",[FileService themeResouceDir],@"intelligentPlant"];
    [NetworkDownloader downloadFileWithUrl:filePath andDestUrl:string andProgressBlock:^(NSProgress *downloadProgress) {
        
    } andCompleteBlock:^(NSString *filePath, NSError *error) {
        if (error) {
            return ;
        }
        [FileService deleteFile:stringPath];
        if([SSZipArchive unzipFileAtPath:filePath toDestination:[FileService themeResouceDir]]){
            //删除原来的资源包
            [FileService deleteFile:filePath];
            block();
        }
    }];
}

@end
