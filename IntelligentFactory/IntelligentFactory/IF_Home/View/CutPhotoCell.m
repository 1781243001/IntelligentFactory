//
//  CutPhotoCell.m
//  IntelligentFactory
//
//  Created by My Book on 2017/8/9.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "CutPhotoCell.h"

@implementation CutPhotoCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
    }
    return self;
}

-(UIImageView *)imageView{

    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(7.5, 7.5, 50, 50)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;

}

@end
