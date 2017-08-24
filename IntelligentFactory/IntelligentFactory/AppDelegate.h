//
//  AppDelegate.h
//  IntelligentFactory
//
//  Created by My Book on 17/6/27.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IF_LoginViewController.h"
#import "KeychainItemWrapper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)IF_LoginViewController *loginCon;
@property (nonatomic,strong) KeychainItemWrapper *wrapper;
+(AppDelegate *)sharedApplication;

-(void)clearKeychainItemWrapper;

@end

