//
//  ARCallEnum.h
//  RTCallEngine
//
//  Created by zjq on 2019/3/18.
//  Copyright © 2019 zjq. All rights reserved.
//

#ifndef ARCallEnum_h
#define ARCallEnum_h

typedef NS_ENUM(NSInteger,ARCallMode) {
    //----------P2P------------
    //* 被叫接听 发送Offer =>  主叫
    AR_Call_Video = 0,         //    默认视频呼叫
    //* 主叫主动 发送Offer =>  被叫
    AR_Call_VideoPro = 1,      //    视频呼叫Pro模式: 被呼叫方可先看到对方视频
    //* 被叫接听 发送Offer =>  主叫
    AR_Call_Audio = 2,         //    音频呼叫
    //* 被叫接听 发送Offer =>  主叫
    AR_Call_VideoMonitor = 3,   //    视频监看模式,此模式被叫端只能是Android
    //----------Meet------------
    //* 会议邀请，可以同时邀请多人
    AR_Call_Meet_Invite = 10,  //     邀请参加视频会议
    //----------Call Center------------
    //* 呼叫中心音频
    AR_Call_Cti_Audio = 20,  //     音频呼叫客服
    //* 呼叫中心视频
    AR_Call_Cti_Video = 21,  //     视频呼叫客服
};

//Meet模式
typedef NS_ENUM(NSInteger,ARCallZoomType){
    ARCallZoomTypeNomal = 0,   // 一般模式:分屏显示模式
    ARCallZoomTypeSingle = 1,  // 单显示模式:语音激励模式
    ARCallZoomTypeDriver = 2,  // 驾驶模式:只接受音频:此时自己设置音视频是否传输
};

typedef NS_ENUM(NSInteger,ARCallCode) {
    ARCall_OK = 0,                       // 正常
    ARCall_UNKNOW = 1,                   // 未知错误
    ARCall_EXCEPTION = 2,                // SDK调用异常
    ARCall_EXP_UNINIT = 3,               // SDK未初始化
    ARCall_EXP_PARAMS_INVALIDE = 4,      // 参数非法
    ARCall_EXP_NO_NETWORK = 5,           // 没有网络链接
    ARCall_EXP_NOT_FOUND_CAMERA = 6,     // 没有找到摄像头设备
    ARCall_EXP_NO_CAMERA_PERMISSION = 7, // 没有打开摄像头权限
    ARCall_EXP_NO_AUDIO_PERMISSION = 8,  // 没有音频录音权限
    ARCall_EXP_NOT_SUPPORT_WEBRTC = 9,   // 浏览器不支持原生的webrtc
    
    
    ARCall_NET_ERR = 100,                // 网络错误
    ARCall_NET_DISSCONNECT = 101,        // 网络断开
    ARCall_LIVE_ERR    = 102,            // 直播出错
    ARCall_EXP_ERR = 103,                // 异常错误
    ARCall_EXP_Unauthorized = 104,       // 服务未授权(仅可能出现在私有云项目)
    
    ARCall_BAD_REQ = 201,                // 服务不支持的错误请求
    ARCall_AUTH_FAIL = 202,              // 认证失败
    ARCall_NO_USER = 203,                // 此开发者信息不存在
    ARCall_SVR_ERR = 204,                // 服务器内部错误
    ARCall_SQL_ERR = 205,                // 服务器内部数据库错误
    ARCall_ARREARS = 206,                // 账号欠费
    ARCall_LOCKED = 207,                 // 账号被锁定
    ARCall_SERVER_NOT_OPEN = 208,        // 服务未开通
    ARCall_ALLOC_NO_RES = 209,           // 没有服务器资源
    ARCall_SERVER_NOT_SURPPORT = 210,    // 不支持的服务
    ARCall_FORCE_EXIT = 211,             // 强制离开
    ARCall_AUTH_TIMEOUT = 212,           // 验证超时
    ARCall_NEED_VERTIFY_TOKEN = 213,     // 需要验证userToken
    ARCall_WEB_DOMIAN_ERROR = 214,       // Web应用的域名验证失败
    ARCall_IOS_BUNDLE_ID_ERROR = 215,    // iOS应用的BundleId验证失败
    ARCall_ANDROID_PKG_NAME_ERROR = 216, // Android应用的包名验证失败
    
    ARCall_PEER_BUSY = 800,              // 对方正忙
    ARCall_OFFLINE = 801,                // 对方不在线
    ARCall_NOT_SELF = 802,               // 不能呼叫自己
    ARCall_EXP_OFFLINE = 803,            // 通话中对方意外掉线
    ARCall_EXP_EXIT = 804,               // 对方异常导致(如：重复登录帐号将此前的帐号踢出)
    ARCall_TIMEOUT = 805,                // 呼叫超时(45秒)
    ARCall_NOT_SURPPORT = 806,           // 不支持
};


#endif /* ARCallEnum_h */
