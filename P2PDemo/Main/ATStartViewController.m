//
//  ATStartViewController.m
//  P2PDemo
//
//  Created by jh on 2017/11/3.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATStartViewController.h"

@interface ATStartViewController ()
//通话id
@property (weak, nonatomic) IBOutlet UITextField *peerIdTextField;
//音频通话
@property (weak, nonatomic) IBOutlet UIButton *audioButton;
//优先通话
@property (weak, nonatomic) IBOutlet UIButton *priorityButton;
//视频监看
@property (weak, nonatomic) IBOutlet UIButton *monitorButton;

@property (nonatomic, strong) ATVideoViewController *videoVc;

@end

@implementation ATStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.audioButton.layer.borderColor = [ATCommon getColor:@"#135ded"].CGColor;
    self.priorityButton.layer.borderColor = [ATCommon getColor:@"#cccccc"].CGColor;
    self.monitorButton.layer.borderColor = [ATCommon getColor:@"#cccc99"].CGColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tap];
    self.userLabel.text = self.userId;
    if (self.isOn) {
        [self.headButton setBackgroundImage:[UIImage imageNamed:@"On_ine"] forState:UIControlStateNormal];
    } else {
        [self.headButton setBackgroundImage:[UIImage imageNamed:@"Off_line"] forState:UIControlStateNormal];
    }
}

- (IBAction)doSomethingEvents:(UIButton *)sender {
    [ATCommon hideKeyBoard];
    if ([self.userId isEqualToString:self.peerIdTextField.text]) {
        self.peerIdTextField.text = @"";
        [self.peerIdTextField becomeFirstResponder];
        [XHToast showCenterWithText:@"自己不能呼叫自己"];
        return;
    }
    
    if (sender.tag != 99 && sender.tag != 104 && !([ATCommon valiMobile:self.peerIdTextField.text])) {
        [XHToast showBottomWithText:@"手机号格式错误"];
        return;
    }
    self.videoVc.peerId = self.peerIdTextField.text;
    
    switch (sender.tag) {
        case 99:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case 100:
            //视频通话
            self.videoVc.callMode = RTP2P_CALL_Video;
            [self.navigationController pushViewController:self.videoVc animated:YES];
            break;
        case 101:
            //视频优先通话
            self.videoVc.callMode = RTP2P_CALL_VideoPro;
            [self.navigationController pushViewController:self.videoVc animated:YES];
            break;
        case 102:
            //视频监看
            self.videoVc.callMode = RTP2P_CALL_VideoMon;
            [self.navigationController pushViewController:self.videoVc animated:YES];
            break;
        case 103:
        {
            //音频通话
            ATAudioViewController *audioVc = [[self storyboard] instantiateViewControllerWithIdentifier:@"Audio"];
            audioVc.callMode = RTP2P_CALL_Audio;
            audioVc.peerId = self.peerIdTextField.text;
            audioVc.isCall = YES;
            [self.navigationController pushViewController:audioVc animated:YES];
        }
            break;
        case 104:
        {
            //重新呼叫
            if (!self.isOn) {
                RTCP2POption *option = [RTCP2POption defaultOption];
                option.videoMode = RTCP2P_Videos_QHD;
                option.isFont = YES;
                [[[ATCallManager sharedInstance] p2PKit] turnOn:self.userId andOption:option];
            }
        }
        default:
            break;
    }
}

- (void)hideKeyBoard{
    [ATCommon hideKeyBoard];
}

- (ATVideoViewController *)videoVc{
    if (!_videoVc) {
        _videoVc = [[self storyboard] instantiateViewControllerWithIdentifier:@"Video"];
        _videoVc.isCall = YES;
    }
    return _videoVc;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.videoVc = nil;
}

@end
