//
//  ATCallManager.m
//  P2PDemo
//
//  Created by jh on 2017/11/3.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATCallManager.h"

@interface ATCallManager()<RTCP2PKitDelegate>

@end

@implementation ATCallManager

static ATCallManager *manager = nil;

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ATCallManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        //配置信息
        RTCP2POption *option = [RTCP2POption defaultOption];
        option.videoMode = AnyRTCVideoQuality_Medium2;
        option.isFont = YES;
        self.p2PKit = [[RTCP2PKit alloc] initWithDelegate:self andOption:option];
    }
    return self;
}

//播放
- (void)playMp3{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"iphone" ofType:@"mp3"];
    NSURL *tempUrl = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    if (!self.player) {
        self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:tempUrl error:&error];
    }
    self.player.numberOfLoops = -1;
    [self.player prepareToPlay];
    [self.player play];
}

//暂停
- (void)pauseMp3{
    if (self.player && self.player.playing) {
        [self.player pause];
    }
}

#pragma mark - RTCP2PKitDelegate

- (void)onConnected{
    //服务连接成功
    UIViewController *currentVc = [ATCommon topViewController];
    if ([currentVc isKindOfClass:[ATMainViewController class]]){
        ATMainViewController *mainVc = (ATMainViewController *)currentVc;
        mainVc.isOn = YES;
        [mainVc.userButton setImage:[UIImage imageNamed:@"On_ine"] forState:UIControlStateNormal];
    } else if ([currentVc isKindOfClass:[ATStartViewController class]]){
        ATStartViewController *startVc = (ATStartViewController *)currentVc;
        [startVc.headButton setBackgroundImage:[UIImage imageNamed:@"On_ine"] forState:UIControlStateNormal];
        [startVc.mainVc.userButton setImage:[UIImage imageNamed:@"On_ine"] forState:UIControlStateNormal];
        startVc.isOn = YES;
        startVc.mainVc.isOn = YES;
    }
}

- (void)onDisconnect:(int)nCode{
    //服务断开    
    UIViewController *currentVc = [ATCommon topViewController];
    if ([currentVc isKindOfClass:[ATMainViewController class]]){
        ATMainViewController *mainVc = (ATMainViewController *)currentVc;
        [mainVc.userButton setImage:[UIImage imageNamed:@"Off_line"] forState:UIControlStateNormal];
    } else if ([currentVc isKindOfClass:[ATStartViewController class]]){
        ATStartViewController *startVc = (ATStartViewController *)currentVc;
        [startVc.headButton setBackgroundImage:[UIImage imageNamed:@"Off_line"] forState:UIControlStateNormal];
        [startVc.mainVc.userButton setImage:[UIImage imageNamed:@"Off_line"] forState:UIControlStateNormal];
    } else {
        UINavigationController *currentNav = (UINavigationController *)currentVc;
        [currentNav.navigationController popToRootViewControllerAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIViewController *topVc = [ATCommon topViewController];
            if ([topVc isKindOfClass:[ATMainViewController class]]) {
                ATMainViewController *mainVc = (ATMainViewController *)topVc;
                [mainVc.userButton setImage:[UIImage imageNamed:@"Off_line"] forState:UIControlStateNormal];
                mainVc.isOn = NO;
            }
        });
    }
    
    if (nCode == 100) {
        [XHToast showCenterWithText:@"网络异常"];
        return;
    }
    [XHToast showCenterWithText:[ATCommon getErrorInfoWithCode:nCode]];
}

- (void)onRTCMakeCall:(NSString *)strPeerUserId withCallModel:(RTP2PCallMode)eCallMode withUserData:(NSString*)strPeerUserData{
    [[ATCallManager sharedInstance] playMp3];
    //收到呼叫的回调
    UIViewController *currentVc = [ATCommon topViewController];
    if (eCallMode == RTP2P_CALL_Audio) {
        //音频
        ATAudioViewController *audioVc = [[currentVc storyboard] instantiateViewControllerWithIdentifier:@"Audio"];
        audioVc.callMode = eCallMode;
        audioVc.peerId = strPeerUserId;
        audioVc.isCall = NO;
        [currentVc.navigationController pushViewController:audioVc animated:YES];
    } else {
        //视频
        ATVideoViewController *videoVc = [[currentVc storyboard] instantiateViewControllerWithIdentifier:@"Video"];
        videoVc.callMode = eCallMode;
        videoVc.peerId = strPeerUserId;
        videoVc.isCall = NO;
        [currentVc.navigationController pushViewController:videoVc animated:YES];
    }
}

- (void)onRTCAcceptCall:(NSString *)strPeerUserId{
    //收到对方同意的回调
    UIViewController *currentVc = [ATCommon topViewController];
    if ([currentVc isKindOfClass:[ATVideoViewController class]]) {
        ATVideoViewController *videoVc = (ATVideoViewController *)currentVc;
        [videoVc acceptCall];
    } else if ([currentVc isKindOfClass:[ATAudioViewController class]]){
        ATAudioViewController *audioVc = (ATAudioViewController *)currentVc;
        [audioVc acceptCall];
    }
}

- (void)onRTCRejectCall:(NSString *)strPeerUserId withCode:(int)nCode{
    [XHToast showCenterWithText:[ATCommon getErrorInfoWithCode:nCode]];
    //收到对方拒绝的回调
    UIViewController *currentVc = [ATCommon topViewController];
    if ([currentVc isKindOfClass:[ATVideoViewController class]]) {
        ATVideoViewController *videoVc = (ATVideoViewController *)currentVc;
        videoVc.historyModel.state = @"拒接通话";
        if (nCode == 806) {
            videoVc.historyModel.state = @"通话无效";
        }
    } else if ([currentVc isKindOfClass:[ATAudioViewController class]]){
        ATAudioViewController *audioVc = (ATAudioViewController *)currentVc;
        audioVc.historyModel.state = @"拒接通话";
    }
    [currentVc.navigationController popViewControllerAnimated:YES];
}

- (void)onRTCEndCall:(NSString *)strPeerUserId withCode:(int)nCode{
    [XHToast showCenterWithText:[ATCommon getErrorInfoWithCode:nCode]];
    //收到对方挂断或者呼叫异常的回调
    UIViewController *currentVc = [ATCommon topViewController];
    [self.p2PKit close];
    [currentVc.navigationController popViewControllerAnimated:YES];
}

- (void)onRTCOpenVideoRender:(NSString*)strPeerUserId{
    //收到对方视频视频即将显示的回调
    UIViewController *currentVc = [ATCommon topViewController];
    if ([currentVc isKindOfClass:[ATVideoViewController class]]) {
        ATVideoViewController *videoVc = (ATVideoViewController *)currentVc;
        
        if (videoVc.callMode == RTP2P_CALL_VideoPro && !videoVc.isCall) {
            //优先显示且是被呼叫方
            [videoVc setRTCVideoPro];
            [videoVc.callView changProVideoState:YES];
        } else {
            [videoVc setRTCVideoRender];
        }
    }
}

- (void)onRTCCloseVideoRender:(NSString*)strPeerUserId{
    //收到对方视频离开的回调
    
}

//消息回调
- (void)onRTCUserMessage:(NSString *)strPeerUserId withMessage:(NSString *)strMessage {
    NSLog(@"--%@ --%@ --",strPeerUserId,strMessage);
}

//转到音频模式
- (void)onRTCSwithToAudioMode {
    UIViewController *currentVc = [ATCommon topViewController];
    if ([currentVc isKindOfClass:[ATVideoViewController class]]){
        ATVideoViewController *videoVc =(ATVideoViewController *)currentVc;
        [videoVc switchToAudio];
    }
}

@end
