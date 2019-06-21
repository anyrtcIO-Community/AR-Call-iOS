//
//  ArCallViewController.m
//  ArP2PDemo
//
//  Created by 余生丶 on 2019/5/28.
//  Copyright © 2019 anyRTC. All rights reserved.
//

#import "ArCallViewController.h"

@interface ArCallViewController ()<ARCallKitDelegate>

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@end

@implementation ArCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //上线
    ArCallManager *manager = ArCallManager.shareInstance;
    manager.callKit.callDelegate = self;
    [manager.callKit turnOnByToken:@"" userId:ArUserManager.getUserInfo.userid];
    
    self.numberLabel.text = ArUserManager.getUserInfo.userid;
    
    [self.stackView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            button.backgroundColor = [ArCallCommon colorWithHex:@"#33B15D"];
            //[button.layer addSublayer:[ArCallCommon setGradualChangingColor:CGRectMake(0, 0, CGRectGetWidth(self.view.frame) * 0.8, 50) fromColor:@"#33B15D" toColor:@"#51D64E"]];
        }
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tap];
}

- (void)hideKeyBoard {
    [ArCallCommon hideKeyBoard];
}

- (IBAction)handleSomethingEvent:(UIButton *)sender {
    if (sender.tag == 50) {
        [UIAlertController showAlertInViewController:self withTitle:@"确认退出登陆？" message:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"退出"] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
            if (buttonIndex == 2) {
                //清除账户并下线
                [ArCallManager.shareInstance.callKit turnOff];
                [ArUserManager removeUserInfo];
                UIWindow *keyWindow = UIApplication.sharedApplication.delegate.window;
                keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"P2P_MainID"];
            }
        }];
    } else {
        if (self.numberTextField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
            [SVProgressHUD dismissWithDelay:1.2];
        } else {
            [ArCallCommon hideKeyBoard];
            NSArray *arr = @[@"2",@"0",@"1"];
            ARCallMode callMode = (ARCallMode)[arr[sender.tag - 51] intValue];
            [ArCallManager.shareInstance callWithNumber:self.numberTextField.text mode:callMode callStatus:ArCallStatus_Call makeCall:YES];
        }
    }
}

//MARK: - ARCallKitDelegate

- (void)onRTCConnected {
    //服务器链接成功
    self.stateLabel.text = @"在线";
}

- (void)onRTCDisconnect:(ARCallCode)code {
    //服务器断开
    self.stateLabel.text = @"离线";
}


@end
