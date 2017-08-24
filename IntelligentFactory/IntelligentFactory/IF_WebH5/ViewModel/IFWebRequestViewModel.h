//
//  IF_WebRequestViewModel.h
//  IntelligentFactory
//
//  Created by My Book on 2017/8/4.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^currentBlock)(id data,NSError *error);

@interface IFWebRequestViewModel : NSObject
+(void)reqestWebViewDataModleblock:(currentBlock)block;

+(void)reqestProductConsumeDataModleblock:(currentBlock)block;//产耗

+(void)reqestDiffereceAnalyceMedium:(currentBlock)block;//差异分析 介质

+(void)reqestDiffereceAnalyceArea:(currentBlock)block; //差异分析 管网

@end
