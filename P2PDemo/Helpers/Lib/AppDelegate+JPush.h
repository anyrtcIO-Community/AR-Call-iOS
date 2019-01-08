//
//  AppDelegate+JPush.h
//  P2PDemo
//
//  Created by jh on 2017/11/2.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "AppDelegate.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate (JPush)<JPUSHRegisterDelegate>

//注册极光推送
- (void)registerPush:(NSDictionary *)launchOptions;

//更改角标
- (void)changeBadgeNumber;

@end
