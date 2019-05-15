//
//  ARCommonEnum.h
//  RTCLib
//
//  Created by zjq on 2019/1/15.
//  Copyright © 2019 MaoZongWu. All rights reserved.
//

#ifndef ARCommonEnum_h
#define ARCommonEnum_h

// 网络质量
typedef NS_ENUM(NSInteger,ARNetQuality) {
    ARNetQualityExcellent = 1, // 优
    ARNetQualityGood,          // 良好
    ARNetQualityAccepted,      // 中等
    ARNetQualityBad,           // 差
    ARNetQualityVBad,          // 极差
};

// 分辨率
typedef NS_ENUM(NSInteger, ARVideoProfile) {
    //120P
    ARVideoProfile120x160 = 0,        // 120x160
    ARVideoProfile120x120 = 1,        // 120x120
    //180P
    ARVideoProfile180x320 = 2,        // 180x320
    ARVideoProfile180x180 = 3,        // 180x180
    ARVideoProfile180x240 = 4,        // 180x240
    //240P
    ARVideoProfile240x320 = 5,        // 240x320
    ARVideoProfile240x240 = 6,        // 240x240
    ARVideoProfile240x424 = 7,        // 240x424
    //360P
    ARVideoProfile360x640 = 8,        // 360x640
    ARVideoProfile360x360 = 9,        // 360x360
    ARVideoProfile360x480 = 10,       // 360x480
    //480P
    ARVideoProfile480x640 = 11,       // 480x640
    ARVideoProfile480x480 = 12,       // 480x480
    ARVideoProfile480x848 = 13,       // 480x848
    //720P
    ARVideoProfile720x960 = 14,       // 720x960
    ARVideoProfile720x1280 = 15,      // 720x1280
    //1080P
    ARVideoProfile1080x1920 = 16,     // 1080x1920
#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))
    //1440P
    ARVideoProfile1440x2560 = 17,     // 1440x2560
    //4k
    ARVideoProfile2160x3840 = 18,     // 2160x3840
#endif
};
//帧率
typedef NS_ENUM(NSInteger, ARVideoFrameRate) {
    /** 1 fps. */
    ARVideoFrameRateFps1 = 1,
    /** 7 fps. */
    ARVideoFrameRateFps7 = 2,
    /** 10 fps. */
    ARVideoFrameRateFps10 = 3,
    /** 15 fps. */
    ARVideoFrameRateFps15 = 4,
    /** 20 fps. */
    ARVideoFrameRateFps20 = 5,
    /** 24 fps. */
    ARVideoFrameRateFps24 = 6,
    /** 30 fps. */
    ARVideoFrameRateFps30 = 7,
    /** 60 fps. */
    ARVideoFrameRateFps60 = 8,
};

// 方向
typedef NS_ENUM(NSInteger, ARCameraOrientation){
    ARCameraPortrait = 0,
    ARCameraLandscapeRight,
    ARCameraPortraitUpsideDown,
    ARCameraLandscapeLeft,
    ARCameraAuto
};

// 日志级别
typedef NS_ENUM(NSInteger, ARLogModel){
    ARLogModelNone = 0,
    ARLogModelInfo,
    ARLogModelWarning,
    ARLogModelError
};

// 相机类型
typedef NS_ENUM(NSInteger, ARCameraType){
    ARCameraTypeNomal = 0,
    ARCameraTypeBeauty
};

// 视频填充模式
typedef NS_ENUM(NSInteger, ARVideoRenderMode){
    //表示按比例缩放并且填满view，意味着图片可能超出view，可能被裁减掉
    ARVideoRenderScaleAspectFill = 0,
    //表示通过缩放来填满view，也就是说图片会变形
    ARVideoRenderScaleToFill,
    //表示按比例缩放并且图片要完全显示出来，意味着view可能会留有空白
    ARVideoRenderScaleAspectFit
};

// 滤镜(美颜相机用)
typedef NS_ENUM(NSInteger, ARCameraFilterMode){
    //美颜滤镜
    ARCameraFilterBeautiful=0,
    //原始
    ARCameraFilterOriginal,
    //高斯模糊
    ARCameraFilterGaussianBlur
};

#endif /* ARCommonEnum_h */
