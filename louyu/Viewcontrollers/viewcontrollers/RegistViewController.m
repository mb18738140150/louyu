//
//  RegistViewController.m
//  louyu
//
//  Created by aaa on 2018/11/30.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "RegistViewController.h"
#define kImageWidth 25
@interface RegistViewController ()<UITextFieldDelegate, UserModule_RegistProtocol>

@property (nonatomic, strong)UIImageView * logoImageView;
@property (nonatomic, strong)UIButton * closeBtn;

@property (nonatomic, strong)UIView * background;

@property (nonatomic, strong)UITextField * account;
@property (nonatomic, strong)UITextField * password;
@property (nonatomic, strong)UITextField * againpassword;
@property (nonatomic, strong)UIButton * loginButton;

@end

@implementation RegistViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareUI];
    
}

- (void)prepareUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAction)];
    [self.view addGestureRecognizer:tap];
    
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(20, 40, 30, 30);
    [self.closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeBtn];
    
    self.logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - kScreenHeight * 0.09, kScreenHeight * 0.18, kScreenHeight * 0.19, kScreenHeight * 0.13)];
    self.logoImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:self.logoImageView];
    
    
    _background=[[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.logoImageView.frame) + 50, kScreenWidth-40, kScreenHeight - 160 - 70)];
    [_background setBackgroundColor:[UIColor whiteColor]];
    
    _background.userInteractionEnabled = YES;
    [self.view addSubview:_background];
    
    UIView * accountView = [[UIView alloc]initWithFrame:CGRectMake(20, 40, kScreenWidth - 80, 40)];
    accountView.backgroundColor = [UIColor whiteColor];
    [_background addSubview:accountView];
    
    UIImageView * accountImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, kImageWidth, kImageWidth)];
    accountImageView.image = [UIImage imageNamed:@"ic_login"];
    [accountView addSubview:accountImageView];
    
    _account=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountImageView.frame) + 10, 0, accountView.hd_width - 35, 40)];
    [_account setBackgroundColor:[UIColor clearColor]];
    _account.placeholder=[NSString stringWithFormat:@"请输入账号"];
    _account.delegate = self;
    _account.font = kMainFont;
    _account.textColor = kCommonMainTextColor_50;
    [accountView addSubview:_account];
    
    UIView * accountBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, accountView.hd_height - 1, accountView.hd_width, 1)];
    accountBottomView.backgroundColor = kCommonMainTextColor_200;
    [accountView addSubview:accountBottomView];
    
    UIView * passwordView = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(accountView.frame) + 20, kScreenWidth - 80, 40)];
    passwordView.backgroundColor = [UIColor whiteColor];
    [_background addSubview:passwordView];
    
    UIImageView * passwordImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, kImageWidth, kImageWidth)];
    passwordImageView.image = [UIImage imageNamed:@"ic_pwd"];
    [passwordView addSubview:passwordImageView];
    
    _password=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordImageView.frame) + 10, 0, kScreenWidth-40, 40)];
    [_password setBackgroundColor:[UIColor clearColor]];
    _password.secureTextEntry = YES;
    _password.placeholder=[NSString stringWithFormat:@"请输入密码"];
    _password.layer.cornerRadius=5.0;
    _password.delegate = self;
    _password.font = kMainFont;
    _password.textColor = kCommonMainTextColor_50;
    [passwordView addSubview:_password];
    
    UIView * passwordBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, passwordView.hd_height - 1, passwordView.hd_width, 1)];
    passwordBottomView.backgroundColor = kCommonMainTextColor_200;
    [passwordView addSubview:passwordBottomView];
    
    UIView * againPasswordView = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(passwordView.frame) + 20, kScreenWidth - 80, 40)];
    againPasswordView.backgroundColor = [UIColor whiteColor];
    [_background addSubview:againPasswordView];
    
    UIImageView * againPasswordImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, kImageWidth, kImageWidth)];
    againPasswordImageView.image = [UIImage imageNamed:@"ic_pwd"];
    [againPasswordView addSubview:againPasswordImageView];
    
    _againpassword=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(againPasswordImageView.frame) + 10, 0, kScreenWidth-40, 40)];
    [_againpassword setBackgroundColor:[UIColor clearColor]];
    _againpassword.secureTextEntry = YES;
    _againpassword.placeholder=[NSString stringWithFormat:@"请再次输入密码"];
    _againpassword.layer.cornerRadius=5.0;
    _againpassword.delegate = self;
    _againpassword.font = kMainFont;
    _againpassword.textColor = kCommonMainTextColor_50;
    [againPasswordView addSubview:_againpassword];
    
    UIView * againPasswordBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, againPasswordView.hd_height - 1, againPasswordView.hd_width, 1)];
    againPasswordBottomView.backgroundColor = kCommonMainTextColor_200;
    [againPasswordView addSubview:againPasswordBottomView];
    
    
    _loginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginButton setFrame:CGRectMake(0, CGRectGetMaxY(againPasswordView.frame) + 20, kScreenWidth - 40, 40)];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_loginButton setTitle:@"确认" forState:UIControlStateNormal];
    _loginButton.layer.cornerRadius = 5;
    _loginButton.layer.masksToBounds = YES;
    [_loginButton addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton setBackgroundColor:UIRGBColor(59, 125, 253)];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_background addSubview:_loginButton];
    
}

- (void)closeAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)cancelAction
{
    [self.account resignFirstResponder];
    [self.password resignFirstResponder];
    [self.againpassword resignFirstResponder];
}

- (void)doLogin
{
    if (self.account.text.length == 0 || self.password.text.length == 0 || self.againpassword.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"账号或密码不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (![self.password.text isEqualToString:self.againpassword.text]) {
        [SVProgressHUD showInfoWithStatus:@"两次密码不一致"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    NSString *userName = _account.text;
    NSString *password = _password.text;
    [[UserManager sharedManager] registWithDic:@{@"phone":userName,@"password":password,@"APP":@1} withNotifiedObject:self];
    [SVProgressHUD show];
}

- (void)didRegistSuccessed
{
    [[NSUserDefaults standardUserDefaults] setObject:_account.text forKey:@"Account"];
    [[NSUserDefaults standardUserDefaults] setObject:_password.text forKey:@"Password"];
    
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didRegistFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
