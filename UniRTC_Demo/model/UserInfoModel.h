//
//  UserInfoModel.h
//  ULink
//
//  Created by lhy on 2020/5/14.
//  Copyright © 2020 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject<NSCoding>
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) NSString *nickName;
@property (assign, nonatomic) BOOL rememberCloseMic;

@end

NS_ASSUME_NONNULL_END
