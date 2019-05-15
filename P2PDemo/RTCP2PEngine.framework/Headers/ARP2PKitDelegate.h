//
//  ARP2PKitDelegate.h
//  RTCP2PEngine
//
//  Created by zjq on 2019/1/16.
//  Copyright © 2019 derek. All rights reserved.
//

#ifndef ARP2PKitDelegate_h
#define ARP2PKitDelegate_h
#import <UIKit/UIKit.h>
#include "ARP2PEnum.h"

@protocol ARP2PKitDelegate <NSObject>

/**
 服务器链接成功
 */
- (void)onRTCConnected;

/**
 服务器断开
 
 @param code 状态码
 */
- (void)onRTCDisconnect:(ARP2PCode)code;

/**
 收到呼叫的回调
 
 @param userId 呼叫方的Id
 @param callMode 呼叫类型
 @param userData 呼叫方的自定义信息
 */
- (void)onRTCMakeCall:(NSString *)userId callModel:(ARP2PCallModel)callMode userData:(NSString *)userData;

/**
 收到对方同意的回调
 
 @param userId 呼叫方的Id
 */
- (void)onRTCAcceptCall:(NSString *)userId;

/**
 收到对方拒绝的回调
 
 @param userId 被呼叫方的Id
 @param code 状态码
 */
- (void)onRTCRejectCall:(NSString *)userId code:(ARP2PCode)code;

/**
 收到对方挂断的回调
 
 @param userId 用户id
 @param code 状态码
 */
- (void)onRTCEndCall:(NSString *)userId code:(ARP2PCode)code;

/**
 收到对方视频视频即将显示的回调
 
 @param userId 呼叫的用户Id
 说明：收到该回调，调用setRemoteVideoRender显示对方视频窗口
 */
- (void)onRTCOpenRemoteVideoRender:(NSString *)userId;

/**
 收到对方视频离开的回调
 
 @param userId 呼叫的用户Id
 */
- (void)onRTCCloseRemoteVideoRender:(NSString *)userId;

/**
 切换到音频模式
 */
- (void)onRTCSwithToAudioMode;

/**
 收到消息回调
 
 @param userId 发送消息的用户Id
 @param content 消息内容
 */
- (void)onRTCUserMessage:(NSString *)userId message:(NSString *)content;

@end


#endif /* ARP2PKitDelegate_h */

