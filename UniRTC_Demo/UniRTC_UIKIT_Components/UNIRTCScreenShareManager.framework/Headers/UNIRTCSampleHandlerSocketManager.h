//
//  UNIRTCSampleHandlerSocketManager.h
//  UNIRTCCVideo
//
//  Created by flagadmin on 2020/5/7.
//  Copyright © 2020 flagadmin. All rights reserved.
//

#import <ReplayKit/ReplayKit.h>
#import <Foundation/Foundation.h>
typedef void(^ScreenShareStopBlock) (void);
NS_ASSUME_NONNULL_BEGIN
@interface UNIRTCSampleHandlerSocketManager : NSObject
@property(nonatomic, copy) ScreenShareStopBlock stopBlock;
+ (UNIRTCSampleHandlerSocketManager *)sharedManager;
- (void)setUpSocketWithApplicationGroupIdentifier:(NSString *)identifier;
- (void)socketDelloc;
- (void)sendBroadcastFinishedToHostApp;
- (void)sendVideoBufferToHostApp:(CMSampleBufferRef)sampleBuffer;

@end

NS_ASSUME_NONNULL_END
