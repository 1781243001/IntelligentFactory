//
//  IFDiffereceAnalyceController.h
//  IntelligentFactory
//
//  Created by My Book on 2017/8/8.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFBaseViewController.h"

@protocol DiffereceAnalyceDelegate <NSObject>

-(void)analyceReturnWebViewData:(NSMutableArray *)array;

@end

@interface IFDiffereceAnalyceController : IFBaseViewController

@property (nonatomic,weak)id<DiffereceAnalyceDelegate> differeceDelegate;

@end
