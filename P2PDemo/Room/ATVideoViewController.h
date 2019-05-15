//
//  ATVideoViewController.h
//  P2PDemo
//
//  Created by jh on 2017/11/3.
//  Copyright © 2017年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATHistoryModel.h"

@interface ATVideoViewController : UIViewController

//呼叫Id
@property (nonatomic, copy)NSString *peerId;
//呼叫模式
@property (nonatomic, assign) ARP2PCallModel callMode;
//接听0 呼叫1
@property (nonatomic, assign) BOOL isCall;

@property (nonatomic, strong) ATCallView *callView;

@property (nonatomic, strong) ATCallManager *callManager;

@property (nonatomic, strong) ATHistoryModel *historyModel;
//开始通话时间
@property (nonatomic, assign) long startDate;

//接受P2P请求
- (void)acceptCall;

//设置其他视频显示窗口
- (void)setRTCVideoRender;

//优先显示
- (void)setRTCVideoPro;

//切换音频显示
- (void)switchToAudio;

@end
