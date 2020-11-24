//
//  BuildCompanyListViewController.m
//  louyu
//
//  Created by aaa on 2018/11/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BuildCompanyListViewController.h"
#import "BuildSaleTableViewCell.h"
#define kBuildSaleTableViewCellID   @"BuildSaleTableViewCell"
#import "buildCompanyDetailViewController.h"

@interface BuildCompanyListViewController ()<UITableViewDelegate, UITableViewDataSource,UserData_MyQuestionDetail>

@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, assign)int currentPage;

@end

@implementation BuildCompanyListViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    [self.dataArray removeAllObjects];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getBuildCompanyArray]) {
        [self.dataArray addObject:infoDic];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationViewSetup];
    
    [self prepareUI];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"入驻企业";
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
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 10) style:UITableViewStylePlain];
    self.tableview.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[BuildSaleTableViewCell class] forCellReuseIdentifier:kBuildSaleTableViewCellID];
    [self.view addSubview:self.tableview];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
}

- (void)loadData
{
    [SVProgressHUD show];

    [[UserManager sharedManager] didRequestBuildCompanyListWithWithDic:@{kbuildName:[self.infoDic objectForKey:@"buildName"],@"seatNo":[self.infoDic objectForKey:@"seatNo"],@"floorNo":@"",@"page":@(1)} withNotifiedObject:self];
    self.currentPage = 1;
}

- (void)footRefresh
{
    [SVProgressHUD show];
    self.currentPage++;
    [[UserManager sharedManager] didRequestBuildCompanyListWithWithDic:@{kbuildName:[self.infoDic objectForKey:@"buildName"],@"seatNo":[self.infoDic objectForKey:@"seatNo"],@"floorNo":@"",@"page":@(self.currentPage)} withNotifiedObject:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuildSaleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kBuildSaleTableViewCellID forIndexPath:indexPath];
    
    [cell refreshWith:self.dataArray[indexPath.row]];
    cell.iconImageView.image = [UIImage imageNamed:@"company"];
    cell.titleLB.text = [self.dataArray[indexPath.row] objectForKey:@"name"];//name
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    buildCompanyDetailViewController * vc = [[buildCompanyDetailViewController alloc]init];
    vc.infoDic = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didRequestMyQuestionDetailSuccessed
{
    if ([[[UserManager sharedManager] getBuildSaleArray] count] > self.dataArray.count) {
        // 新页码有数据
        [self.tableview.mj_footer endRefreshing];
    }else
    {
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
        if (self.currentPage > 1) {
            self.currentPage--;
        }
    }
    [self.dataArray removeAllObjects];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getBuildCompanyArray]) {
        [self.dataArray addObject:infoDic];
    }
    
    NSLog(@"楼宇招租信息");
    [SVProgressHUD dismiss];
    [self.tableview.mj_header endRefreshing];
}

- (void)didRequestMyQuestionDetailFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
