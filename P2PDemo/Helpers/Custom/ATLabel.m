//
//  ATLabel.m
//  P2PDemo
//
//  Created by jh on 2017/11/3.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATLabel.h"

@interface ATLabel ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation ATLabel

- (void)timeMeterStart:(NSString *)infoStr{
    self.textAlignment = NSTextAlignmentCenter;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行一次
    
    NSDate *endTime = [NSDate date];
    
    WEAKSELF;
    dispatch_source_set_event_handler(self.timer, ^{
        //开始连麦的时间与现在时间的差
        int interval = [endTime timeIntervalSinceNow];
        NSString *timeStr = [NSString stringWithFormat:@"%@\n %@",infoStr,[ATCommon getMMSSFromSS:[NSString stringWithFormat:@"%d",abs(interval)]]];

        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.text = timeStr;
            
        });
    });
    dispatch_resume(self.timer);
}


- (void)timeMeterEnd{
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

@end
