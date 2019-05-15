//
//  ARP2POption.h
//  RTCP2PEngine
//
//  Created by zjq on 2019/1/16.
//  Copyright © 2019 derek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARObjects.h"

NS_ASSUME_NONNULL_BEGIN

@interface ARP2POption : NSObject

/**
 使用默认配置生成一个 ARP2POption 对象
 
 @return 生成的 ARP2POption 对象
 */
+ (nonnull ARP2POption *)defaultOption;

/**
 设置相机类型
 说明：根据自己的需求，选择相应的相机类型;默认ARCameraTypeNomal
 */
@property (nonatomic, assign) ARCameraType cameraType;

/**
 视频配置项
 */
@property (nonatomic, strong) ARVideoConfig *videoConfig;

@end

NS_ASSUME_NONNULL_END
