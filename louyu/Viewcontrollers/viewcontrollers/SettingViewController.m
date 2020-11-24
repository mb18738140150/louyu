//
//  SettingViewController.m
//  louyu
//
//  Created by aaa on 2018/11/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "SettingViewController.h"

#import "SettingTableViewCell.h"
#define kSettingTableViewCellID @"SettingTableViewCell"
#import "LogoutTipView.h"
#import "ModifyPsdViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UserInfo_ChangeGender,UINavigationControllerDelegate,UserInfo_changeIconImage>

@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, strong)UILabel * accountLB;
@property (nonatomic, strong)UILabel * nameLB;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSArray * dataArray;

@property (nonatomic, strong)UIImagePickerController * imagePic;
@property (nonatomic, strong)NSString * iconImageUrl;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationViewSetup];
    [self prepareUI];
    self.imagePic = [[UIImagePickerController alloc] init];
    _imagePic.allowsEditing = YES;
    _imagePic.delegate = self;
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
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)prepareUI
{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[[UserManager sharedManager] getUserInfos] objectForKey:kUserHeaderImageUrl]]] placeholderImage:[UIImage imageNamed:@"logo_small"]];
    [headView addSubview:self.imageView];
    
    self.accountLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame) + 20, 10, kScreenWidth - CGRectGetMaxX(self.imageView.frame) - 40, 35)];
    self.accountLB.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"Account"];
    [headView addSubview:self.accountLB];
    
    self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(self.accountLB.hd_x, CGRectGetMaxY(self.accountLB.frame), self.accountLB.hd_width, 35)];
    self.nameLB.text = [[UserManager sharedManager] getUserName];
    [headView addSubview:self.nameLB];
    
    self.dataArray = @[@{@"imageStr":@"ic_modify_pwd",@"title":@"修改登录密码",@"type":@(BasicCategoryType_course)},@{@"imageStr":@"ic_modify_head",@"title":@"修改头像",@"type":@(BasicCategoryType_course)},@{@"imageStr":@"ic_back_login",@"title":@"退出登录",@"type":@(BasicCategoryType_course)}];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, headView.hd_height, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 90) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIRGBColor(243, 243, 243);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:kSettingTableViewCellID];
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kSettingTableViewCellID forIndexPath:indexPath];
    [cell refreshWith:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (indexPath.row == 2) {
        LogoutTipView * logOutView = [[LogoutTipView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        logOutView.QuitBlock = ^(BOOL quit) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Account"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Password"];
            [[UserManager sharedManager] logout];
            
            if (weakSelf.QuitBlock) {
                weakSelf.QuitBlock(YES);
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController dismissViewControllerAnimated:NO completion:nil];
            });
        };
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:logOutView];
        
    }else if (indexPath.row == 0)
    {
        ModifyPsdViewController * modifyPsdVC = [[ModifyPsdViewController alloc]init];
        [self.navigationController pushViewController:modifyPsdVC animated:YES];
    }
    else if (indexPath.row == 1)
    {
        [self changeIconAction];
    }
}


- (void)changeIconAction
{
    
    UIAlertController * alertcontroller = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagePic.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePic animated:YES completion:nil];
        }else
        {
            UIAlertController * tipControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有相机,请选择图库" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                ;
            }];
            [tipControl addAction:sureAction];
            [self presentViewController:tipControl animated:YES completion:nil];
            
        }
    }];
    UIAlertAction * libraryAction = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePic animated:YES completion:nil];
    }];
    
    [alertcontroller addAction:cancleAction];
    [alertcontroller addAction:cameraAction];
    [alertcontroller addAction:libraryAction];
    
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self upLoadImage:self.imageView.image];
}

- (void)upLoadImage:(UIImage *)image
{
    [SVProgressHUD show];
    NSMutableString *imageStr = [[NSMutableString alloc] init];
    [imageStr appendString:[image base64]];
    [[UserManager sharedManager] didRequestChangeIconImageFileWithWithDic:@{@"imgFile":imageStr} withNotifiedObject:self];
}

- (void)didRequestChangeGenderSuccessed
{
    NSLog(@"%@", [[UserManager sharedManager] getChangeIconImageFile]);
    
    [[UserManager sharedManager] didRequestChangeIconImageWithWithDic:@{@"imgPath":[[[UserManager sharedManager] getChangeIconImageFile] objectForKey:@"imgPath"]} withNotifiedObject:self];
    self.iconImageUrl = [[[UserManager sharedManager] getChangeIconImageFile] objectForKey:@"imgPath"];
}

- (void)didRequestChangeGenderFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestchangeIconImageSuccessed
{
    [SVProgressHUD dismiss];
    NSString * iconStr = [NSString stringWithFormat:@"%@%@",kImageUrl, self.iconImageUrl];
    NSLog(@"iconStr = %@", iconStr);
    [[UserManager sharedManager] changeIconUrl:iconStr];
    [[UserManager sharedManager] encodeUserInfo];
    if (self.ChangeIconBlock) {
        self.ChangeIconBlock(self.imageView.image);
    }
    
}

- (void)didRequestchangeIconImageFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
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
