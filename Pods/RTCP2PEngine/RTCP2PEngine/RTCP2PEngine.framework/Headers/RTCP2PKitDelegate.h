//
//  RTCP2PKitDelegate.h
//  RTCP2PEngine
//
//  Created by derek on 2017/10/30.
//  Copyright © 2017年 derek. All rights reserved.
//

#ifndef RTCP2PKitDelegate_h
#define RTCP2PKitDelegate_h
#import <UIKit/UIKit.h>
#include "RTCCommon.h"

@protocol RTCP2PKitDelegate <NSObject>

/**
 服务器链接成功
 */
- (void)onConnected;

/**
 服务器断开

 @param nCode 状态码
 */
- (void)onDisconnect:(int)nCode;

/**
 收到呼叫的回调

 @param strPeerUserId 呼叫方的Id
 @param eCallMode 呼叫类型
 @param strPeerUserData 呼叫方的自定义的相关信息
 */
- (void)onRTCMakeCall:(NSString *)strPeerUserId withCallModel:(RTP2PCallMode)eCallMode withUserData:(NSString*)strPeerUserData;

/**
 收到对方同意的回调

 @param strPeerUserId 呼叫方的Id
 */
- (void)onRTCAcceptCall:(NSString *)strPeerUserId;

/**
 收到对方拒绝的回调

 @param strPeerUserId 被呼叫方的Id
 @param nCode 状态码
 */
- (void)onRTCRejectCall:(NSString *)strPeerUserId withCode:(int)nCode;

/**
 收到对方挂断的回调

 @param strPeerUserId 如果自己是主叫方，该参数为被呼叫方Id,如果自己是被呼叫方，该参数为呼叫方Id
 @param nCode 状态码
 */
- (void)onRTCEndCall:(NSString *)strPeerUserId withCode:(int)nCode;

/**
 收到对方视频视频即将显示的回调

 @param strPeerUserId 呼叫用户的用户Id（作为　setRTCVideoRender 方法的参数）
 */
- (void)onRTCOpenVideoRender:(NSString*)strPeerUserId;

/**
 收到对方视频离开的回调

 @param strPeerUserId 呼叫用户的Id
 */
- (void)onRTCCloseVideoRender:(NSString*)strPeerUserId;

/**
 转换到音频模式
 */
- (void)onRTCSwithToAudioMode;


/**
 收到消息回调
 
 @param strPeerUserId 发送消息者在Id；
 @param strMessage 消息内容
 */
- (void)onRTCUserMessage:(NSString*)strPeerUserId withMessage:(NSString *)strMessage;
@end

#endif /* RTCP2PKitDelegate_h */
