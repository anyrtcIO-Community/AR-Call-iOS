//
//  ARCallKit.h
//  RTCallEngine
//
//  Created by zjq on 2019/3/18.
//  Copyright © 2019 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCallKitDelegate.h"
#import <UIKit/UIKit.h>
#import "ARCallOption.h"
#import "ARCallEnum.h"


NS_ASSUME_NONNULL_BEGIN

@interface ARCallKit : NSObject

/**
 实例化Call对象
 
 @param delegate RTC相关回调代理
 @return Call对象
 */
- (instancetype)initWithDelegate:(id <ARCallKitDelegate>)delegate;

/**
 事件代理
 */
@property (nonatomic, weak) id <ARCallKitDelegate> callDelegate;

#pragma mark - 设置客服/上下线

/**
 设置客服(放在turnOn之前)
 
 @param queueId 队列Id
 @param option 客服配置
 */
- (void)setAsClerk:(NSString*)queueId option:(ARClertOption*)option;

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


/**
 挂起:挂起后将不再接收呼叫

 @param enable YES/NO:挂起与否
 */
- (void)setAvalible:(BOOL)enable;

#pragma mark - 本地和远程视频预览
/**
 设置本地显示窗口
 
 @param render 本地视频窗口
 @param option 配置项
 说明：必须放到 makeCall方法之后调用
 */
- (void)setLocalVideoCapturer:(UIView *)render option:(ARCallOption*)option;

/**
 设置滤镜
 
 @param filter 滤镜模式
 说明：只有使用美颜相机模式才有用。
 */
- (void)setCameraFilter:(ARCameraFilterMode)filter;

/**
 设置其他视频显示窗口
 
 @param render 视频显示窗口
 @param renderId 渲染Id
 */
- (void)setRemoteVideoRender:(UIView *)render renderId:(NSString *)renderId;

/**
 设置某个人的显示模式
 
 @param renderMode 显示模式，默认ARVideoRenderScaleToFill，等比例填充视图模式
 @param renderId 渲染Id
 */
- (void)updateRTCVideoRenderModel:(ARVideoRenderMode)renderMode renderId:(NSString *)renderId;

#pragma mark - 呼叫相关
/**
 呼叫用户
 
 @param userId 呼叫的用户Id
 @param option 配置项
 
 @return 操作是否成功。0：成功;-1:操作频繁;-2：不能呼叫自己;-3：呼叫列表不能为空;-4：呼叫session已存在;-5：呼叫ID不能为空:-6：userData:超过1024个字节:-7:   ARCallKit还未初始化
 */
- (int)makeCallUser:(NSString *)userId option:(ARUserOption*)option;


/**
 呼叫群组（AR_Call_Meet_Invite类型）

 @param groupId 群组Id
 @param option 配置项
 
 @return 操作是否成功 0：成功;-1:操作频繁;-2：不能呼叫自己;-3：呼叫列表不能为空;-4：呼叫session已存在;-5：呼叫ID不能为空:-6：userData:超过1024个字节:-7:ARCallKit还未初始化
 */
- (int)makeCallGroup:(NSString *)groupId option:(ARGroupOption*)option;

/**
 呼叫客服

 @param queueId 队列
 @param option 呼叫配置
 @return 操作是否成功 0：成功;-1:操作频繁;-2：不能呼叫自己;-3：呼叫列表不能为空;-4：呼叫session已存在;-5：呼叫ID不能为空:-6：userData:超过1024个字节:-7:ARCallKit还未初始化
 */
- (int)makeCallQueue:(NSString *)queueId option:(ARQueueOption*)option;

/**
 邀请用户(只有建立会议呼叫之后才能调用)

 @param userId 用户Id
 
 @return 操作是否成功 0：成功; -1:userId为空;-2：不是会议类型不能调用;-3：ARCallKit还未初始化;
 */
- (int)inviteCall:(NSString*)userId;

/**
 挂断通话
 
 @param userId 呼叫的用户Id
 */
- (void)endCall:(NSString *)userId;

/**
 同意通话(被叫调用)
 
 @param userId 呼叫的用户Id
 */
- (void)acceptCall:(NSString *)userId;

/**
 拒绝通话(被叫调用)
 
 @param userId 呼叫的用户Id
 */
- (void)rejectCall:(NSString *)userId;

/**
 转呼手机
 说明：呼叫用户的时候才能用；如果呼叫模式为视频会自动转为音频模式
 */
- (void)switchToPstn;

/**
 转呼座机
 说明：呼叫用户的时候才能用，如果呼叫模式为视频会自动转为音频模式
 */
- (void)switchToExtension;

#pragma mark - RTC方法

/**
 切换音频模式
 
 @return 操作是否成功。成功之后，把本地视频视图清除掉
 */
- (BOOL)swithToAudioMode;

/**
 发送消息
 
 @param content 发送消息的内容(限制1024字节)
 */
- (void)sendUserMessage:(NSString *)content;

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
 获取本地音频传输是否打开
 
 @return 音频是否传输
 */
- (BOOL)localAudioEnabled;

/**
 获取本地视频传输是否打开
 
 @return 视频是否传输
 */
- (BOOL)localVideoEnabled;

/**
 切换前后摄像头
 */
- (void)switchCamera;

/**
 设置扬声器开关
 
 @param on YES打开扬声器，NO关闭扬声器，默认扬声器打开
 */
- (void)setSpeakerOn:(BOOL)on;

/**
 获取人员列表
 
 @return 人员列表
 */
- (NSArray<ARUserItem *> *)getUserList;

/**
 抓图

 @param userId 用户Id
 @return 图片
 */
- (UIImage*)snapPicture:(NSString*)userId;

#pragma mark - meet
/**
 设置会议模式

 @param type 模式类型
 @return 设置会议模式
 */
- (BOOL)setCallZoomMode:(ARCallZoomType)type;

/**
 设置显示页码
 
 @param page 页码（从0开始，每页加上自己的视频流为4路）
 @return 操作是否成功
 */
- (BOOL)setCallZoomPage:(int)page;


#pragma mark - 清空会话
/**
 清空会话
 
 说明：当别人挂断或者自己挂断离开的时候，调用该方法用于清空本地视频。
 */
- (void)close;


@end

NS_ASSUME_NONNULL_END
