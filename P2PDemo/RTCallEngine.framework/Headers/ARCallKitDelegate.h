//
//  ARCallKitDelegate.h
//  RTCallEngine
//
//  Created by zjq on 2019/3/18.
//  Copyright © 2019 zjq. All rights reserved.
//

#ifndef ARCallKitDelegate_h
#define ARCallKitDelegate_h
#import "ARCallEnum.h"
#import <UIKit/UIKit.h>

@protocol ARCallKitDelegate <NSObject>

#pragma mark - 服务状态
/**
 服务器链接成功
 */
- (void)onRTCConnected;

/**
 服务器断开
 
 @param code 状态码
 */
- (void)onRTCDisconnect:(ARCallCode)code;

#pragma mark - 呼叫状态
/**
 收到呼叫的回调
 
 @param meetId 会议Id,当AR_Call_Meet_Invite类型的时候，该参数为空
 @param userId 呼叫方的Id
 @param userData 呼叫方的自定义信息
 @param callMode 呼叫类型
 @param extend 扩展信息，用户自定义,呼叫群组的时候带的
 */
- (void)onRTCMakeCall:(NSString *)meetId userId:(NSString *)userId userData:(NSString *)userData callModel:(ARCallMode)callMode extend:(NSString*)extend;

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
- (void)onRTCRejectCall:(NSString *)userId code:(ARCallCode)code;

/**
 收到对方挂断的回调
 
 @param userId 用户id
 @param code 状态码
 */
- (void)onRTCEndCall:(NSString *)userId code:(ARCallCode)code;

#pragma mark - 音视频流
/**
 收到对方视频视频即将显示的回调
 
 @param userId 呼叫的用户Id
 @param renderId 渲染Id
 @param userData 用户信息
 说明：收到该回调，调用setRemoteVideoRender显示对方视频窗口
 */
- (void)onRTCOpenRemoteVideoRender:(NSString *)userId renderId:(NSString*)renderId userData:(NSString*)userData;

/**
 收到对方视频离开的回调
 
 @param userId 呼叫的用户Id
 @param renderId 渲染Id
 */
- (void)onRTCCloseRemoteVideoRender:(NSString *)userId  renderId:(NSString*)renderId;


/**
 收到对方音频即将播放的回调
 
 @param userId 用户Id
 @param userData 用户信息
 */
- (void)onRTCOpenRemoteAudioTrack:(NSString *)userId userData:(NSString *)userData;

/**
  收到对方音频离开的回调
 
 @param userId 用户Id
 */
- (void)onRTCCloseRemoteAudioTrack:(NSString *)userId;

#pragma mark - SIP转呼/音视频模式切换/IM
/**
 是否支持SIP呼叫

 @param pstn YES:可转接手机，用户调用switchToPstn即可去呼叫手机
 @param extension YES:转接分机，用户调用switchToExtension即可去呼叫分机
 @param null 暂时可不用
 */
- (void)onRTCSipSupport:(BOOL)pstn extension:(BOOL)extension null:(BOOL)null;

/**
 切换到音频模式
 说明：收到该回调，做视频视图的清理工作
 */
- (void)onRTCSwithToAudioMode;

/**
 收到消息回调
 
 @param userId 发送消息的用户Id
 @param content 消息内容
 */
- (void)onRTCUserMessage:(NSString *)userId message:(NSString *)content;


#pragma mark - 音视频状态回调

/**
 其他与会者对音视频的操作
 
 @param userId 用户Id
 @param audio YES为打开音频，NO为关闭音频
 @param video YES为打开视频，NO为关闭视频
 */
- (void)onRTCRemoteAVStatus:(NSString *)userId audio:(BOOL)audio video:(BOOL)video;

/**
 别人对自己音视频的操作
 
 @param audio YES为打开音频，NO为关闭音频
 @param video YES为打开视频，NO为关闭视频
 */
- (void)onRTCLocalAVStatus:(BOOL)audio video:(BOOL)video;

#pragma mark - 视频第一帧的回调、视频大小变化回调

/**
 本地视频第一帧
 
 @param size 视频窗口大小
 */
- (void)onRTCFirstLocalVideoFrame:(CGSize)size;

/**
 远程视频第一帧
 
 @param size 视频窗口大小
 @param renderId 渲染Id (用于标识与会者发布的流)
 */
- (void)onRTCFirstRemoteVideoFrame:(CGSize)size renderId:(NSString *)renderId;

/**
 本地窗口大小的回调
 
 @param size 视频窗口大小
 */
- (void)onRTCLocalVideoViewChanged:(CGSize)size;

/**
 远程窗口大小的回调
 
 @param size 视频窗口大小
 @param renderId 渲染Id (用于标识与会者发布的流)
 */
- (void)onRTCRemoteVideoViewChanged:(CGSize)size renderId:(NSString *)renderId;


#pragma mark - AR_Call_Meet_Invite 模式回调

/**
 会议模式页码变化
 
 @param type 当前模式
 @param allPage 总页码（一页显示4个）
 @param currentPage 当前页
 @param allRenderNum 当前服务上有多少个渲染，根据此数量来判断页码添加删除
 @param index 开始位置
 @param showNum 显示多少个
 */
- (void)onRTCMeetPageInfo:(ARCallZoomType)type
                  allPage:(int)allPage
              currentPage:(int)currentPage
             allRenderNum:(int)allRenderNum
               beginIndex:(int)index
                  showNum:(int)showNum;

#pragma mark - Call Center

/**
 呼叫队列用户的排队信息

 @param queueNum 前面排队人员
 */
- (void) onRTCUserCTIStatus:(int)queueNum;

/**
 服务队列的相关队列信息

 @param queueNum 队列数
 @param allClerk 总客服数
 @param woringNum 正在忙的客服
 */
- (void) onRTCClerkCTIStatus:(int)queueNum clerkNum:(int)allClerk woringClerkNum:(int)woringNum;


@end


#endif /* ARCallKitDelegate_h */
