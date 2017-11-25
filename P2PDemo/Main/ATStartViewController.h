//
//  ATStartViewController.h
//  P2PDemo
//
//  Created by jh on 2017/11/3.
//  Copyright © 2017年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATStartViewController : UIViewController

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) ATMainViewController *mainVc;

@property (weak, nonatomic) IBOutlet UIButton *headButton;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@property (nonatomic, assign) BOOL isOn;

@end
