//
//  UserInfoModel.m
//  ULink
//
//  Created by lhy on 2020/5/14.
//  Copyright © 2020 lhy. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.phoneNum forKey:@"phonemobile"];
    [aCoder encodeObject:self.nickName forKey:@"nickname"];
    [aCoder encodeBool:self.rememberCloseMic forKey:@"mic"];
 
}
 
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.phoneNum = [aDecoder decodeObjectForKey:@"phonemobile"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickname"];
        self.rememberCloseMic = [aDecoder decodeBoolForKey:@"mic"];
    }
    
    return self;
}

@end
