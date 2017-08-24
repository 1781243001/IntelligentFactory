//
//  IFHomeViewModel.h
//  IntelligentFactory
//
//  Created by My Book on 17/6/27.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^currentBlock)();
@interface IFHomeViewModel : NSObject

+(void)reqestHomeDataModle:(currentBlock)block;
+(void)downLoadHtmlZip:(NSString *)filePath block:(currentBlock)block;
@end
