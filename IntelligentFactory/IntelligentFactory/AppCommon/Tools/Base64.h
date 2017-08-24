//
//  Base64.h
//  IntelligentFactory
//
//  Created by My Book on 2017/8/16.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject
extern size_t EstimateBas64EncodedDataSize(size_t inDataSize);
extern size_t EstimateBas64DecodedDataSize(size_t inDataSize);

extern bool Base64EncodeData(const void *inInputData, size_t inInputDataSize, char *outOutputData, size_t *ioOutputDataSize, BOOL wrapped);
extern bool Base64DecodeData(const void *inInputData, size_t inInputDataSize, void *ioOutputData, size_t *ioOutputDataSize);
@end
