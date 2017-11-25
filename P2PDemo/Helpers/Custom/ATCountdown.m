//
//  ATCountdown.m
//  MeditationVideo
//
//  Created by 1 on 2017/4/5.
//  Copyright © 2017年 jh. All rights reserved.
//倒计时按钮

#import "ATCountdown.h"

@interface ATCountdown ()

@end

@implementation ATCountdown

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.backgroundColor = [UIColor clearColor];
}

- (void)timeFailBeginFrom:(NSInteger)timeCount {
    self.enabled = NO;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行一次
    
    NSTimeInterval seconds = timeCount;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds]; // 最后期限
    
    dispatch_source_set_event_handler(_timer, ^{
        int interval = [endTime timeIntervalSinceNow];
        if (interval > 0) { // 更新倒计时
            NSString *timeStr = [NSString stringWithFormat:@"%d秒后重发", interval];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = NO;
                [self setTitle:timeStr forState:UIControlStateNormal];
                [self sizeToFit];
            });
        } else { // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self sizeToFit];
            });
        }
    });
    dispatch_resume(_timer);
}

@end
