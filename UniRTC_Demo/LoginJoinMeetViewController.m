//
//  LoginJoinMeetViewController.m
//  ULink
//
//  Created by lhy on 2020/5/12.
//  Copyright © 2020 lhy. All rights reserved.
//

#import "LoginJoinMeetViewController.h"
#import <UNIRTCMeetingUIKit/UNIMeetingViewController.h>
#import "AppDelegate.h"

#define ULINKUSERINFO @"userinfo"

@interface LoginJoinMeetViewController () <UNIMeetingViewControllerDelegate>
@property (nonatomic, readwrite) AppDelegate * appDelegate;
@property (nonatomic, readwrite) UNIMeetingViewController * meetingVC;
@end

@implementation LoginJoinMeetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initViews];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)initViews{
    _meetingDefaults = [NSUserDefaults standardUserDefaults];
    _login_meetingnum_textfield.delegate = self;
//    [_login_meetingnum_textfield addTarget:self action:@selector(meetingnumInputChange:) forControlEvents:UIControlEventEditingChanged];
    _meetingDelete = false;
    
    _login_joinmeeting_btn.backgroundColor = [UIColor colorWithRed:37/255.0 green:135/255.0 blue:246/255.0 alpha:1];
    _login_joinmeeting_btn.layer.cornerRadius = 22.0;
    _login_createmeeting_btn.backgroundColor = [UIColor colorWithRed:37/255.0 green:135/255.0 blue:246/255.0 alpha:1];
    _login_createmeeting_btn.layer.cornerRadius = 22.0;
    if(_userInfo == nil){
        _userInfo = [[UserInfoModel alloc]init];
    }
    if(_userInfo.nickName != NULL || _userInfo.nickName != nil){
        _login_meetname_textfield.text = _userInfo.nickName;
    }
}

- (void)delayDoMethod{
     [self joinMeetingBtnClick:nil];
}

- (void)meetingnumInputChange:(UITextField *)textChange {
    if ([_login_meetingnum_textfield.text length] == 1 && !_meetingDelete)
    {
        NSString* txt = _login_meetingnum_textfield.text;
        _login_meetingnum_textfield.text = [txt stringByAppendingString: @"-"];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([_login_meetingnum_textfield.text length] == 2 && range.length == 1 && string.length == 0){
        _meetingDelete = true;
        _login_meetingnum_textfield.text = @"";
    }else{
        _meetingDelete = false;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)loginMeetCloseBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)joinMeetingBtnClick:(UIButton *)sender {
    sender.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           sender.enabled = YES;
    });
    
    NSString *joinNumber = [_login_meetingnum_textfield text];
    NSString *joinDisplay = [_login_meetname_textfield text];
    
    if(joinNumber == NULL || [joinNumber isEqualToString:@""]){
        NSLog(@"请输入会议号");
        return;
    }
    
    if(joinDisplay == NULL || [joinDisplay isEqualToString:@""]){
        NSLog(@"请输入名称,再加入会议");
        return;
    }
//    [[ULinkHttpManager sharedManager] postJoinByTourist:meetingnum username:joinDisplay success:^(id json) {}];
    [self joinMeeting:nil meetingname:joinDisplay meetingnum:joinNumber];
}

- (IBAction)createMeetingBtnClick:(UIButton *)sender {
    NSString *joinDisplay = [_login_meetname_textfield text];
    if(joinDisplay == NULL || [joinDisplay isEqualToString:@""]){
        NSLog(@"请输入名称,再加入会议");
        return;
    }
    _meetingVC = [[UNIMeetingViewController alloc] init];
    _meetingVC.delegate = self;
    [self.navigationController pushViewController:_meetingVC animated:YES];
    [_meetingVC createMeetingWithMeetingNum:nil displayName:joinDisplay displayID:nil avatarUrl:nil meetingAbstract:nil meetingTime:nil autoAudioON:NO andAutoVideoOn:NO];
}


-(void)joinMeeting: (NSString*) urlAddress meetingname: (NSString*) name meetingnum: (NSString *) num{
    _meetingVC = [[UNIMeetingViewController alloc] init];
    _meetingVC.delegate = self;
    [self.navigationController pushViewController:_meetingVC animated:YES];
    [_meetingVC joinMeetingWithRoomID:num displayName:name displayID:nil avatarUrl:nil meetingAbstract:nil meetingTime:nil autoAudioON:NO andAutoVideoOn:NO];
}

- (void)UNIMeetingRequireChangeOrientationToLandscapeRight:(BOOL)isRequired {
    if (isRequired) {
        _appDelegate.allowRotation = YES;//(打开横屏开关)
        [_meetingVC setNewOrientation:@"LandscapeRight"];
    } else {
        _appDelegate.allowRotation = NO;
        [_meetingVC setNewOrientation:@"Portrait"];
    }
}

- (void)UNIMeetingHasBeenClosed {
    NSLog(@"meeting has been closed");
    [_meetingVC.navigationController popViewControllerAnimated:YES];
    _meetingVC.delegate = nil;
    _meetingVC = nil;
}

-(void)UNIMeetingInviteBtnHasBeenActived {
    //自定义邀请
}

-(void)UNIMeetingCopyBtnHasBeenActived {
    //自定义复制
}

-(void)handleMeetingShare {
    //自定义分享
}

- (BOOL)isEmptyString:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    NSString *toString = [self trimString:string];
    if ([toString isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (NSString *)trimString:(NSString *)string {
    if (string == nil) {
        return @"";
    }
    NSString *trim = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trim;
}

@end
