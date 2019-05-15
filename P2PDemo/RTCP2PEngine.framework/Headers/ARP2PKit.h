//
//  ARP2PKit.h
//  RTCP2PEngine
//
//  Created by zjq on 2019/1/16.
//  Copyright © 2019 derek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ARP2PKitDelegate.h"
#import "ARP2POption.h"
#import "ARP2PEnum.h"


NS_ASSUME_NONNULL_BEGIN

@interface ARP2PKit : NSObject

/**
 实例化P2P对象
 
 @param delegate RTC相关回调代理
 @param option 配置信息
 @return P2P对象
 */
- (instancetype)initWithDelegate:(id <ARP2PKitDelegate>)delegate option:(ARP2POption *)option;

#pragma mark - 上下线

/**
 上线

 @param token 令牌:客户端向自己服务申请获得，参考企业级安全指南
 @param userId 用户Id，确保平台唯一，不能为空
 */
- (void)turnOnByToken:(NSString* _Nullable)token userId:(NSString *)userId;

/**
 下线
 */
- (void)turnOff;

#pragma mark - 本地和远程视频预览
/**
 设置本地显示窗口
 
 @param render 本地视频窗口
 */
- (void)setLocalVideoCapturer:(UIView *)render;

/**
 设置滤镜
 
 @param filter 滤镜模式
 说明：只有使用美颜相机模式才有用。
 */
- (void)setCameraFilter:(ARCameraFilterMode)filter;

/**
 设置其他视频显示窗口
 
 @param render 视频显示窗口
 @param userId 呼叫的用户Id
 */
- (void)setRemoteVideoRender:(UIView *)render userId:(NSString *)userId;


#pragma mark - 呼叫相关
/**
 呼叫
 
 @param userId 呼叫的用户Id
 @param callMode 呼叫模式
 @param userData 用户的自定义信息（限制512字节）
 */
- (void)makeCall:(NSString *)userId callModel:(ARP2PCallModel)callMode userData:(NSString *)userData;

/**
 挂断通话
 
 @param userId 呼叫的用户Id
 */
- (void)endCall:(NSString *)userId;

/**
 同意通话
 
 @param userId 呼叫的用户Id
 */
- (void)acceptCall:(NSString *)userId;

/**
 拒绝通话
 
 @param userId 呼叫的用户Id
 */
- (void)rejectCall:(NSString *)userId;

#pragma mark - RTC方法

/**
 切换音频模式
 
 @return 操作是否成功。
 */
- (BOOL)onRTCSwithToAudioMode;

/**
 发送消息
 
 @param userId 发送消息者的用户Id
 @param content 发送消息的内容(限制1024字节)
 */
- (void)sendUserMessage:(NSString *)userId message:(NSString *)content;

/**
 抓取对方的图片
 
 @param filePath 本地存储的地址＋图片名称
 */
- (BOOL)snapPicture:(NSString *)filePath;

/**
 开始录制对方的视频
 
 @param filePath 本地存储的地址＋视频名称
 */
- (BOOL)startRecordVideo:(NSString *)filePath;

/**
 停止录制对方的视频
 */
- (void)stopRecordVideo;

#pragma mark -　本地视频设置操作

/**
 设置本地音频是否传输
 
 @param enable YES为传输音频，NO为不传输音频，默认音频传输
 */
- (void)setLocalAudioEnable:(BOOL)enable;

/**
 设置本地视频是否传输
 
 @param enable YES为传输视频，NO为不传输视频，默认视频传输
 
 */
- (void)setLocalVideoEnable:(BOOL)enable;

/**
 切换前后摄像头
 */
- (void)switchCamera;

/**
 设置扬声器开关
 
 @param on YES打开扬声器，NO关闭扬声器，默认扬声器打开
 */
- (void)setSpeakerOn:(BOOL)on;

#pragma mark - 清空会话
/**
 清空会话
 
 说明：当别人挂断或者自己挂断离开的时候，调用该方法用于清空本地视频。
 */
- (void)close;

@end

NS_ASSUME_NONNULL_END

