//
//  SelectCustomItemView.m
//  IntelligentFactory
//
//  Created by My Book on 2017/8/1.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "SelectCustomItemView.h"

@implementation SelectCustomItemView{

    NSArray *_dataSource;
    itemClickBlock _block;
    CGRect _rect;
    NSMutableArray *_arrBtn;
    NSMutableArray *_imageArrBtn;
}


-(instancetype)initWithFrame:(CGRect)frame
                  dataSource:(NSArray *)array
                       block:(itemClickBlock)block{
    if (self = [super initWithFrame:frame]) {
        if (array.count == 0) {
            return self;
        }
        _dataSource = array;
        _block = block;
        int col = 3;
        float imgSpcae = 15;
        float imgWidth = (frame.size.width - 4*imgSpcae)/col;
        NSInteger i= 0;
        float height = 0;
        _arrBtn = [NSMutableArray array];
        _imageArrBtn = [NSMutableArray array];
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectOriganitian.png"]];
        image.frame = CGRectMake(0, 0, kScreen_Width, imgSpcae);
        [self addSubview:image];
        for (DetailedInformationModel *model in array) {
            float  img_X = imgSpcae+(imgWidth+imgSpcae)*(i%col);
            float itemMargin = imgSpcae +((30+imgSpcae)*(i/3));
            height= 0;
            UIButton *titleBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [titleBtn setTitle:model.text forState:(UIControlStateNormal)];
            titleBtn.tag = i;
//            titleBtn.layer.cornerRadius= 3;
//            titleBtn.layer.masksToBounds = YES;
//            titleBtn.layer.borderColor = [UIColor hexString:@"#D7D7D8"].CGColor;
//            titleBtn.layer.borderWidth = 0.5f;
            [titleBtn setTitleColor:[UIColor hexString:@"333333"] forState:(UIControlStateNormal)];
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [titleBtn addTarget:self action:@selector(clickShow:) forControlEvents:(UIControlEventTouchUpInside)];
            titleBtn.frame = CGRectMake(img_X, itemMargin, imgWidth, 30);
            titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
            [self addSubview:titleBtn];
            titleBtn.titleLabel.numberOfLines = 0;
            UIButton *imageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            imageBtn.tag = 400+i;
            [imageBtn addTarget:self action:@selector(clickAddData:) forControlEvents:(UIControlEventTouchUpInside)];
            imageBtn.frame = CGRectMake(imgWidth -15, 7.5, 15, 15);
            [titleBtn addSubview:imageBtn];
            if (i==0) {
                [titleBtn setTitleColor:[UIColor hexString:@"#005BAC"] forState:(UIControlStateNormal)] ;
                [imageBtn setBackgroundImage:[UIImage imageNamed:@"addModelItemOpen.png"] forState:(UIControlStateNormal)];
            }else{
                [titleBtn setTitleColor:[UIColor hexString:@"#333333"] forState:(UIControlStateNormal)] ;
                [imageBtn setBackgroundImage:[UIImage imageNamed:@"addModelItemClose.png"] forState:(UIControlStateNormal)];
            }
            height += itemMargin+30;
            i++;
            [_imageArrBtn addObject:imageBtn];
            [_arrBtn addObject:titleBtn];
        }
//        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
//        line.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:line];
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height+imgSpcae);
        _rect =self.frame;
    }
    return self;
}

-(void)clickShow:(UIButton *)sender{
    
    for (UIButton *btn in _arrBtn) {
        [btn setTitleColor:[UIColor hexString:@"#333333"] forState:(UIControlStateNormal)];
        [(UIButton *)[btn.subviews lastObject]  setBackgroundImage:[UIImage imageNamed:@"addModelItemClose.png"] forState:(UIControlStateNormal)];
    }
    [sender setTitleColor:[UIColor hexString:@"#005BAC"] forState:(UIControlStateNormal)];
    [(UIButton *)[sender.subviews lastObject]  setBackgroundImage:[UIImage imageNamed:@"addModelItemOpen.png"] forState:(UIControlStateNormal)];

    DetailedInformationModel *model = [_dataSource objectAtIndex:sender.tag];
    if (_block) {
        _block(model,self.tag,_rect);
    }
    
}

-(void)clickAddData:(UIButton *)sender{
    DetailedInformationModel *model = [_dataSource objectAtIndex:sender.tag-400];
//    for (UIButton *btn in _imageArrBtn) {
//        [btn setBackgroundImage:[UIImage imageNamed:@"addModelItemClose.png"] forState:(UIControlStateNormal)];
//    }
//    [sender setBackgroundImage:[UIImage imageNamed:@"addModelItemOpen.png"] forState:(UIControlStateNormal)];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SelectDeploy object:model];
}

@end
