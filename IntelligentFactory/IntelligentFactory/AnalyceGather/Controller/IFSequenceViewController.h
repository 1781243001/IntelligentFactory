//
//  IFSequenceViewController.h
//  IntelligentFactory
//
//  Created by My Book on 2017/7/7.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFBaseViewController.h"

typedef void(^returnAddSequenceBlock)(NSMutableArray *array);

@interface IFSequenceViewController : IFBaseViewController

@property (nonatomic,copy)returnAddSequenceBlock seqenceBlock;

@end
