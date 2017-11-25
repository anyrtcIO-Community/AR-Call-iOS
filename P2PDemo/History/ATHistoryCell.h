//
//  ATHistoryCell.h
//  P2PDemo
//
//  Created by jh on 2017/11/8.
//  Copyright © 2017年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATHistoryCell : UITableViewCell

//手机Id号
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
//通话时长
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//类型状态
@property (weak, nonatomic) IBOutlet UILabel *modeLabel;
//日期
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) ATHistoryModel *historyModel;

@end
