//
//  ATCallView.h
//  P2PDemo
//
//  Created by jh on 2017/11/6.
//  Copyright © 2017年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBlock)(NSInteger tag);

@interface ATCallView : UIView

//接听
@property (weak, nonatomic) IBOutlet UIButton *answerButton;

//挂断
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hangY;

//会叫id
@property (weak, nonatomic) IBOutlet UILabel *peerLabel;

//信息
@property (weak, nonatomic) IBOutlet ATLabel *infoLabel;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

//优先显示
@property (weak, nonatomic) IBOutlet UIView *proView;

@property (nonatomic, copy)CallBlock callBlock;

- (void)changeTimeMeterStart;

- (void)changProVideoState:(BOOL)isShow;

@end
