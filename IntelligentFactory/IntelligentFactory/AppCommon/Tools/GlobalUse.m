//
//  GlobalUse.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/27.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "GlobalUse.h"

@implementation GlobalUse

+(CGFloat)pxTopt:(CGFloat)px{
    CGFloat standardPt = px/2.0;
    if (iphone5) {
        standardPt = (iphone5W/iphone6W)*standardPt;
    }else if(iphone6){
        
    }else if(iphone6plus){
        standardPt = (iphone6plusW/iphone6W)*standardPt;
    }else;
    return standardPt;
}

/**
 UIColor 转UIImage
 */
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
