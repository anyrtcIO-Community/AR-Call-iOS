//
//  ATHistoryTool.h
//  P2PDemo
//
//  Created by jh on 2017/11/8.
//  Copyright © 2017年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATHistoryModel.h"

@interface ATHistoryTool : NSObject

//保存历史记录
+(void)saveHistoryWithMainModel:(ATHistoryModel *)model;

//获取所有本地数据库数据
+(NSMutableArray *)getAllHistoryList;

//删除通话记录
+ (void)removeHistoryData:(NSString *)date;

//删除表中所有数据
+(void)removeAllObject;

@end
