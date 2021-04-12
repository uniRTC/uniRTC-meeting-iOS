# uniRTC-meeting-iOS
<h2>1. 将UNIRTCMeetingUIKit、UNIRTCScreenShareManager和WebRTC导入工程</h2>
![image](https://github.com/uniRTC/uniRTC-meeting-iOS/blob/main/shotcuts/1.png)

需要同时将UNIRTCMeetingUIKitAssets导入到Copy Bundle Resources中

![image](https://github.com/uniRTC/uniRTC-meeting-iOS/blob/main/shotcuts/2.png)


<h2>2. 使用时需要先引入架包类</h2>

```
#import <UNIRTCMeetingUIKit/UNIMeetingViewController.h>
```

以及配置代理UNIMeetingViewControllerDelegate

>加入会议：

><pre><code>UNIMeetingViewController * meetingVC = [[UNIMeetingViewController alloc] init];
    meetingVC.delegate = self;
    [self presentViewController:meetingVC animated:YES completion:^{
        [meetingVC joinMeetingWithRoomID:@"房间号(必填)" displayName:@"显示名称(必填)" displayID:@"本人ID(非必填)" avatarUrl:@"头像URL(非必填)" meetingAbstract:@"会议主题/描述等(非必填)" meetingTime:@"会议开始时间(非必填)" autoAudioON:(BOOL)是否入会开启音频 andAutoVideoOn:(BOOL)是否入会开启视频];
    }];</code></pre>

>创建会议：

><pre><code>UNIMeetingViewController * meetingVC = [[UNIMeetingViewController alloc] init];
meetingVC.delegate = self;
    [self presentViewController:meetingVC animated:YES completion:^{
        [meetingVC createMeetingWithMeetingNum:@"房间号(非必填)" displayName:@"显示名称(必填)"  displayID:@"本人ID(非必填)" avatarUrl:@"头像URL(非必填)" meetingAbstract:@"会议主题/描述等(非必填)" meetingTime:@"会议开始时间(非必填)" autoAudioON:(BOOL)是否入会开启音频 andAutoVideoOn:(BOOL)是否入会开启视频];
    }];</code></pre>

>代理：

><pre><code>@optional
-(void)UNIMeetingHasBeenClosed; //会议结束
-(void)UNIMeetingHasStarted; //会议开始
-(void)UNIMeetingInviteBtnHasBeenActived; //邀请按钮被点击
-(void)UNIMeetingInfoBtnHasBeenActived;  //会议信息按钮被点击 不使用此代理则使用默认界面
@required
-(void)UNIMeetingRequireChangeOrientationToLandscapeRight:(BOOL)isRequired {
//触发屏幕共享模式需要旋转屏幕至横屏
if (isActived) {
        _appDelegate.allowRotation = YES;//(打开横屏开关)
        [_meetingVC setNewOrientation:@"LandscapeRight"];
    } else {
        _appDelegate.allowRotation = NO;
        [_meetingVC setNewOrientation:@"Portrait"];
    }
}</code></pre>

>在此之前需要修改一下AppDelegate

>在.h文件中声明变量

><pre><code>@property(nonatomic,assign)BOOL allowRotation;</code></pre>

>在.m文件中添加

>//横屏

><pre><code>- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == YES) {   // 如果属性值为YES,仅允许屏幕横向旋转,否则仅允许竖屏
        return UIInterfaceOrientationMaskLandscape;
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}</code></pre>

>然后引入AppDelegate

><pre><code>
#import "AppDelegate.h"
@property (nonatomic, readwrite) AppDelegate * appDelegate;
_appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
</code></pre>

<h2>3. 获取会议信息</h2>
![image](https://github.com/uniRTC/uniRTC-meeting-iOS/blob/main/shotcuts/3.png)


<h2>4. 需要添加的三方内容</h2>

>pod 'AFNetworking', '~> 4.0'

>pod 'MBProgressHUD', '~> 1.1.0'

>pod 'Masonry'

>pod 'SDWebImage', '~> 5.0'

>pod 'MMWormhole', '~> 2.0.0'


<h2>5. 屏幕共享</h2>
>如需要屏幕共享功能 需要添加Broadcast Upload Extension，具体如何添加这边不做说明

>在target的Signing& Capabilities中添加App Groups
>![image](https://github.com/uniRTC/uniRTC-meeting-iOS/blob/main/shotcuts/4.png)

>在生成的SampleHandler中引入UNIRTCScreenShareManager 切记不要在extension中embed任何库，否则无法上架，只需在宿主app中Embed&sign即可
![image](https://github.com/uniRTC/uniRTC-meeting-iOS/blob/main/shotcuts/5.png)

```
#import <UNIRTCScreenShareManager/UNIRTCSampleHandlerSocketManager.h>
```

>在.m文件中broadcastStartedWithSetupInfo方法下添加:

><pre><code>[[UNIRTCSampleHandlerSocketManager sharedManager] setUpSocketWithApplicationGroupIdentifier:@"上述app groups 的 ID"];
    [UNIRTCSampleHandlerSocketManager sharedManager].stopBlock = ^(void){
//屏幕共享已结束
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"APP名称", NSLocalizedDescriptionKey, @"屏幕共享已结束", NSLocalizedFailureReasonErrorKey, nil, NSLocalizedRecoverySuggestionErrorKey,nil];
        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-101 userInfo:userInfo];
        [self finishBroadcastWithError:error];
    };</code></pre>

>broadcastFinished方法下添加：

><pre><code>[[UNIRTCSampleHandlerSocketManager sharedManager] sendBroadcastFinishedToHostApp];</code></pre>

>processSampleBuffer方法下case RPSampleBufferTypeVideo 中添加：

><pre><code>[[UNIRTCSampleHandlerSocketManager sharedManager] sendVideoBufferToHostApp:sampleBuffer];</code></pre>



<h2>6. 后台保活</h2>
>plist info 中添加 Required background modes - > App plays audio or streams audio/video using Airplay
