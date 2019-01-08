//
//  ATHistoryCell.m
//  P2PDemo
//
//  Created by jh on 2017/11/8.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATHistoryCell.h"

@implementation ATHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHistoryModel:(ATHistoryModel *)historyModel{
    self.phoneLabel.text = historyModel.phoneStr;
    NSString *callModeStr;
    switch (historyModel.callMode) {
        case RTP2P_CALL_Video:
            callModeStr = @"视频通话";
            break;
        case RTP2P_CALL_VideoPro:
            callModeStr = @"视频优先通话";
            break;
        case RTP2P_CALL_Audio:
            callModeStr = @"音频通话";
            break;
        case RTP2P_CALL_VideoMon:
            callModeStr = @"视频监看";
            break;
        default:
            break;
    }
    
    self.phoneLabel.textColor = [UIColor blackColor];
    if ([historyModel.state isEqualToString:@"未接通话"]) {
        self.phoneLabel.textColor = [UIColor redColor];
    }
    
    self.modeLabel.text = [NSString stringWithFormat:@"%@ - %@ ",callModeStr,historyModel.state];
    self.timeLabel.text = [NSString stringWithFormat:@"时长 %@",[ATCommon getMMSSFromSS:historyModel.timer]];
    
    NSLog(@"%@---",historyModel.date);
    //通话日期
    self.dateLabel.text = [ATCommon timeFormatted:historyModel.date];
}

@end
