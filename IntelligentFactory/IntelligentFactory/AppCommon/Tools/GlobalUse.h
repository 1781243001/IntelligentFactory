//
//  GlobalUse.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/27.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalUse : NSObject
/**
 从像素px转换为ios的点阵pt
 */
+(CGFloat)pxTopt:(CGFloat)px;
/**
 UIColor 转UIImage
 */
+(UIImage*)createImageWithColor:(UIColor*)color;

@end
