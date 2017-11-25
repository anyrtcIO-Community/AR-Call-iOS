//
//  RTCP2POption.h
//  RTCP2PEngine
//
//  Created by derek on 2017/10/30.
//  Copyright © 2017年 derek. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum RTCP2PVideosMode
{
    RTCP2P_Videos_HD = 0,    //* 1280*720 - 1024kbps
    RTCP2P_Videos_QHD,       //* 960*540 - 768kbps
    RTCP2P_Videos_SD,        //* 640*480 - 512kbps
    RTCP2P_Videos_Low        //* 352*288 - 384kbps
}RTCP2PVideosMode;


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
 设置视频分辨率
 说明：默认为：RTCP2P_Videos_SD
 */
@property (nonatomic, assign) RTCP2PVideosMode videoMode;

@end
