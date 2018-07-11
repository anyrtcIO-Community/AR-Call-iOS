//
//  ATNetWorkTool.h
//  P2PDemo
//
//  Created by jh on 2017/11/20.
//  Copyright © 2017年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define TIMEOUT 10.0f

#define requestUrl @"http://api.p2p.teameeting.cn:3663/"

typedef void(^SucessBlock)(NSDictionary * dict);

@interface ATNetWorkTool : NSObject

+ (ATNetWorkTool *)sharedManager;

//发送验证码
- (void)postSendVercode:(NSDictionary *)info url:(NSString *)url successBlock:(SucessBlock)successBlock;

//验证短信验证码
- (void)postCheckVercode:(NSDictionary *)info url:(NSString *)url successBlock:(SucessBlock)successBlock;

@end
