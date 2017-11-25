//
//  ATVideoViewController.m
//  P2PDemo
//
//  Created by jh on 2017/11/3.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATVideoViewController.h"

@interface ATVideoViewController ()

@property (weak, nonatomic) IBOutlet UIView *renderView;
//切换摄像头
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
//音频背景
@property (weak, nonatomic) IBOutlet UIImageView *audioImageView;
//音频头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
//音频id
@property (weak, nonatomic) IBOutlet UILabel *peerIdLabel;
//音频计时
@property (weak, nonatomic) IBOutlet ATLabel *infoLabel;
//音频按钮
@property (weak, nonatomic) IBOutlet UIButton *audioButton;
//音频扬声器
@property (weak, nonatomic) IBOutlet UIButton *speakerButton;
//工具
@property (weak, nonatomic) IBOutlet UIView *toolView;
//切换音频按钮
@property (weak, nonatomic) IBOutlet UIButton *switchAudioButton;
//y
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topY;
//x
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingX;

//点击计数
@property (nonatomic, assign) NSInteger index;
//本地窗口
@property (nonatomic, strong) UIView *localView;
//工具显示
@property (nonatomic, strong) UITapGestureRecognizer *toolTap;
//切换大小
@property (nonatomic, strong)UITapGestureRecognizer *switchTap;

@property (nonatomic, assign)BOOL isLayout;

@end

@implementation ATVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.callManager = [ATCallManager sharedInstance];
    
    if (self.isCall) {
        //呼叫方
        if (self.callMode == RTP2P_CALL_VideoPro) {
            [self itializationP2PKit];
        }
        [self.callView changeTimeMeterStart];
        [self.callManager.p2PKit makeCall:self.peerId withCallModel:self.callMode withUserData:nil];
    } else {
        //接听方
        if (self.callMode == RTP2P_CALL_VideoPro) {
            //pro显示
            [self.callView changProVideoState:NO];
        }
    }
    
    self.callView.peerLabel.text = self.peerId;
    [self.view insertSubview:self.callView atIndex:99];
    [self.view insertSubview:self.localView atIndex:0];
    
    if (self.callMode != RTP2P_CALL_VideoMon) {
        [self.view addGestureRecognizer:self.toolTap];
        [self.renderView addGestureRecognizer:self.switchTap];
    }
    
    //呼叫历史
    self.historyModel = [[ATHistoryModel alloc]init];
    self.historyModel.date = [NSString stringWithFormat:@"%ld",[ATCommon getSecondsSince1970]];
    self.historyModel.phoneStr = self.peerId;
    self.historyModel.callMode = self.callMode;
    self.historyModel.state = @"未接通话";
}

//设置本地视频窗口
- (void)itializationP2PKit{
    [self.callManager.p2PKit setLocalVideoCapturer:self.localView];
}

//设置其他视频显示窗口
- (void)setRTCVideoRender{
    if (self.callMode == RTP2P_CALL_VideoMon) {
        //视频监听模式(被呼叫方为Android用户)
        [self.callView removeFromSuperview];
        [self.callManager.p2PKit setRTCVideoRender:self.peerId andRender:self.localView];
        self.switchAudioButton.hidden = YES;
        self.audioButton.hidden = YES;
        self.speakerButton.hidden = YES;
        self.cameraButton.hidden = YES;
    } else {
        [self.callManager.p2PKit setRTCVideoRender:self.peerId andRender:self.renderView];
        [self toolViewDisplay];
    }
}

//优先显示
- (void)setRTCVideoPro{
    self.callView.headImageView.hidden = YES;
    [self.callManager.p2PKit setRTCVideoRender:self.peerId andRender:self.callView.proView];
}

//P2P接受
- (void)acceptCall{
    self.startDate = [ATCommon getSecondsSince1970];
    [[ATCallManager sharedInstance] pauseMp3];
    self.historyModel.state = @"已接通话";
    [ATCommon basicAnimation:self.callView];
    if (self.callMode == RTP2P_CALL_Video) {
        [self itializationP2PKit];
    }
}

#pragma mark - event
- (IBAction)doSomethingEvents:(UIButton *)sender {
    sender.selected = !sender.selected;
    switch (sender.tag) {
        case 101:
            //音频
            [self.callManager.p2PKit setLocalAudioEnable:!sender.selected];
            break;
        case 102:
            //挂断
            self.historyModel.state = @"已接通话";
            
            [self.callManager.p2PKit endCall:self.peerId];
            [self.callManager.p2PKit close];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 103:
            //视频
            if (self.peerIdLabel.text.length !=0) {
                //切换扬声器
                [self.callManager.p2PKit setSpeakerOn:!sender.selected];
                return;
            }
            [self.callManager.p2PKit setLocalVideoEnable:!sender.selected];
            break;
        case 104:
            //切换音频模式
            self.startDate = [ATCommon getSecondsSince1970];
            self.historyModel.callMode = RTP2P_CALL_Audio;
            if ([self.callManager.p2PKit onRTCSwithToAudioMode]) {
                [self switchToAudio];
            } else {
                [XHToast showCenterWithText:@"切换音频模式失败"];
            }
            break;
        case 105:
            [self.callManager.p2PKit switchCamera];
            break;
        default:
            break;
    }
}

//切换音频模式
- (void)switchToAudio{
    self.audioImageView.image = [UIImage imageNamed:@"bg"];
    self.headImageView.image = [UIImage imageNamed:@"headurl"];
    self.peerIdLabel.text = self.peerId;
    [self.infoLabel timeMeterStart:@"正在通话中..."];
    [self.renderView removeFromSuperview];
    [self.localView removeFromSuperview];
    [self.switchAudioButton removeFromSuperview];
    [self.speakerButton setImage:[UIImage imageNamed:@"Button_speaker"] forState:UIControlStateNormal];
    [self.speakerButton setImage:[UIImage imageNamed:@"Button_speaker_click"] forState:UIControlStateSelected];
    self.toolView.hidden = NO;
    self.cameraButton.hidden = YES;
    
    self.startDate = [ATCommon getSecondsSince1970];
    self.historyModel.callMode = RTP2P_CALL_Audio;
}

//工具显示
- (void)toolViewDisplay{
    if (self.index != 0) {
        return;
    }
    self.index ++;
    self.toolView.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.toolView.hidden = YES;
        self.index = 0;
        if (self.peerIdLabel.text.length > 0) {
            self.toolView.hidden = NO;
        }
    });
}

- (void)viewDidLayoutSubviews{
    if (self.isLayout) {
        self.renderView.frame = self.view.bounds;
    }
}

//切换大小
- (void)switchSize{
    [self toolViewDisplay];
    self.toolView.hidden = NO;
    if (self.localView.frame.size.width == self.view.frame.size.width) {
        self.leadingX.constant = 0;
        self.topY.constant = 0;
        self.isLayout = YES;
        CGRect origin = self.renderView.frame;
        //self.renderView.frame = self.view.bounds;
        self.localView.frame = origin;
        [self.renderView removeGestureRecognizer:self.switchTap];
        [self.localView addGestureRecognizer:self.switchTap];
        [self.view insertSubview:self.renderView belowSubview:self.toolView];
        [self.view insertSubview:self.localView aboveSubview:self.toolView];
    } else {
        self.isLayout = NO;
        self.leadingX.constant = 10;
        self.topY.constant = 20;
        CGRect origin = self.localView.frame;
        self.localView.frame = self.view.bounds;
        self.renderView.frame = origin;
        [self.localView removeGestureRecognizer:self.switchTap];
        [self.renderView addGestureRecognizer:self.switchTap];
        [self.view insertSubview:self.renderView aboveSubview:self.toolView];
        [self.view insertSubview:self.localView belowSubview:self.toolView];
    }
}


#pragma mark - other
- (ATCallView *)callView{
    if (!_callView) {
        _callView = [[[NSBundle mainBundle]loadNibNamed:@"ATCallView" owner:self options:nil] lastObject];
        _callView.frame = self.view.bounds;
        WEAKSELF;
        _callView.callBlock = ^(NSInteger tag) {
            [[ATCallManager sharedInstance] pauseMp3];
            switch (tag) {
                case 100:
                    //接听
                    if (weakSelf.callMode == RTP2P_CALL_VideoPro) {
                        [weakSelf setRTCVideoRender];
                    }
                    [weakSelf.callManager.p2PKit acceptCall:weakSelf.peerId];
                    [weakSelf itializationP2PKit];
                    
                    weakSelf.historyModel.state = @"已接通话";
                    weakSelf.startDate = [ATCommon getSecondsSince1970];
                    //移除
                    [ATCommon basicAnimation:weakSelf.callView];
                    [weakSelf toolViewDisplay];
                    break;
                case 101:
                    weakSelf.historyModel.state = @"拒接通话";
                    //拒接
                    [weakSelf.callManager.p2PKit rejectCall:weakSelf.peerId];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    break;
                case 102:
                    //呼叫挂断
                    [weakSelf.callManager.p2PKit endCall:weakSelf.peerId];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    break;
                default:
                    break;
            }
        };
    }
    return _callView;
}

- (UIView *)localView{
    if (!_localView) {
        _localView = [[UIView alloc]initWithFrame:self.view.bounds];
        _localView.backgroundColor = [UIColor clearColor];
    }
    return _localView;
}

- (UITapGestureRecognizer *)toolTap{
    if (!_toolTap) {
        _toolTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toolViewDisplay)];
    }
    return _toolTap;
}

- (UITapGestureRecognizer *)switchTap{
    if (!_switchTap) {
        _switchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switchSize)];
    }
    return _switchTap;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.startDate != 0) {
        self.historyModel.timer = [NSString stringWithFormat:@"%ld",[ATCommon getSecondsSince1970] - self.startDate];
    } else {
        self.historyModel.timer = @"0";
    }
    [ATHistoryTool saveHistoryWithMainModel:self.historyModel];
    [[ATCallManager sharedInstance] pauseMp3];
}

@end
