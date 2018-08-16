//
//  RTCP2PKit.h
//  RTCP2PEngine
//
//  Created by derek on 2017/10/30.
//  Copyright © 2017年 derek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RTCP2PKitDelegate.h"
#import "RTCP2POption.h"
#include "RTCCommon.h"


@interface RTCP2PKit : NSObject


/**
 实例化P2P对象
 
 @param delegate RTC相关回调代理
 @param option 配置项
 @return P2P对象
 */
- (instancetype)initWithDelegate:(id <RTCP2PKitDelegate>)delegate andOption:(RTCP2POption *)option;

#pragma mark - P2P 呼叫方法
/**
 上线

 @param strUserId 用户自己的Id
 说明：如果更换用户，先turnOff
 */
- (void)turnOn:(NSString *)strUserId;
/**
 下线
 */
- (void)turnOff;

/**
 设置本地显示窗口

 @param render 本地视频窗口
 */
- (void)setLocalVideoCapturer:(UIView*)render;
/**
 设置滤镜（默认开启美颜）
 
 @param eFilter 滤镜模式
 说明:只有使用美颜相机模式才有用
 */
- (void)setCameraFilter:(AnyCameraDeviceFilter)eFilter;
/**
 呼叫

 @param strPeerUserId 呼叫的用户Id
 @param strUserData 用户自己的自定义信息
 */
- (void)makeCall:(NSString *)strPeerUserId withCallModel:(RTP2PCallMode)eCallMode withUserData:(NSString*)strUserData;

/**
 挂断通话

 @param strPeerUserId 呼叫的用户Id
 */
- (void)endCall:(NSString *)strPeerUserId;

/**
 接收同意通话

 @param strPeerUserId 呼叫的用户Id
 */
- (void)acceptCall:(NSString *)strPeerUserId;

/**
 拒绝通话

 @param strPeerUserId 呼叫的用户Id
 */
- (void)rejectCall:(NSString *)strPeerUserId;

/**
 设置其他视频显示窗口

 @param strPeerUserId 呼叫的用户Id
 @param render 窗口
 */
- (void)setRTCVideoRender:(NSString*)strPeerUserId andRender:(UIView*)render;

/**
 切换音频模式
 */
- (BOOL)onRTCSwithToAudioMode;

/**
 发送消息

 @param strPeerUserId 呼叫的用户Id
 @param strMessage 发送消息的内容(内容限制在512个字节内)
 */
- (void)sendUserMessage:(NSString *)strPeerUserId withMessage:(NSString *)strMessage;

/**
 抓图

 @param strFilePath 本地存储的地址＋图片名称
 */
- (BOOL)snapPeerPicture:(NSString*)strFilePath;

/**
 开始录制

 @param strFilePath 本地存储的地址＋视频名称
 */
- (BOOL)startRecordPeerVideo:(NSString*)strFilePath;

/**
 停止录制
 */
- (void)stopRecordPeerVideo;

#pragma mark -　本地视频设置操作
/**
 设置本地音频是否传输
 
 @param bEnable 打开或关闭本地音频
 说明：yes为传输音频,no为不传输音频，默认传输
 */
- (void)setLocalAudioEnable:(bool)bEnable;

/**
 设置本地视频是否传输
 
 @param bEnable 打开或关闭本地视频
 说明：yes为传输视频，no为不传输视频，默认视频传输
 */
- (void)setLocalVideoEnable:(bool)bEnable;

/**
 切换前后摄像头
 说明:切换本地前后摄像头。
 */
- (void)switchCamera;

/**
 设置扬声器开关
 
 @param bOn YES:打开扬声器，NO:关闭扬声器
 说明：扬声器默认打开
 */
- (void)setSpeakerOn:(bool)bOn;

/**
 清空会话
 说明：当别人挂断，或者自己挂断离开的时候，调用该方法用于清空本地视频
 */
- (void)close;
@end
