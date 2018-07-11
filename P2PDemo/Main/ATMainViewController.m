//
//  ATMainViewController.m
//  P2PDemo
//
//  Created by jh on 2017/11/2.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATMainViewController.h"
#import "ATStartViewController.h"

@interface ATMainViewController ()

//手机号
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (nonatomic, strong) UIButton *leftPhoneButton;

@property (nonatomic, strong) UIButton *leftCodeButton;

@property (nonatomic, strong) ATCountdown *verificationButton;

//用户id（手机号）
@property (nonatomic, copy) NSString *userId;

@end

@implementation ATMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userId = [[NSUserDefaults standardUserDefaults] objectForKey:User_PhoneNumber];
    if ([ATCommon valiMobile:self.userId]) {
        self.phoneTextField.hidden = YES;
        self.codeTextField.hidden = YES;
        [self.userButton setTitle:self.userId forState:UIControlStateNormal];
        //P2P上线
        [[[ATCallManager sharedInstance] p2PKit] turnOn:self.userButton.titleLabel.text];
    } else {
        //登录
        self.userButton.hidden = YES;
        self.phoneTextField.leftView = self.leftPhoneButton;
        self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        self.codeTextField.leftView = self.leftCodeButton;
        self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
        self.codeTextField.rightView = self.verificationButton;
        self.codeTextField.rightViewMode = UITextFieldViewModeAlways;
        [self.codeTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
        [self.phoneTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ATStartViewController *p2PVc = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"Start"]) {
        p2PVc.userId = self.userButton.titleLabel.text;
    }
}

//获取验证码
- (void)getVerificationCode{
    if (![ATCommon valiMobile:self.phoneTextField.text]) {
        [XHToast showCenterWithText:@"手机号码格式错误"];
        return;
    }
    
    [self.verificationButton timeFailBeginFrom:60];
    
    //获取验证码请求
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"sign_in",@"domain",self.phoneTextField.text,@"u_cellphone", nil];
    [[ATNetWorkTool sharedManager]postSendVercode:parameters url:@"p2papi/v1/sms/send_vercode" successBlock:^(NSDictionary *dict) {
        if ((NSInteger)[dict objectForKey:@"code"] == 200) {
            [XHToast showCenterWithText:@"短信发送成功"];
        }
    }];
}

//验证
- (void)checkVerCode{
    [self checkCodeSucess:YES];
    return;
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"sign_in",@"domain",self.codeTextField.text,@"vercode",self.phoneTextField.text,@"u_cellphone", nil];
    
    [[ATNetWorkTool sharedManager] postCheckVercode:parameters url:@"p2papi/v1/sms/check_vercode" successBlock:^(NSDictionary *dict) {
        NSInteger code = [[dict objectForKey:@"code"] integerValue];
        switch (code) {
            case 200:
                [self checkCodeSucess:YES];
                break;
            case 212:
                [XHToast showCenterWithText:@"短信验证码不存在"];
                break;
            case 213:
                [XHToast showCenterWithText:@"短信验证码不正确"];
                break;
            default:
                break;
        }
    }];
}


- (IBAction)doSomethingEvents:(UIButton *)sender {
    
    switch (sender.tag) {
        case 101:
        {
            if (self.userId.length == 0) {
                if (![ATCommon valiMobile:self.phoneTextField.text]) {
                    [XHToast showCenterWithText:@"手机号格式错误"];
                    return;
                }
                if (self.codeTextField.text.length != 6) {
                    [XHToast showCenterWithText:@"验证码错误"];
                    return;
                }
                //验证验证码
                [self checkVerCode];
                return;
            }
            [self checkCodeSucess:NO];
        }
            break;
        case 102:
            [ATCommon callPhone:@"021-65650071" control:sender];
            break;
        case 103:
            //重新上线
            if (!self.isOn) {
                [[[ATCallManager sharedInstance] p2PKit] turnOn:self.userButton.titleLabel.text];
            }
            break;
        default:
            break;
    }
}

- (void)checkCodeSucess:(BOOL)isCheck{
    if (isCheck) {
        self.userId = self.phoneTextField.text;
        self.phoneTextField.hidden = YES;
        self.codeTextField.hidden = YES;
        self.userButton.hidden = NO;
        [self.userButton setTitle:self.userId forState:UIControlStateNormal];
        [[[ATCallManager sharedInstance] p2PKit] turnOn:self.userButton.titleLabel.text];
        [[NSUserDefaults standardUserDefaults] setObject:self.userId forKey:User_PhoneNumber];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    ATStartViewController *startVc = [[self storyboard] instantiateViewControllerWithIdentifier:@"Start"];
    if (self.isOn) {
        startVc.isOn = YES;
    }
    
    startVc.userId = self.userId;
    startVc.mainVc = self;
    [self.navigationController pushViewController:startVc animated:YES];
}

- (void)valueChange:(UITextField *)textField{
    switch (textField.tag) {
        case 50:
            if (textField.text.length > 11) {
                textField.text = [textField.text substringWithRange:NSMakeRange(0, 11)];
            }
            break;
        case 51:
            if (textField.text.length > 6) {
                textField.text = [textField.text substringWithRange:NSMakeRange(0, 6)];
            }
            break;
        default:
            break;
    }
}

#pragma mark - other
- (UIButton *)leftCodeButton{
    if (!_leftCodeButton) {
        _leftCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftCodeButton.frame = CGRectMake(0, 0, 35, 35);
        [_leftCodeButton setImage:[UIImage imageNamed:@"VerificationCode"] forState:UIControlStateNormal];
    }
    return _leftCodeButton;
}

- (UIButton *)leftPhoneButton{
    if (!_leftPhoneButton) {
        _leftPhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftPhoneButton.frame = CGRectMake(0, 0, 35, 35);
        [_leftPhoneButton setImage:[UIImage imageNamed:@"Accountnumber"] forState:UIControlStateNormal];
    }
    return _leftPhoneButton;
}

- (ATCountdown *)verificationButton{
    if (!_verificationButton) {
        _verificationButton = [[ATCountdown alloc]initWithFrame:CGRectZero];
        [_verificationButton addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
        _verificationButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verificationButton sizeToFit];
    }
    return _verificationButton;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (!self.phoneTextField.hidden) {
        [self.phoneTextField wzx_addLineWithDirection:WZXLineDirectionBottom type:WZXLineTypeFill lineWidth:1.5 lineColor:[UIColor whiteColor]];
        [self.codeTextField wzx_addLineWithDirection:WZXLineDirectionBottom type:WZXLineTypeFill lineWidth:1.5 lineColor:[UIColor whiteColor]];
        [self.phoneTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self.codeTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [ATCommon hideKeyBoard];
}

@end
