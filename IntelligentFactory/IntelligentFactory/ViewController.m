//
//  ViewController.m
//  IntelligentFactory
//
//  Created by My Book on 17/6/29.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "ViewController.h"
#import "Animationimg.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *dic = [self encryptContentAK:@"c4313306df4042d2" SK:@"7dde158b480d4adb82033053b9c453ef" String:@""];
    NSLog(@"%@",dic);
    
    [RequestService AFN_JSONResponseUrlType:RequestloginType requestWay:RequestGet param:dic modelClass:nil responseBlock:^(id dataObj, NSError *error) {
        
    }];
    
    
    // Do any additional setup after loading the view.
}

-(NSDictionary *)encryptContentAK:(NSString *)ak SK:(NSString *)sk String:(NSString *)content{
    NSString *md5_Content = [NSString md5:content];
    md5_Content = [md5_Content base64EncodedString];
    NSString *timeSting = [self getGMT];
    timeSting = @"Fri, 14 Jul 2017 06:09:29 GMT";
    NSString *signstring = [NSString stringWithFormat:@"date:%@\ncontent-md5:%@",timeSting,md5_Content];
//    signstring = [self getSignature:signstring SK:sk];
    NSString *Authorization = [NSString stringWithFormat:@"hmac accesskey=\"%@\",algorithm=\"%@\",headers=\"date %@\",signature=\"%@\"",ak,@"hmac-sha1",@"content-md5",signstring];
    NSDictionary *dic = @{@"Content-Type":@"application/x-www-form-urlencoded; charset=UTF-8",
                          @"Authorization":Authorization,
                          @"Date":timeSting,
                          @"Content-md5":md5_Content,
                          };
    return dic;
}

-(NSString *)getSignature:(NSString *)string SK:(NSString *)sk{

//    NSString *sha1 = [NSString hmacsha1:string key:sk];
     NSString *sha1 = [NSString Base_HmacSha1:sk data:string];
    
    return sha1;
}

-(NSString *)getGMT{

    NSDate *date = [NSDate date];
    
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"GMT"];
    
    [NSTimeZone setDefaultTimeZone:tzGMT];
    
    NSDateFormatter *iosDateFormater=[[NSDateFormatter alloc]init];
    
    iosDateFormater.dateFormat=@"EEE, d MMM yyyy HH:mm:ss 'GMT'";
    
    iosDateFormater.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    NSString *dateStr = [iosDateFormater stringFromDate:date];
    return dateStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
