//
//  ArCallManager.h
//  ArP2PDemo
//
//  Created by 余生丶 on 2019/5/16.
//  Copyright © 2019 anyRTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArContactCallView.h"
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArCallManager : NSObject<ARCallKitDelegate,CallDelegate>

@property (nonatomic, strong) ARCallKit *callKit;

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, strong) ArContactCallView *callView;
@property (nonatomic, assign) ARCallMode callMode;
@property (nonatomic, strong) AVAudioPlayer *player;

+ (instancetype)shareInstance;

/**
 呼叫
 
 @param number 呼叫号码
 @param callMode 呼叫模式：音频、视频、优先、zoom
 @param status  呼叫状态
 @param call 主叫、被叫
 */
- (void)callWithNumber:(NSString *)number mode:(ARCallMode)callMode callStatus:(ArCallStatus)status makeCall:(BOOL)call;

@end

NS_ASSUME_NONNULL_END
