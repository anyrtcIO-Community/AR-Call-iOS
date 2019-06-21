//
//  ArContactCallView.m
//  ContactsCall
//
//  Created by 余生丶 on 2019/3/25.
//  Copyright © 2019 Ar. All rights reserved.
//

#import "ArContactCallView.h"

@interface ArContactCallView()

@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIButton *audioButton;
@property (weak, nonatomic) IBOutlet UIButton *rejectButton;
@property (weak, nonatomic) IBOutlet UIButton *hangupButton;
@property (weak, nonatomic) IBOutlet UIButton *speakerButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UILabel *userIdLabel;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;

@property (weak, nonatomic) IBOutlet UIStackView *rightStackView;
@property (weak, nonatomic) IBOutlet UIButton *switchButton;
@property (weak, nonatomic) IBOutlet UIButton *snipButton;
@property (weak, nonatomic) IBOutlet UIButton *logButton;

/* 切换大小**/
@property (nonatomic, assign) BOOL isSwitch;
@property (nonatomic, assign) CGRect largeFrame;
@property (nonatomic, assign) CGRect smallFrame;

@end

@implementation ArContactCallView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.rightStackView.hidden = YES;
    self.largeFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    CGFloat widthX = SCREEN_WIDTH * 0.3;
    self.smallFrame = CGRectMake(10, 20, widthX, widthX * 4/3);
    [self switchVideo];
}

- (void)switchVideo {
    [self.localView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
            [self.localView removeGestureRecognizer:obj];
            *stop = YES;
        }
    }];
    
    [self.renderView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
            [self.renderView removeGestureRecognizer:obj];
            *stop = YES;
        }
    }];
    
    self.isSwitch = !self.isSwitch;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchVideo)];
    if (self.isSwitch) {
        [self insertSubview:self.renderView aboveSubview:self.localView];
        self.localView.frame = self.largeFrame;
        self.renderView.frame = self.smallFrame;
        [self.renderView addGestureRecognizer:tap];
    } else {
        [self insertSubview:self.localView aboveSubview:self.renderView];
        self.localView.frame = self.smallFrame;
        self.renderView.frame = self.largeFrame;
        [self.localView addGestureRecognizer:tap];
    }
}

- (void)setUserId:(NSString *)userId {
    _userId = userId;
    self.userIdLabel.text = userId;
}

- (void)layoutSubviews {
    [self.stackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = (UIButton *)obj;
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:20];
    }];
}

- (void)setCallStatus:(ArCallStatus)callStatus {
    _callStatus = callStatus;
    [self.stackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = (UIButton *)obj;
        button.hidden = NO;
    }];
    
    if (callStatus == ArCallStatus_Call) {
        self.rejectButton.hidden = YES;
        self.audioButton.hidden = YES;
        self.speakerButton.hidden = YES;
        self.acceptButton.hidden = YES;
        self.videoButton.hidden = YES;
        self.timeLabel.text = @"等待呼叫中...";
    } else if (callStatus == ArCallStatus_Accept) {
        self.hangupButton.hidden = YES;
        self.audioButton.hidden = YES;
        self.speakerButton.hidden = YES;
        self.videoButton.hidden = YES;
    } else if (callStatus == ArCallStatus_Video){
        self.rejectButton.hidden = YES;
        self.speakerButton.hidden = YES;
        self.acceptButton.hidden = YES;
        self.rightStackView.hidden = NO;
    } else {
        self.rejectButton.hidden = YES;
        self.videoButton.hidden = YES;
        self.acceptButton.hidden = YES;
        self.rightStackView.hidden = NO;
        self.switchButton.hidden = YES;
        self.snipButton.hidden = YES;
    }
    [self layoutSubviews];
}

- (IBAction)handleSomethingEvent:(UIButton *)sender {
    if (sender.tag == 50 || sender.tag == 53 || sender.tag == 54) {
        sender.selected = !sender.selected;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleWithUserId:tag:status:)]) {
        [self.delegate handleWithUserId:self.userId tag:sender.tag status:sender.selected];
    }
}

@end
