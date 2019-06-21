//
//  ArContactCallView.h
//  ContactsCall
//
//  Created by 余生丶 on 2019/3/25.
//  Copyright © 2019 Ar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArTimeLable.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CallDelegate<NSObject>

- (void)handleWithUserId:(NSString *)userId tag:(NSInteger)tag status:(BOOL)selected;

@end

@interface ArContactCallView : UIView

@property (weak, nonatomic) IBOutlet ArTimeLable *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *localView;
@property (weak, nonatomic) IBOutlet UIView *renderView;
@property (weak, nonatomic) IBOutlet UIView *containerView;


@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) ArCallStatus callStatus;
@property (nonatomic, weak) id<CallDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
