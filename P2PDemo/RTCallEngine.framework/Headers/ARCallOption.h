//
//  ARCallOption.h
//  RTCallEngine
//
//  Created by zjq on 2019/3/18.
//  Copyright © 2019 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARObjects.h"
#import "ARCallEnum.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 音视频配置项
@interface ARCallOption : NSObject

/**
 使用默认配置生成一个 ARCallOption 对象
 
 @return ARCallOption 对象
 */
+ (nonnull ARCallOption *)defaultOption;

/**
 视频配置项
 */
@property (nonatomic, strong) ARVideoConfig *videoConfig;

/**
 设置相机类型
 说明：根据自己的需求，选择相应的相机类型;默认ARCameraTypeNomal
 */
@property (nonatomic, nonatomic) ARCameraType cameraType;

@end

#pragma mark 

#pragma mark - 呼叫群组配置项

@interface ARGroupOption : NSObject
/**
 使用默认配置生成一个 ARGroupOption 对象
 
 @return ARGroupOption 对象
 */
+ (nonnull ARGroupOption *)defaultOption;

/**
 呼叫用户Id的数组
 */
@property (nonatomic, strong) NSArray *userArray;

/**
 扩展信息
 */
@property (nonatomic, strong) NSString *extend;

@end

#pragma mark - 呼叫个人配置

@interface ARUserOption : NSObject
/**
 使用默认配置生成一个 ARUserOption 对象
 
 @return ARUserOption 对象
 */
+ (nonnull ARUserOption *)defaultOption;

/**
 呼叫类型：默认AR_Call_Video，可选 AR_Call_VideoPro,AR_Call_Audio,AR_Call_VideoMonitor
 */
@property (nonatomic, assign) ARCallMode callMode;

@end

#pragma mark - 客服配置项

@interface ARClertOption : NSObject
/**
 使用默认配置生成一个 ARClertOption 对象
 
 @return ARClertOption 对象
 */

+ (nonnull ARClertOption *)defaultOption;

/**
 等级：0~: 0等级最大，值越大，等级越小
 */
@property (nonatomic, assign) int level;

/**
 区域设定;如果不设定，该频道下的所有客服都能为其服务
 */
@property (nonatomic, strong) NSString *area;

/**
 交易类型
 */
@property (nonatomic, strong) NSString *business;


@end


#pragma mark - 排队呼叫配置项

@interface ARQueueOption : NSObject

/**
 使用默认配置生成一个 ARQueueOption 对象

 @return ARQueueOption 对象
 */
+ (nonnull ARQueueOption *)defaultOption;

/**
 呼叫类型：默认AR_Call_Cti_Video，可选 AR_Call_Cti_Audio
 */
@property (nonatomic, assign) ARCallMode callMode;

/**
 等级：0~20: 0等级最大，值越大，等级越小
 */
@property (nonatomic, assign) int level;

/**
 区域设定;如果不设定，该频道下的所有客服都能为其服务
 */
@property (nonatomic, strong) NSString *area;

/**
 交易类型，保持与客服一致
 */
@property (nonatomic, strong) NSString *business;
@end


NS_ASSUME_NONNULL_END
