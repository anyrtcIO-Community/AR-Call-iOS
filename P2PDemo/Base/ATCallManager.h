//
//  ATCallManager.h
//  P2PDemo
//
//  Created by jh on 2017/11/3.
//  Copyright © 2017年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface ATCallManager : NSObject<AVAudioPlayerDelegate>

@property (nonatomic, strong) ARP2PKit *p2PKit;
//呼叫模式
@property (nonatomic, assign) ARP2PCallModel callMode;

@property (nonatomic, copy) NSString *peerId;

@property (nonatomic, strong) AVAudioPlayer *player;

+ (id)sharedInstance;

//收到P2P请求
- (void)playMp3;
//接听、挂断、拒接
- (void)pauseMp3;

@end
