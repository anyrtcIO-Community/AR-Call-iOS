//
//  ATAudioViewController.m
//  P2PDemo
//
//  Created by jh on 2017/11/3.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATAudioViewController.h"

@interface ATAudioViewController ()

//呼叫id
@property (weak, nonatomic) IBOutlet UILabel *peerLabel;
//信息
@property (weak, nonatomic) IBOutlet ATLabel *infoLabel;

@property (nonatomic ,strong)ATCallManager *callManager;

@property (nonatomic , strong)ATCallView *callView;

@end

@implementation ATAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.callManager = [ATCallManager sharedInstance];
    if (self.isCall) {
        [self.callView changeTimeMeterStart];
        [self.callManager.p2PKit makeCall:self.peerId withCallModel:self.callMode withUserData:nil];
    }
    self.callView.peerLabel.text = self.peerId;
    self.callView.infoLabel.text = @"音频通话";
    [self.view insertSubview:self.callView atIndex:99];
    
    //呼叫历史
    self.historyModel = [[ATHistoryModel alloc]init];
    self.historyModel.date = [NSString stringWithFormat:@"%ld",[ATCommon getSecondsSince1970]];
    self.historyModel.phoneStr = self.peerId;
    self.historyModel.callMode = self.callMode;
    self.historyModel.state = @"未接通话";
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
            //扬声器
            [self.callManager.p2PKit setSpeakerOn:!sender.selected];
            break;
        default:
            break;
    }
}

- (void)acceptCall{
    self.startDate = [ATCommon getSecondsSince1970];
    [[ATCallManager sharedInstance] pauseMp3];
    [self.callView removeFromSuperview];
    [self.infoLabel timeMeterStart:@"正在通话中..."];
    self.historyModel.state = @"已接通话";
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
                {
                    weakSelf.historyModel.state = @"已接通话";
                    weakSelf.startDate = [ATCommon getSecondsSince1970];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.callManager.p2PKit acceptCall:weakSelf.peerId];
                        [weakSelf.callView removeFromSuperview];
                        [weakSelf.infoLabel timeMeterStart:@"正在通话中..."];
                    });
                }
                    break;
                case 101:
                    weakSelf.historyModel.state = @"拒接通话";
                    //拒接
                    [weakSelf.callManager.p2PKit rejectCall:weakSelf.peerId];
                    [weakSelf.callManager.p2PKit close];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    break;
                case 102:
                    //呼叫挂断
                    [weakSelf.callManager.p2PKit endCall:weakSelf.peerId];
                    [weakSelf.callManager.p2PKit close];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    break;
                default:
                    break;
            }
        };
    }
    return _callView;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.startDate != 0) {
        self.historyModel.timer = [NSString stringWithFormat:@"%ld",[ATCommon getSecondsSince1970] - self.startDate];
    } else {
        //未接通
        self.historyModel.timer = @"0";
    }
    [ATHistoryTool saveHistoryWithMainModel:self.historyModel];
    [[ATCallManager sharedInstance] pauseMp3];
}
@end
