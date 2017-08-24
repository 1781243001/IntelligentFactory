//
//  FileService.h
//  HtmlDemo
//
//  Created by Nile on 2017/5/9.
//  Copyright © 2017年 Nile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileService : NSObject
#pragma mark -

+(NSString *)returnFileName:(NSString *)FileString;

#pragma mark - 检查文件创建
+ (BOOL)checkAndAutoCreateDirWithDir:(NSString *)dir;
+ (BOOL)checkAndCreateFileWithFile:(NSString *)file;

+ (BOOL)fileExit:(NSString *)file;
+ (BOOL)deleteFile:(NSString *)file;

#pragma mark -
#pragma mark -  获取文件夹
+ (NSString *)documentsDirectory;
+ (NSString *)themeResouceDir;
+ (NSString *)mediaResouceDir;
+ (NSString *)configDir;

#pragma mark -
#pragma mark - 获取文件
+ (NSString *)innerThemeConfigFile;
+ (NSString *)currentThemeConfigFile;
+ (NSString *)downloadedThemeConfigFile;
@end
