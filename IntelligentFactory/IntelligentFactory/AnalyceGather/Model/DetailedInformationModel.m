//
//  DetailedInformationModel.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/28.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "DetailedInformationModel.h"

@implementation DetailedInformationModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"children":@"DetailedInformationModel"};
}

- (instancetype)init{
    
    if (self=[super init]) {
        
        [DetailedInformationModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id"
                     };
        }];
        
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super init];
    
    if (self) {
        self.ID = [aDecoder decodeIntegerForKey:@"ID"];
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.iconCls =[aDecoder decodeObjectForKey:@"iconCls"];
        self.state =[aDecoder decodeObjectForKey:@"state"];
        self.parentId =[aDecoder decodeObjectForKey:@"parentId"];
        self.children =[aDecoder decodeObjectForKey:@"children"];
        self.remark =[aDecoder decodeIntegerForKey:@"remark"];
    }
        return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:_ID forKey:@"ID"];
    [aCoder encodeObject:_text forKey:@"text"];
    [aCoder encodeObject:_iconCls forKey:@"iconCls"];
    [aCoder encodeObject:_state forKey:@"state"];
    [aCoder encodeObject:_parentId forKey:@"parentId"];
    [aCoder encodeObject:_children forKey:@"children"];
    [aCoder encodeInteger:_remark forKey:@"remark"];

}




@end
