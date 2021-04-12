//
//  LoginJoinMeetViewController.h
//  ULink
//
//  Created by lhy on 2020/5/12.
//  Copyright © 2020 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextFieldLiner.h"
#import "UserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginJoinMeetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextFieldLiner *login_meetingnum_textfield;
@property (weak, nonatomic) IBOutlet UITextField *login_meetname_textfield;
@property (weak, nonatomic) IBOutlet UIButton *login_joinmeeting_btn;
@property (weak, nonatomic) IBOutlet UIButton *login_createmeeting_btn;

@property (assign, nonatomic) Boolean *meetingDelete;
@property (nonatomic, strong) NSUserDefaults* meetingDefaults;
@property (nonatomic, strong) UserInfoModel* userInfo;

@end

NS_ASSUME_NONNULL_END
