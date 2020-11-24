//
//  NotifyListViewController.m
//  louyu
//
//  Created by aaa on 2018/11/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "NotifyListViewController.h"
#import "NotifyListTableViewCell.h"
#import "NotifyDetailViewController.h"

#define kNotifyListTableViewCellID @"NotifyListTableViewCell"

@interface NotifyListViewController ()<UITableViewDelegate, UITableViewDataSource, UserData_MyCollectiontextBook, UserData_MyQuestionlist>

@property  (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSArray * dataArray;

@end

@implementation NotifyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationViewSetup];
    [self prepareUI];
    [self loadData];
    
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    [SVProgressHUD show];
    if (self.notifyListVCType == NotifyListVCType_notify) {
        [[UserManager sharedManager] didRequestNotifyListWithWithDic:@{} withNotifiedObject:self];
    }else
    {
        [[UserManager sharedManager] didRequestRulerListWithWithDic:@{} withNotifiedObject:self];
    }
}

#pragma mark - ui
- (void)navigationViewSetup
{
    if (self.notifyListVCType == NotifyListVCType_notify) {
        self.navigationItem.title = @"通知公告";
    }else
    {
        self.navigationItem.title = @"政法法规";
    }
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NotifyListTableViewCell class] forCellReuseIdentifier:kNotifyListTableViewCellID];
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifyListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kNotifyListTableViewCellID forIndexPath:indexPath];
    cell.notifyListVCType = self.notifyListVCType;
    [cell refreshWith:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifyDetailViewController * detailVc = [[NotifyDetailViewController alloc]init];
    detailVc.infoDic = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - request
- (void)didRequestMyQuestionlistFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyQuestionlistSuccessed
{
    [SVProgressHUD dismiss];
    self.dataArray = [[UserManager sharedManager] getRulerArray];
    [self.tableView reloadData];
}

- (void)didRequestMyCollectiontextBookSuccessed
{
    [SVProgressHUD dismiss];
    self.dataArray = [[UserManager sharedManager] getNotifyArray];
    [self.tableView reloadData];
}

- (void)didRequestMyCollectiontextBookFailed:(NSString *)failedInfo
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
