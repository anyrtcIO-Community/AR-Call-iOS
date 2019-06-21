//
//  ArCallManager.m
//  ArP2PDemo
//
//  Created by 余生丶 on 2019/5/16.
//  Copyright © 2019 anyRTC. All rights reserved.
//

#import "ArCallManager.h"

static ArCallManager *callManager = nil;

@interface ArCallManager()

@property (nonatomic, strong) ARCallOption *option;
@property (nonatomic, strong) NSMutableArray *logArr;

@end

@implementation ArCallManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        callManager = [[ArCallManager alloc] init];
    });
    return callManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.logArr = [NSMutableArray array];
        self.callKit = [[ARCallKit alloc] initWithDelegate:self];
        ArMethodText(@"initWithDelegate:");
        self.userId = ArUserManager.getUserInfo.userid;
    }
    return self;
}

- (void)callWithNumber:(NSString *)number mode:(ARCallMode)callMode callStatus:(ArCallStatus)status makeCall:(BOOL)call {
    if (![self.userId isEqualToString:number]) {
        self.callMode = callMode;
        self.callView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.callView.userId = number;
        self.callView.callStatus = status;
        UIWindow *window = UIApplication.sharedApplication.delegate.window;
        [window addSubview:self.callView];
        
        if (call) {
            //主动拨打
            ARUserOption *option = ARUserOption.defaultOption;
            option.callMode = callMode;
            int result = [self.callKit makeCallUser:number option:option];
            ArMethodText(@"makeCallUser:option:");
            if (result) {
                if (result == -1) {
                    [ArCallCommon showAlertMessage:@"呼叫频繁，请稍后再试"];
                }
                [self removeCallView];
                return;
            }
            if (callMode == AR_Call_VideoPro) {
                [self.callKit setLocalVideoCapturer:self.callView option:self.option];
                ArMethodText(@"setLocalVideoCapturer:option:");
            }
        } else {
            //被动接听
            if (callMode != AR_Call_Meet_Invite) {
                if (callMode < 3) {
                    NSArray *arr = @[@"视频通话",@"视频优先呼叫",@"音频通话"];
                    self.callView.timeLabel.text = arr[callMode];
                }
            }
        }

        if (callMode == AR_Call_Audio && call) {
            [UIDevice currentDevice].proximityMonitoringEnabled = YES;
        }
        [self playMp3];
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"自己不能呼叫自己"];
        [SVProgressHUD dismissWithDelay:0.8];
    }
}

//MARK: - ARCallKitDelegate

- (void)onRTCConnected {
    //服务器链接成功
    ArCallbackLog;
}

- (void)onRTCDisconnect:(ARCallCode)code {
    //服务器断开
    ArCallbackLog;
}

- (void)onRTCMakeCall:(NSString *)meetId userId:(NSString *)userId userData:(NSString *)userData callModel:(ARCallMode)callMode extend:(NSString*)extend {
    //收到呼叫的回调
    ArCallbackLog;
    [self callWithNumber:userId mode:callMode callStatus:ArCallStatus_Accept makeCall:NO];
}

- (void)onRTCAcceptCall:(NSString *)userId {
    //收到对方同意的回调
    ArCallbackLog;
    if (self.callMode != AR_Call_Audio) {
        [self.callKit setLocalVideoCapturer:self.callView.localView option:self.option];
        ArMethodText(@"setLocalVideoCapturer:option:");

        self.callView.callStatus = ArCallStatus_Video;
    } else {
        self.callView.callStatus = ArCallStatus_Audio;
        [self.callView.timeLabel timeMeterStart];
    }
     [self pauseMp3];
}

- (void)onRTCRejectCall:(NSString *)userId code:(ARCallCode)code {
    //收到对方拒绝的回调
    ArCallbackLog;
    if (code == ARCall_PEER_BUSY) {
        [ArCallCommon showAlertMessage:@"对方忙，请稍后再呼..."];
    } else {
        [ArCallCommon showAlertMessage:@"对方拒绝了你的呼叫请求"];
    }
    [self removeCallView];
}

- (void)onRTCEndCall:(NSString *)userId code:(ARCallCode)code {
    //收到对方挂断的回调
    ArCallbackLog;
    if (code == ARCall_TIMEOUT) {
        [ArCallCommon showAlertMessage:@"呼叫超时，请重新呼叫..."];
    } else {
        [ArCallCommon showAlertMessage:@"对方挂断了通话"];
    }
    [self removeCallView];
}

- (void)onRTCOpenRemoteVideoRender:(NSString *)userId renderId:(NSString*)renderId userData:(NSString*)userData {
    //收到对方视频视频即将显示的回调
    ArCallbackLog;
    [self.callKit setRemoteVideoRender:self.callView.renderView renderId:renderId];
    ArMethodText(@"setRemoteVideoRender:renderId:");
}

- (void)onRTCCloseRemoteVideoRender:(NSString *)userId  renderId:(NSString*)renderId {
    //收到对方视频离开的回调
    ArCallbackLog;
}

- (void)onRTCOpenRemoteAudioTrack:(NSString *)userId userData:(NSString *)userData {
    //收到对方音频即将播放的回调
    ArCallbackLog;
}

- (void)onRTCCloseRemoteAudioTrack:(NSString *)userId {
    //收到对方音频离开的回调
    ArCallbackLog;
}

- (void)onRTCSipSupport:(BOOL)pstn extension:(BOOL)extension null:(BOOL)null {
    //是否支持SIP呼叫
    ArCallbackLog;
}

- (void)onRTCSwithToAudioMode {
    //切换到音频模式
    ArCallbackLog;
}

- (void)onRTCUserMessage:(NSString *)userId message:(NSString *)content {
    //收到消息回调
    ArCallbackLog;
}

- (void)onRTCRemoteAVStatus:(NSString *)userId audio:(BOOL)audio video:(BOOL)video {
    //其他与会者对音视频的操作
    ArCallbackLog;
}

- (void)onRTCLocalAVStatus:(BOOL)audio video:(BOOL)video {
    //别人对自己音视频的操作
    ArCallbackLog;
}

- (void)onRTCFirstLocalVideoFrame:(CGSize)size {
    //本地视频第一帧
    ArCallbackLog;
}

- (void)onRTCFirstRemoteVideoFrame:(CGSize)size renderId:(NSString *)renderId {
    //远程视频第一帧
    ArCallbackLog;
}

- (void)onRTCLocalVideoViewChanged:(CGSize)size {
    //本地窗口大小的回调
    ArCallbackLog;
}

- (void)onRTCRemoteVideoViewChanged:(CGSize)size renderId:(NSString *)renderId {
    //远程窗口大小的回调
    ArCallbackLog;
}

- (void) onRTCUserCTIStatus:(int)queueNum {
    //呼叫队列用户的排队信息
    ArCallbackLog;
}

- (void) onRTCClerkCTIStatus:(int)queueNum clerkNum:(int)allClerk woringClerkNum:(int)woringNum {
    //服务队列的相关队列信息
    ArCallbackLog;
}

//MARK: - CallDelegate

- (void)handleWithUserId:(NSString *)userId tag:(NSInteger)tag status:(BOOL)selected {
    switch (tag) {
        case 50:
            //音频
            [self.callKit setLocalAudioEnable:!selected];
            ArMethodText(@"setLocalAudioEnable:");
            break;
        case 51:
            //拒绝
            [self.callKit rejectCall:userId];
            ArMethodText(@"rejectCall:");
            [self removeCallView];
        case 52:
            //挂断
            [self.callKit endCall:userId];
            ArMethodText(@"endCall:");
            [self removeCallView];
            break;
        case 53:
            //扬声器
            [self.callKit setSpeakerOn:!selected];
            ArMethodText(@"setSpeakerOn:");
            break;
        case 54:
            //视频
            [self.callKit setLocalVideoEnable:!selected];
            ArMethodText(@"setLocalVideoEnable:");
            break;
        case 55:
            //接听
            [self.callKit acceptCall:userId];
            ArMethodText(@"acceptCall:");
            if (self.callMode != AR_Call_Audio) {
                self.callView.callStatus = ArCallStatus_Video;
                [self.callKit setLocalVideoCapturer:self.callView.localView option:self.option];
                ArMethodText(@"setLocalVideoCapturer:option:");
            } else {
                //音频
                [UIDevice currentDevice].proximityMonitoringEnabled = YES;
                self.callView.callStatus = ArCallStatus_Audio;
                [self.callView.timeLabel timeMeterStart];
            }
            [self pauseMp3];
            break;
        case 56:
            //旋转摄像头
            [self.callKit switchCamera];
            ArMethodText(@"switchCamera");
            break;
        case 57:
            //抓图
            UIImageWriteToSavedPhotosAlbum([self.callKit snapPicture:userId], self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
            ArMethodText(@"snapPicture:");
            break;
        case 58:
            //日志
        {
            ArLogView *logView = [[ArLogView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [logView refreshLogText:self.logArr];
            UIWindow *window = UIApplication.sharedApplication.delegate.window;
            [window addSubview:logView];
        }
            break;
        default:
            break;
    }
    
}

//MARK: - other

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:@"截图成功"];
        [SVProgressHUD dismissWithDelay:1.0];
    }
}

- (ArContactCallView *)callView {
    if (!_callView) {
        _callView = [[[NSBundle mainBundle] loadNibNamed:@"ArContactCallView" owner:self options:nil] lastObject];
        _callView.delegate = self;
    }
    return _callView;
}

- (void)removeCallView {
    [self.callKit close];
    ArMethodText(@"close");
    [self.callView.timeLabel timeMeterEnd];
    [self.callView removeFromSuperview];
    self.callView = nil;
    [self pauseMp3];
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
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

- (ARCallOption *)option {
    if (!_option) {
        //配置信息
        _option = ARCallOption.defaultOption;
        ARVideoConfig *config = [[ARVideoConfig alloc] init];
        config.videoProfile = ARVideoProfile288x352;
        config.isFont = YES;
        _option.videoConfig = config;
    }
    return _option;
}

@end
