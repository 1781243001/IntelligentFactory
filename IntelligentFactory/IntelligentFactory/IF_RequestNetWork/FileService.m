//
//  FileService.m
//  HtmlDemo
//
//  Created by Nile on 2017/5/9.
//  Copyright © 2017年 Nile. All rights reserved.
//

#import "FileService.h"

static NSString *const themeResouceDirName               = @"ThemeResouce";
static NSString *const configDirName                     = @"Config";
static NSString *const mediaResouceDirName               = @"MediaResouce";
static NSString *const themeConfigFileName               = @"ThemeConfig.plist";
static NSString *const currentThemeConfigFileName        = @"CurrentThemeConfig.plist";
static NSString *const downloadedThemeConfigFileName     = @"DownloadedThemeConfig.plist";

@implementation FileService
#pragma mark -
+(NSString *)returnFileName:(NSString *)fileString{
    NSArray *arr = [fileString componentsSeparatedByString:@"/"];
    return [arr lastObject];
}


#pragma mark - 初始化创建文件
+ (void)initialize{
    
    //创建ThemeResouce文件夹
    [self checkAndAutoCreateDirWithDir:[self themeResouceDir]];
    
    //创建MediaResouce文件夹
//    [self checkAndAutoCreateDirWithDir:[self mediaResouceDir]];
    
    //创建Config文件夹
//    [self checkAndAutoCreateDirWithDir:[self configDir]];
    
    //创建currentThemeConfig.plist
//    [self checkAndCreateFileWithFile:[self currentThemeConfigFile]];
    
    //创建downloadedThemeConfig.plist
//    [self checkAndCreateFileWithFile:[self downloadedThemeConfigFile]];
    
}


#pragma mark -
#pragma mark - 检查文件创建

+ (BOOL)checkAndAutoCreateDirWithDir:(NSString *)dir{
    if (![self fileExit:dir]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
        return NO;
    }
    return YES;
}

+ (BOOL)checkAndCreateFileWithFile:(NSString *)file{
    if (![self fileExit:file]){
        [[NSFileManager defaultManager] createFileAtPath:file contents:nil attributes:nil];
        return NO;
    }
    return YES;
}

+ (BOOL)fileExit:(NSString *)file{
    return [[NSFileManager defaultManager]fileExistsAtPath:file];
}


#pragma mark -
#pragma mark -  获取文件夹
+ (NSString*)documentsDirectory{
    NSString * result = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return result;
}

+ (NSString *)themeResouceDir{
    return [[self documentsDirectory] stringByAppendingPathComponent:themeResouceDirName];
}

+ (NSString *)mediaResouceDir{
    return [[self themeResouceDir] stringByAppendingPathComponent:mediaResouceDirName];
}

+ (NSString *)configDir{
    return [[self themeResouceDir] stringByAppendingPathComponent:configDirName];
}


#pragma mark -
#pragma mark - 获取文件
+ (NSString *)currentThemeConfigFile{
    return [[self configDir] stringByAppendingPathComponent:currentThemeConfigFileName];
}

+ (NSString *)downloadedThemeConfigFile{
    return [[self configDir] stringByAppendingPathComponent:downloadedThemeConfigFileName];
}

+ (NSString *)innerThemeConfigFile{
    return [[NSBundle mainBundle] pathForResource:themeConfigFileName ofType:nil];
}


+ (BOOL)deleteFile:(NSString *)file{
    if([self fileExit:file]){
        return [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    }
    return YES;
}

@end
