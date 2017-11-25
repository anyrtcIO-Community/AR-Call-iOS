//
//  ATHistoryTool.m
//  P2PDemo
//
//  Created by jh on 2017/11/8.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATHistoryTool.h"


@implementation ATHistoryTool

static FMDatabase *_historydb;
static NSDate *_date;
+ (void)initialize{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.sqlite"];
    
    _historydb = [FMDatabase databaseWithPath:path];
    BOOL res = [_historydb open];
    
    if (res == NO) {
        NSLog(@"数据库打开失败");
    }
    [_historydb executeUpdate:@"CREATE TABLE IF NOT EXISTS t_history (id integer PRIMARY KEY, modelData text ,date text)"];//通话时间
    
    [_historydb close];
}

//保存历史记录
+(void)saveHistoryWithMainModel:(ATHistoryModel *)model{
    BOOL open = [_historydb open];
    
    if (open) {
        NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:model];
        [_historydb executeUpdateWithFormat:@"INSERT INTO t_history(modelData,date) VALUES(%@,%@);",modelData,model.date];
        [_historydb close];
    }
}

//获取所有本地数据库数据
+(NSMutableArray *)getAllHistoryList{
    BOOL open = [_historydb open];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if (open) {
        //降序
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_history order by id desc"];
        FMResultSet *set = [_historydb executeQuery:sql];
        if (set) {
            while (set.next) {
                NSData *data = [set objectForColumnName:@"modelData"];
                ATHistoryModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [arr addObject:model];
            }
        }
        [_historydb close];
    }
    return arr;
}

//删除通话记录
+ (void)removeHistoryData:(NSString *)date{
    BOOL open = [_historydb open];
    if (open) {
        NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM t_history where date = '%@'",date];
        [_historydb executeUpdate:deleteSql];
        [_historydb close];
    }
}

//删除表中所有数据
+(void)removeAllObject{
    BOOL open = [_historydb open];
    if (open) {
        [_historydb executeUpdate:@"DELETE FROM t_history"];
        [_historydb close];
    }
}

@end
