//
//  ATCallView.m
//  P2PDemo
//
//  Created by jh on 2017/11/6.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATCallView.h"

@implementation ATCallView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)changeTimeMeterStart{
    self.answerButton.hidden = YES;
    self.hangY.constant = 0;
    [self.infoLabel timeMeterStart:@"等待对方接听..."];
}

- (void)changProVideoState:(BOOL)isShow{
    if (!isShow) {
        self.answerButton.hidden = YES;
        self.infoLabel.text = @"正在加载对方视频...";
        self.hangY.constant = 0;
    } else {
        self.answerButton.hidden = NO;
        self.infoLabel.text = @"视频优先通话...";
        self.hangY.constant = 80;
    }
}

- (IBAction)callResult:(UIButton *)sender {
    if (self.answerButton.hidden) {
        //呼叫挂断
        self.callBlock(102);
        return;
    }
    
    if (self.callBlock) {
        self.callBlock(sender.tag);
    }
}


@end
