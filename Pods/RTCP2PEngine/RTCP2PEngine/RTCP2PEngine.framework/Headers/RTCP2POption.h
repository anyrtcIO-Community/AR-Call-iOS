//
//  RTCP2POption.h
//  RTCP2PEngine
//
//  Created by derek on 2017/10/30.
//  Copyright © 2017年 derek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTCCommon.h"


@interface RTCP2POption : NSObject
/**
 使用默认配置生成一个 RTCPOption 对象
 
 @return 生成的 RTCPOption 对象
 */
+ (nonnull RTCP2POption *)defaultOption;


/**
 是否是前置摄像头
 说明：默认前置摄像头
 */
@property (nonatomic, assign) BOOL isFont;

/**
 设置视频质量
 AnyRTCVideoQuality_Low1 = 0,      // 320*240 - 128kbps
 AnyRTCVideoQuality_Low2,          // 352*288 - 256kbps
 AnyRTCVideoQuality_Low3,          // 352*288 - 384kbps
 AnyRTCVideoQuality_Medium1,       // 640*480 - 384kbps
 AnyRTCVideoQuality_Medium2,       // 640*480 - 512kbps
 AnyRTCVideoQuality_Medium3,       // 640*480 - 768kbps
 AnyRTCVideoQuality_Height1,       // 960*540 - 768kbps
 AnyRTCVideoQuality_Height2,       // 1280*720 - 1024kbps
 AnyRTCVideoQuality_Height3,       // 1920*1080 - 2048kbps
 
 说明:　默认：AnyRTCVideoQuality_Medium2
 */
@property (nonatomic, assign) AnyRTCVideoQualityModel videoMode;

/**
 设置相机类型
 说明：根据自己的需求，选择相应的相机类型;默认AnyRTCCameraTypeNomal
 */
@property (nonatomic, nonatomic) AnyRTCCameraType cameraType;

@end
