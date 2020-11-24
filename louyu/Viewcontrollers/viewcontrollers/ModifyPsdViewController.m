//
//  ModifyPsdViewController.m
//  louyu
//
//  Created by aaa on 2018/11/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ModifyPsdViewController.h"

@interface ModifyPsdViewController ()<UserModule_ResetPwdProtocol>

@property (nonatomic, strong)UITextField * oldPsdTF;
@property (nonatomic, strong)UITextField *nPsdTF;
@property (nonatomic, strong)UITextField *surePsdTF;
@property (nonatomic, strong)UIButton * complateBtn;

@end

@implementation ModifyPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self navigationViewSetup];
    [self prepareUI];
}

#pragma mark - ui
- (void)navigationViewSetup
{
    self.navigationItem.title = @"系统设置";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};
    
    TeamHitBarButtonItem * leftBarItem = [TeamHitBarButtonItem leftButtonWithImage:[UIImage imageNamed:@"ic_back"] title:@""];
    [leftBarItem addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarItem];
}

- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareUI
{
    self.view.backgroundColor = UIRGBColor(243, 243, 243);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAction)];
    [self.view addGestureRecognizer:tap];
    
    self.oldPsdTF = [[UITextField alloc]initWithFrame:CGRectMake(12, 18, kScreenWidth - 24, 37)];
    self.oldPsdTF.layer.cornerRadius = 5;
    self.oldPsdTF.layer.masksToBounds = YES;
    self.oldPsdTF.backgroundColor = [UIColor whiteColor];
    self.oldPsdTF.placeholder = @"请输入原密码";
    self.oldPsdTF.secureTextEntry = YES;
    [self.view addSubview:self.oldPsdTF];
    
    self.nPsdTF = [[UITextField alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(self.oldPsdTF.frame) + 10, kScreenWidth - 24, 37)];
    self.nPsdTF.layer.cornerRadius = 5;
    self.nPsdTF.layer.masksToBounds = YES;
    self.nPsdTF.backgroundColor = [UIColor whiteColor];
    self.nPsdTF.placeholder = @"请输入新密码";
    self.nPsdTF.secureTextEntry = YES;
    [self.view addSubview:self.nPsdTF];
    
    self.surePsdTF = [[UITextField alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(self.nPsdTF.frame) + 10, kScreenWidth - 24, 37)];
    self.surePsdTF.layer.cornerRadius = 5;
    self.surePsdTF.layer.masksToBounds = YES;
    self.surePsdTF.backgroundColor = [UIColor whiteColor];
    self.surePsdTF.placeholder = @"请再次输入新密码";
    self.surePsdTF.secureTextEntry = YES;
    [self.view addSubview:self.surePsdTF];
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(12, CGRectGetMaxY(self.surePsdTF.frame) + 40, kScreenWidth - 24, 40) ;
    self.complateBtn.backgroundColor = UIRGBColor(59, 125, 253);
    [self.complateBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.complateBtn.layer.cornerRadius = 5;
    self.complateBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.complateBtn];
    [self.complateBtn addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancelAction
{
    [self.oldPsdTF resignFirstResponder];
    [self.nPsdTF resignFirstResponder];
    [self.surePsdTF resignFirstResponder];
}

- (void)resetPassword
{
    if (self.oldPsdTF.text.length<= 0 || self.nPsdTF.text.length <= 0 || self.surePsdTF.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (![self.nPsdTF.text isEqualToString:self.surePsdTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"两次密码不一样，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (![self checkPassword:self.nPsdTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码格式不正确，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [SVProgressHUD show];
    [[UserManager sharedManager] resetPasswordWithOldPassword:self.oldPsdTF.text andNewPwd:self.nPsdTF.text withNotifiedObject:self];
}
#pragma mark -
- (BOOL)checkPassword:(NSString*) password
{
    
    NSString *pattern =@"[a-zA-Z0-9]{6,20}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:password];
    
    return isMatch;
}

- (void)didResetPwdFailed:(NSString *)failInfo
{
    [SVProgressHUD showErrorWithStatus:failInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didResetPwdSuccessed
{
    [SVProgressHUD dismiss];
    [[NSUserDefaults standardUserDefaults] setObject:self.nPsdTF.text forKey:@"Password"];
    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
