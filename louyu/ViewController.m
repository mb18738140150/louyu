//
//  ViewController.m
//  louyu
//
//  Created by aaa on 2018/11/7.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ViewController.h"
#import "MainViewTableViewCell.h"
#define kMainViewTableViewCellID  @"MainViewTableViewCell"

#import "LoginViewController.h"
#import "NotifyListViewController.h"
#import "SettingViewController.h"
#import "AddCompanyViewController.h"
#import "CompanySearchViewController.h"
#import "BuildSearchViewController.h"
#import "AllBuildMapViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UserData_MyCollectiontextBook, UserData_MyQuestionlist,UserModule_LoginProtocol,UserData_MyHeadQuestion>

@property (nonatomic, strong)UIScrollView * scrollView;

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIImageView * backImageView;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIButton * loginBtn;
@property (nonatomic, strong)BasicCategoryView * addView;
@property (nonatomic, strong)BasicCategoryView * searchView;
@property (nonatomic, strong)BasicCategoryView *buildingInfoView;
@property (nonatomic, strong)BasicCategoryView * settingView;

@property (nonatomic, strong)BasicCategoryView * todayView;
@property (nonatomic, strong)BasicCategoryView * weekView;
@property (nonatomic, strong)BasicCategoryView * monthView;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSArray * dataArray;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSArray * collectionDataArray;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    
    [self loadData];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareUI
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = UIRGBColor(238, 238, 238);
    [self.view addSubview:self.scrollView];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.313)];
    self.backImageView.image = [UIImage imageNamed:@"top_bg"];
    [self.scrollView addSubview:self.backImageView];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 48, 81, 81)];
    self.iconImageView.hd_x = kScreenWidth / 2 - self.iconImageView.hd_width / 2;
    self.iconImageView.image = [UIImage imageNamed:@"logo_small"];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth = 5;
    self.iconImageView.layer.borderColor = UIRGBColor(94, 204, 254).CGColor;
    [self.scrollView addSubview:self.iconImageView];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(kScreenWidth / 2 - 67, CGRectGetMaxY(self.iconImageView.frame) + 17, 134, 33);
    self.loginBtn.backgroundColor = [UIColor whiteColor];
    [self.loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:UIColorFromRGB(0x21B0FE) forState:UIControlStateNormal];
    [self.scrollView addSubview:self.loginBtn];
    self.loginBtn.layer.cornerRadius = self.loginBtn.hd_height / 2;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * categoryView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backImageView.frame), kScreenWidth, kScreenHeight * 0.16)];
    categoryView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:categoryView];
    
    float space = (kScreenWidth / 4 - kScreenWidth * 0.24) / 2;
    
    BasicCategoryView * addView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(space, 20, kScreenWidth * 0.22, kScreenWidth * 0.22 ) andInfo:@{@"imageStr":@"ic_add_company",@"title":@"添加企业",@"type":@(BasicCategoryType_course)}];
    [addView resetTitleColor:kMainTextColor_100];
    self.addView = addView;
    [categoryView addSubview:self.addView];
    
    BasicCategoryView * searchView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(kScreenWidth / 4 + space, 20, kScreenWidth * 0.22, kScreenWidth * 0.22 ) andInfo:@{@"imageStr":@"ic_search_company",@"title":@"查询企业",@"type":@(BasicCategoryType_course)}];
    [searchView resetTitleColor:kMainTextColor_100];
    self.searchView = searchView;
    [categoryView addSubview:self.searchView];
    
    BasicCategoryView * buildingInfoView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(kScreenWidth / 2+ space, 20, kScreenWidth * 0.22, kScreenWidth * 0.22 ) andInfo:@{@"imageStr":@"ic_build_infor",@"title":@"楼宇信息查询",@"type":@(BasicCategoryType_course)}];
    [buildingInfoView resetTitleColor:kMainTextColor_100];
    self.buildingInfoView = buildingInfoView;
    [categoryView addSubview:self.buildingInfoView];
    
    BasicCategoryView * settingView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(kScreenWidth / 4 * 3+ space, 20, kScreenWidth * 0.22, kScreenWidth * 0.22 ) andInfo:@{@"imageStr":@"ic_set",@"title":@"系统设置",@"type":@(BasicCategoryType_course)}];
    [settingView resetTitleColor:kMainTextColor_100];
    self.settingView = settingView;
    [categoryView addSubview:self.settingView];
    
    __weak typeof(self)weakSelf = self;
    addView.ClickBlock = ^(BasicCategoryType type) {
        [weakSelf loginAction];
    };
    searchView.ClickBlock = ^(BasicCategoryType type) {
        [weakSelf loginAction];
    };
    buildingInfoView.ClickBlock = ^(BasicCategoryType type) {
        [weakSelf loginAction];
    };
    settingView.ClickBlock = ^(BasicCategoryType type) {
        [weakSelf loginAction];
    };
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(categoryView.frame) + 10, kScreenWidth, kScreenHeight - CGRectGetMaxY(categoryView.frame) - 10) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MainViewTableViewCell class] forCellReuseIdentifier:kMainViewTableViewCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollEnabled = NO;
    [self.scrollView addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainViewTableViewCellID forIndexPath:indexPath];
    __weak typeof(self)weakSlef = self;
    NSMutableDictionary * mInfoDic = [NSMutableDictionary dictionary];
    if (indexPath.row == 0) {
        [mInfoDic setObject:@"通知公告" forKey:@"title"];
        [mInfoDic setObject:@"ic_notice" forKey:@"categoryIcon"];
        [mInfoDic setObject:@"通知公告" forKey:kcategoryName];
        NSArray * array = [[UserManager sharedManager]getNotifyArray];
        if (array == nil) {
            array = @[];
        }
        [mInfoDic setObject:array forKey:@"contentList"];
        cell.ClickBlock = ^(BOOL complate) {
            NotifyListViewController * vc = [[NotifyListViewController alloc]init];
            vc.notifyListVCType = NotifyListVCType_notify;
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [weakSlef presentViewController:nav animated:NO completion:nil];
        };
        cell.informationType = InformationType_notification;
    }else
    {
        [mInfoDic setObject:@"政策法规" forKey:@"title"];
        [mInfoDic setObject:@"ic_rule" forKey:@"categoryIcon"];
        [mInfoDic setObject:@"政法规则" forKey:kcategoryName];
        NSArray * array = [[UserManager sharedManager]getRulerArray];
        if (array == nil) {
            array = @[];
        }
        [mInfoDic setObject:array forKey:@"contentList"];
        cell.ClickBlock = ^(BOOL complate) {
            
            
            NotifyListViewController * vc = [[NotifyListViewController alloc]init];
            vc.notifyListVCType = NotifyListVCType_ruler;
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [weakSlef presentViewController:nav animated:NO completion:nil];
        };
        cell.informationType = InformationType_ruler;
    }
    
    [cell refreshWith:mInfoDic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  kScreenHeight * 0.243 + 10;
}

- (void)loginAction
{
    __weak typeof(self)weakSelf = self;
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    loginVC.loginSuccessBlock = ^(BOOL isSuccess) {
        [weakSelf.view removeAllSubviews];
        [weakSelf prepareUI2];
        [weakSelf loadData];
    };
    [self presentViewController:loginVC animated:NO completion:nil];
}

#pragma mark - have login
-(void)prepareUI2
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = UIRGBColor(238, 238, 238);
    [self.view addSubview:self.scrollView];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.35)];
    self.backImageView.image = [UIImage imageNamed:@"top_bg"];
    [self.scrollView addSubview:self.backImageView];
    
    UIButton * settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kScreenWidth - 50, 20, 50, 50);
    settingBtn.backgroundColor = [UIColor clearColor];
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:settingBtn];
    [settingBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth, 18)];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.font = [UIFont systemFontOfSize:18];
    self.titleLB.textColor = [UIColor whiteColor];
    self.titleLB.text = @"楼宇办公";
    [self.scrollView addSubview:self.titleLB];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLB.frame) + self.backImageView.hd_height * 0.14, 81, 81)];
    self.iconImageView.hd_x = kScreenWidth / 2 - self.iconImageView.hd_width / 2;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[[UserManager sharedManager] getUserInfos] objectForKey:kUserHeaderImageUrl]]] placeholderImage:[UIImage imageNamed:@"logo_small"]];//kUserHeaderImageUrl
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth = 5;
    self.iconImageView.layer.borderColor = UIRGBColor(94, 204, 254).CGColor;
    [self.scrollView addSubview:self.iconImageView];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(kScreenWidth / 2 - 67, CGRectGetMaxY(self.iconImageView.frame) + 11, 134, 33);
    self.loginBtn.backgroundColor = [UIColor clearColor];
    [self.loginBtn setTitle:[[UserManager sharedManager]getUserName] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.loginBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.scrollView addSubview:self.loginBtn];
    self.loginBtn.layer.cornerRadius = self.loginBtn.hd_height / 2;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.enabled = NO;
    
    UIView * categoryView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backImageView.frame), kScreenWidth, kScreenHeight * 0.16)];
    categoryView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:categoryView];
    
    float space = (kScreenWidth / 3 - kScreenWidth * 0.3) / 2;
    
    BasicCategoryView * todayView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(space, 0, kScreenWidth * 0.3, kScreenWidth * 0.22 ) andInfo:@{@"imageStr":@"",@"title":@"今日新增企业",@"type":@(BasicCategoryType_course)}];
    [todayView resetTitleColor:kCommonMainTextColor_50];
    todayView.headLB.hidden = NO;
    todayView.headLB.text = [NSString stringWithFormat:@"%d", [[UserManager sharedManager] getDayNum]];
    todayView.headLB.textColor = UIColorFromRGB(0x44D9F1);
    self.todayView = todayView;
    [categoryView addSubview:self.todayView];

    UIView * separateLine1 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth / 3, 18, 1, categoryView.hd_height - 36)];
    separateLine1.backgroundColor = UIColorFromRGB(0xDEDEDE);
    [categoryView addSubview:separateLine1];
    
    BasicCategoryView * weekView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(kScreenWidth / 3 + space, 0, kScreenWidth * 0.3, kScreenWidth * 0.22 ) andInfo:@{@"imageStr":@"",@"title":@"本周新增企业",@"type":@(BasicCategoryType_course)}];
    [weekView resetTitleColor:kCommonMainTextColor_50];
    weekView.headLB.hidden = NO;
    weekView.headLB.text = [NSString stringWithFormat:@"%d", [[UserManager sharedManager] getWeekNum]];
    weekView.headLB.textColor = UIColorFromRGB(0xFFBC45);
    self.weekView = weekView;
    [categoryView addSubview:self.weekView];
    
    UIView * separateLine2 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth / 3 * 2, 18, 1, categoryView.hd_height - 36)];
    separateLine2.backgroundColor = UIColorFromRGB(0xDEDEDE);
    [categoryView addSubview:separateLine2];
    
    BasicCategoryView * monthView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(kScreenWidth / 3 * 2+ space, 0, kScreenWidth * 0.3, kScreenWidth * 0.22 ) andInfo:@{@"imageStr":@"",@"title":@"本月新增企业",@"type":@(BasicCategoryType_course)}];
    [monthView resetTitleColor:kCommonMainTextColor_50];
    monthView.headLB.hidden = NO;
    monthView.headLB.text = [NSString stringWithFormat:@"%d", [[UserManager sharedManager] getMonthNum]];
    monthView.headLB.textColor = UIColorFromRGB(0xFC4D6E);
    self.monthView = monthView;
    [categoryView addSubview:self.monthView];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth / 3, kScreenWidth / 3 * 1.1);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    self.collectionDataArray = @[@{@"imageStr":@"ic_notice",@"title":@"通知公告",@"type":@(BasicCategoryType_course)},@{@"imageStr":@"ic_rule",@"title":@"政策法规",@"type":@(BasicCategoryType_course)},@{@"imageStr":@"ic_add_company",@"title":@"添加企业",@"type":@(BasicCategoryType_course)},@{@"imageStr":@"ic_search_company",@"title":@"查询企业",@"type":@(BasicCategoryType_course)},@{@"imageStr":@"ic_build_infor",@"title":@"楼宇信息查询",@"type":@(BasicCategoryType_course)},@{@"imageStr":@"ic_all_build",@"title":@"全域楼宇",@"type":@(BasicCategoryType_course)}];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(categoryView.frame) + 10, kScreenWidth, kScreenHeight - CGRectGetMaxY(categoryView.frame) - 10) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.scrollView addSubview:self.collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    BasicCategoryView * categoryView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(kScreenWidth / 6 - 50, (cell.hd_height - 100) / 2, 100, 100) andInfo:self.collectionDataArray[indexPath.row]];
    [cell.contentView addSubview:categoryView];
    
    __weak typeof(self)weakSelf = self;
    categoryView.ClickBlock = ^(BasicCategoryType type) {
        [weakSelf operationWith:indexPath.row];
    };
    
    if ((indexPath.row + 1) % 3 != 0) {
        
        UIView * vSeparateLine = [[UIView alloc]init];
        if (indexPath.row < 3) {
            vSeparateLine.frame = CGRectMake(cell.hd_width - 1, 12, 1, cell.hd_height - 12);
        }else
        {
            vSeparateLine.frame = CGRectMake(cell.hd_width - 1, 0, 1, cell.hd_height - 12);
        }
        vSeparateLine.backgroundColor = UIColorFromRGB(0xf2f2f2);
        [cell.contentView addSubview:vSeparateLine];
    }
    
    if (indexPath.row < 3) {
        UIView * hSeparateLine = [[UIView alloc]initWithFrame:CGRectMake(0, cell.hd_height - 1, cell.hd_width, 1)];
        hSeparateLine.backgroundColor = UIColorFromRGB(0xf2f2f2);
        [cell.contentView addSubview:hSeparateLine];
    }
    
    return cell;
}

- (void)operationWith:(NSInteger)row
{
    __weak typeof(self)weakSelf = self;
    switch (row) {
        case 0:
        {
            NotifyListViewController * vc = [[NotifyListViewController alloc]init];
            vc.notifyListVCType = NotifyListVCType_notify;
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:NO completion:nil];
                
            }
            break;
        case 1:
        {
            NotifyListViewController * vc = [[NotifyListViewController alloc]init];
            vc.notifyListVCType = NotifyListVCType_ruler;
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:NO completion:nil];
        }
            break;
        case 2:
        {
            AddCompanyViewController * addCompanyVC = [[AddCompanyViewController alloc]init];
            
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:addCompanyVC];
            [self presentViewController:nav animated:NO completion:nil];
        }
            break;
        case 3:
        {
            CompanySearchViewController * CompanyVC = [[CompanySearchViewController alloc]init];
            
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:CompanyVC];
            [self presentViewController:nav animated:NO completion:nil];
        }
            break;
        case 4:
        {
            BuildSearchViewController * CompanyVC = [[BuildSearchViewController alloc]init];
            
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:CompanyVC];
            [self presentViewController:nav animated:NO completion:nil];
        }
            break;
        case 5:
        {
            AllBuildMapViewController * allBuildVC = [[AllBuildMapViewController alloc]init];
            
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:allBuildVC];
            [self presentViewController:nav animated:NO completion:nil];
        }
            break;
        default:
            break;
    }
}

- (void)loadData
{
    [SVProgressHUD show];
    NSString * account = [[NSUserDefaults standardUserDefaults] objectForKey:@"Account"];
    NSString * password = [[NSUserDefaults standardUserDefaults] objectForKey:@"Password"];
    if (account.length > 0 && password.length > 0) {
        [[UserManager sharedManager] loginWithUserName:account andPassword:password withNotifiedObject:self];
    }
    
    [[UserManager sharedManager] didRequestNotifyListWithWithDic:@{} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestRulerListWithWithDic:@{} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestAllBuildTypeListWithWithDic:@{} withNotifiedObject:self];
}

- (void)didRequestMyQuestionlistFailed:(NSString *)failedInfo
{
//    [SVProgressHUD showErrorWithStatus:failedInfo];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
}

- (void)didRequestMyQuestionlistSuccessed
{
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
}

- (void)didRequestMyCollectiontextBookSuccessed
{
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
}

- (void)didRequestMyCollectiontextBookFailed:(NSString *)failedInfo
{
//    [SVProgressHUD showErrorWithStatus:failedInfo];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
}
- (void)didRequestMyHeadQuestionSuccessed
{
    [SVProgressHUD dismiss];
}

- (void)didRequestMyHeadQuestionFailed:(NSString *)failedInfo
{
//    [SVProgressHUD showErrorWithStatus:failedInfo];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
}
- (void)didUserLoginSuccessed
{
    [self prepareUI2];
}

- (void)didUserLoginFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)settingAction
{
    __weak typeof(self)weakSelf = self;
    SettingViewController * vc = [[SettingViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    vc.QuitBlock = ^(BOOL quit) {
        [weakSelf.view removeAllSubviews];
        [weakSelf prepareUI];
    };
    vc.ChangeIconBlock = ^(UIImage *image) {
        weakSelf.iconImageView.image = image;
    };
    [self presentViewController:nav animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
