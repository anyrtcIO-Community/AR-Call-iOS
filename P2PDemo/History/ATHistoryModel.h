//
//  ATHistoryModel.h
//  P2PDemo
//
//  Created by jh on 2017/11/8.
//  Copyright © 2017年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATHistoryModel : NSObject<NSCoding>

//手机号（呼叫ID）
@property (nonatomic, copy)NSString *phoneStr;

//通话时长
@property (nonatomic, copy)NSString *timer;

//呼叫日期
@property (nonatomic, copy)NSString *date;

//呼叫类型
@property (nonatomic, assign)int callMode;

//呼叫状态 已接通话 未接通话 拒接电话
@property (nonatomic, copy)NSString *state;

@end


