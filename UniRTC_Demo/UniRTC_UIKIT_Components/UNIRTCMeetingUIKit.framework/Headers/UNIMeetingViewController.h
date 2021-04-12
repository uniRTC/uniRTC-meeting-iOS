//
//  UNIMeetingViewController.h
//  ULink
//
//  Created by 紫光 on 2020/11/13.
//  Copyright © 2020 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol UNIMeetingViewControllerDelegate <NSObject>
@optional
-(void)UNIMeetingHasStarted;
-(void)UNIMeetingInviteBtnHasBeenActived;
-(void)UNIMeetingCopyBtnHasBeenActived;
-(void)UNIMeetingInfoBtnHasBeenActived;
@required
-(void)UNIMeetingRequireChangeOrientationToLandscapeRight:(BOOL)isRequired;
-(void)UNIMeetingHasBeenClosed;
@end
@interface UNIMeetingViewController : UIViewController 
@property (nonatomic, weak) id<UNIMeetingViewControllerDelegate> _Nullable delegate;
@property (nonatomic,copy) NSString* room_id;
@property (nonatomic, copy) NSString* display_name;
@property (nonatomic, copy) NSString* avatar_url;
@property (nonatomic, copy) NSNumber* display_id;
@property (nonatomic, copy) NSNumber* abstract;
@property (nonatomic, readwrite) UIView * meeting_custom_info_view;
@property (nonatomic, readwrite) id extra;

-(void)joinMeetingWithRoomID:(NSString * _Nonnull)room_id displayName:(NSString * _Nonnull)display_name displayID:(NSNumber * _Nullable)display_id avatarUrl:(NSString * _Nullable)avatar_url meetingAbstract:(NSString *_Nullable)title meetingTime:(NSString *_Nullable)time autoAudioON:(BOOL)auto_audio andAutoVideoOn:(BOOL)auto_video;

-(void)createMeetingWithMeetingNum:(NSString * _Nullable)meeting_num displayName:(NSString * _Nonnull)display_name displayID:(NSNumber * _Nullable)user_id avatarUrl:(NSString * _Nullable)avatar_url meetingAbstract:(NSString *_Nullable)title meetingTime:(NSString *_Nullable)time autoAudioON:(BOOL)auto_audio andAutoVideoOn:(BOOL)auto_video;

//#import "AppDelegate.h"
//@property (nonatomic, readwrite) AppDelegate * appDelegate;
//_appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//_appDelegate.allowRotation = YES;//(打开横屏开关)
//[self setNewOrientation:@"LandscapeRight"];
//_appDelegate.allowRotation = NO;
//[self setNewOrientation:@"Portrait"];
- (void)setNewOrientation:(NSString *)orientation;
@end

NS_ASSUME_NONNULL_END
