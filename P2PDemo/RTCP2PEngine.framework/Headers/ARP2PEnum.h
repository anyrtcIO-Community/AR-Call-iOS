//
//  ARP2PEnum.h
//  RTCP2PEngine
//
//  Created by zjq on 2019/1/16.
//  Copyright © 2019 derek. All rights reserved.
//

#ifndef ARP2PEnum_h
#define ARP2PEnum_h
#import "ARCommonEnum.h"

typedef NS_ENUM(NSInteger,ARP2PCode) {
    ARP2P_OK = 0,                       // 正常
    ARP2P_UNKNOW = 1,                   // 未知错误
    ARP2P_EXCEPTION = 2,                // SDK调用异常
    ARP2P_EXP_UNINIT = 3,               // SDK未初始化
    ARP2P_EXP_PARAMS_INVALIDE = 4,      // 参数非法
    ARP2P_EXP_NO_NETWORK = 5,           // 没有网络链接
    ARP2P_EXP_NOT_FOUND_CAMERA = 6,     // 没有找到摄像头设备
    ARP2P_EXP_NO_CAMERA_PERMISSION = 7, // 没有打开摄像头权限
    ARP2P_EXP_NO_AUDIO_PERMISSION = 8,  // 没有音频录音权限
    ARP2P_EXP_NOT_SUPPORT_WEBRTC = 9,   // 浏览器不支持原生的webrtc
    
    
    ARP2P_NET_ERR = 100,                // 网络错误
    ARP2P_NET_DISSCONNECT = 101,        // 网络断开
    ARP2P_LIVE_ERR    = 102,            // 直播出错
    ARP2P_EXP_ERR = 103,                // 异常错误
    ARP2P_EXP_Unauthorized = 104,       // 服务未授权(仅可能出现在私有云项目)
    
    ARP2P_BAD_REQ = 201,                // 服务不支持的错误请求
    ARP2P_AUTH_FAIL = 202,              // 认证失败
    ARP2P_NO_USER = 203,                // 此开发者信息不存在
    ARP2P_SVR_ERR = 204,                // 服务器内部错误
    ARP2P_SQL_ERR = 205,                // 服务器内部数据库错误
    ARP2P_ARREARS = 206,                // 账号欠费
    ARP2P_LOCKED = 207,                 // 账号被锁定
    ARP2P_SERVER_NOT_OPEN = 208,        // 服务未开通
    ARP2P_ALLOC_NO_RES = 209,           // 没有服务器资源
    ARP2P_SERVER_NOT_SURPPORT = 210,    //不支持的服务
    ARP2P_FORCE_EXIT = 211,             // 强制离开
    
    ARP2P_PEER_BUSY = 800,          // 对方正忙
    ARP2P_OFFLINE,                  // 对方不在线
    ARP2P_NOT_SELF,                 // 不能呼叫自己
    ARP2P_EXP_OFFLINE,              // 通话中对方意外掉线
    ARP2P_EXP_EXIT,                 // 对方异常导致(如：重复登录帐号将此前的帐号踢出)
    ARP2P_TIMEOUT,                  // 呼叫超时(45秒)
    ARP2P_NOT_SURPPORT,             // 不支持
    
};
typedef NS_ENUM(NSInteger,ARP2PCallModel) {
    ARP2P_Call_Video = 0,         //    默认视频呼叫
    ARP2P_Call_VideoPro = 1,      //    视频呼叫Pro模式: 被呼叫方可先看到对方视频
    ARP2P_Call_Audio = 2,         //    音频呼叫
    ARP2P_Call_VideoMonitor = 3   //    视频监看模式,此模式被叫端只能是Android
};
#endif /* ARP2PEnum_h */
