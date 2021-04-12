//
//  AppDelegate.m
//  UniRTC_Demo
//
//  Created by lin qiong on 2021/4/12.
//

#import "AppDelegate.h"
#import "LoginJoinMeetViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    LoginJoinMeetViewController * meetingVC = [[LoginJoinMeetViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:meetingVC];
    self.window.rootViewController = nav;
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

//横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == YES) {   // 如果属性值为YES,仅允许屏幕向左旋转,否则仅允许竖屏
        return UIInterfaceOrientationMaskLandscape;  // 这里是屏幕要旋转的方向
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}

@end
