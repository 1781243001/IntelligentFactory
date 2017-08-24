//
//  NSString+Encrypt.h
//  IntelligentFactory
//
//  Created by My Book on 2017/8/16.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
@interface NSString (Encrypt)
+ (NSString *) md5:(NSString *) input;
- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;


+ (NSString *)encodeToPercentEscapeString: (NSString *) input;
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;

//hmacsha1  加密
+ (NSString *)hmacsha1:(NSString *)text key:(NSString *)secret;

+(NSString *)Base_HmacSha1:(NSString *)key data:(NSString *)data;


+ (NSString *)signWithHmacSHA1:(NSString *)input withKey:(NSString *)key;
@end
