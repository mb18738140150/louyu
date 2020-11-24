//
//  BuildSaleViewController.m
//  louyu
//
//  Created by aaa on 2018/11/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BuildSaleViewController.h"
#import "BuildSaleTableViewCell.h"
#define kBuildSaleTableViewCellID   @"BuildSaleTableViewCell"
#import "BuildSaleDetailViewController.h"

@interface BuildSaleViewController ()<UITableViewDelegate, UITableViewDataSource,UserData_SetaHaveReadQuestion>

@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, assign)int currentPage;

@end

@implementation BuildSaleViewController

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
    for (NSDictionary * infoDic in [[UserManager sharedManager] getBuildSaleArray]) {
        [self.dataArray addObject:infoDic];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationViewSetup];
    
    [self prepareUI];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"招商租售";
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
    [[UserManager sharedManager] didRequestbuildSaleWithWithDic:@{kbuildName:[self.infoDic objectForKey:@"buildName"],@"page":@(1)} withNotifiedObject:self];
    self.currentPage = 1;
}

- (void)footRefresh
{
    [SVProgressHUD show];
    self.currentPage++;
    [[UserManager sharedManager] didRequestbuildSaleWithWithDic:@{kbuildName:[self.infoDic objectForKey:@"buildName"],@"page":@(self.currentPage)} withNotifiedObject:self];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuildSaleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kBuildSaleTableViewCellID forIndexPath:indexPath];
    
    [cell refreshWith:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuildSaleDetailViewController * vc = [[BuildSaleDetailViewController alloc]init];
    vc.infoDic = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didRequestSetaHaveReadQuestionSuccessed
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
    for (NSDictionary * infoDic in [[UserManager sharedManager] getBuildSaleArray]) {
        [self.dataArray addObject:infoDic];
    }
    NSLog(@"楼宇招租信息");
    [SVProgressHUD dismiss];
    [self.tableview.mj_header endRefreshing];
}

- (void)didRequestSetaHaveReadQuestionFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
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
