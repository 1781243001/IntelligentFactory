//
//  IF_WebRequestViewModel.m
//  IntelligentFactory
//
//  Created by My Book on 2017/8/4.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IFWebRequestViewModel.h"
#import "InformationDataModel.h"
@implementation IFWebRequestViewModel

+(void)reqestWebViewDataModleblock:(currentBlock)block{
    NSDictionary *dic = @{@"EquipType":@"Android",
                          @"DeviceID":@"864232024092607",
                          @"RequestParams":@[
                                  @{@"key":@"value1",
                                    @"value":@"0"}],
                          @"EquipSN":@"7855a7e01a387c5f",
                          @"AppID":@"zb.s20170704000000001",
                          @"UserID":@"test",
                          @"IsEncrypted":@"false",
                          @"RequestMethod":@"1b363376-cfba-4b3e-bc48-53e361f3de1e|7f0911a0-7fbf-48a2-aea5-45f618c10ce5",
                          };
    [RequestService AFN_JSONResponseUrlType:RequestMeasureListType requestWay:RequestPost param:dic modelClass:[InformationDataModel class] responseBlock:^(id dataObj, NSError *error) {
        block(dataObj,error);
    }];

}
//产耗
+(void)reqestProductConsumeDataModleblock:(currentBlock)block{
    NSDictionary *dic = @{@"EquipType":@"Android",
                          @"DeviceID":@"864232024092607",
                          @"RequestParams":@[
                                  @{@"key":@"value1",
                                    @"value":@"0"}],
                          @"EquipSN":@"7855a7e01a387c5f",
                          @"AppID":@"zb.s20170704000000001",
                          @"UserID":@"test",
                          @"IsEncrypted":@"false",
                          @"RequestMethod":@"696969f2-bc52-4fec-bf9f-9859d528a750|b704e211-4a94-4d49-8bac-3acf550351f1",
                          };
    [RequestService AFN_JSONResponseUrlType:RequestMeasureListType requestWay:RequestPost param:dic modelClass:[InformationDataModel class] responseBlock:^(id dataObj, NSError *error) {
        block(dataObj,error);
    }];
    
}

+(void)reqestDiffereceAnalyceMedium:(currentBlock)block{
    
    NSDictionary *dic = @{@"EquipType":@"Android",
                          @"DeviceID":@"864232024092607",
                          @"RequestParams":@[
                                  @{@"key":@"value1",
                                    @"value":@"0"}],
                          @"EquipSN":@"7855a7e01a387c5f",
                          @"AppID":@"zb.s20170704000000001",
                          @"UserID":@"test",
                          @"IsEncrypted":@"false",
                          @"RequestMethod":@"e9356e20-c203-496f-b637-3eed075349fa|9e7f8445-9094-4640-adc9-4a5cda4b6876",
                          };
    [RequestService AFN_JSONResponseUrlType:RequestMeasureListType requestWay:RequestPost param:dic modelClass:[InformationDataModel class] responseBlock:^(id dataObj, NSError *error) {
        block(dataObj,error);
    }];

}

+(void)reqestDiffereceAnalyceArea:(currentBlock)block{
    NSDictionary *dic = @{@"EquipType":@"Android",
                          @"DeviceID":@"864232024092607",
                          @"RequestParams":@[
                                  @{@"key":@"value1",
                                    @"value":@"0"}],
                          @"EquipSN":@"7855a7e01a387c5f",
                          @"AppID":@"zb.s20170704000000001",
                          @"UserID":@"test",
                          @"IsEncrypted":@"false",
                          @"RequestMethod":@"e9356e20-c203-496f-b637-3eed075349fa|c732de3a-0c23-4533-904a-e5e1910a9d57",
                          };
    [RequestService AFN_JSONResponseUrlType:RequestMeasureListType requestWay:RequestPost param:dic modelClass:[InformationDataModel class] responseBlock:^(id dataObj, NSError *error) {
        block(dataObj,error);
    }];
}

@end
