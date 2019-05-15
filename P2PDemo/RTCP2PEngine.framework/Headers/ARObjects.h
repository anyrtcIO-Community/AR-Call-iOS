//
//  ARObjects.h
//  RTCLib
//
//  Created by zjq on 2019/1/15.
//  Copyright © 2019 MaoZongWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCommonEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface ARObjects : NSObject

@end

@interface ARVideoConfig : NSObject
/**
 是否是前置摄像头
 说明：默认前置摄像头
 */
@property (nonatomic, assign) BOOL isFont;

/**
 设置视频质量
 
 说明:　默认：ARVideoProfile360x640
 */
@property (nonatomic, assign) ARVideoProfile videoProfile;

/**
 设置视频帧率
 说明：默认：RTMeetVideoFrameRateFps15
 */
@property (nonatomic, assign) ARVideoFrameRate videoFrameRate;

/**
 视频方向：默认：ARCameraPortrait 竖屏
 */
@property (nonatomic, assign) ARCameraOrientation cameraOrientation;

/**
 自动旋转：默认为NO
 说明:设置为YES；这里只支持 left 变 right  portrait 变 portraitUpsideDown
 */
@property (nonatomic, assign) BOOL autorotate;

@end

NS_ASSUME_NONNULL_END
