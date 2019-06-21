//
//  ArMainViewController.m
//  ArP2PDemo
//
//  Created by 余生丶 on 2019/5/16.
//  Copyright © 2019 anyRTC. All rights reserved.
//

#import "ArMainViewController.h"

@interface ArMainViewController ()

@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation ArMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.versionLabel.text = [NSString stringWithFormat:@"V %@\n 技术支持：hi@dync.cc",Version];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (self.numberTextField.text.length != 0) {
        ArUserInfo *userInfo = [[ArUserInfo alloc] initWithName:@"" userId:self.numberTextField.text];
        [ArUserManager saveUserInfo:userInfo];
        return YES;
    }
    [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
    [SVProgressHUD dismissWithDelay:1.2];
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.numberTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
