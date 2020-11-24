//
//  buildCompanyDetailViewController.m
//  louyu
//
//  Created by aaa on 2018/11/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "buildCompanyDetailViewController.h"
#import "BuildCompanyDetailTableViewCell.h"
#define kBuildCompanyDetailTableViewCellID @"BuildCompanyDetailTableViewCell"


@interface buildCompanyDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSArray * dataArray;



@end

@implementation buildCompanyDetailViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self navigationViewSetup];
    [self loadData];
    [self prepareUI];
}

- (void)loadData
{
    NSDictionary * companyType = @{@"title":@"企业类型",@"content":[self.infoDic objectForKey:@"companyType"]};
    NSDictionary * industry = @{@"title":@"所属行业",@"content":[self.infoDic objectForKey:@"industry"]};
    NSDictionary * companyCredit = @{@"title":@"证件号码",@"content":[self.infoDic objectForKey:@"companyCredit"]};
    NSDictionary * employNum = @{@"title":@"员工人数",@"content":[self.infoDic objectForKey:@"employNum"]};
    NSDictionary * contactName = @{@"title":@"联系人",@"content":[self.infoDic objectForKey:@"contactName"]};
    NSDictionary * contactPhone = @{@"title":@"联系方式",@"content":[self.infoDic objectForKey:@"contactPhone"]};
    NSDictionary * roomNo = @{@"title":@"房间号",@"content":[self.infoDic objectForKey:@"roomNo"]};
    self.dataArray = @[companyType, industry, companyCredit, employNum, contactName, contactPhone, roomNo];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"企业详情";
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
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[BuildCompanyDetailTableViewCell class] forCellReuseIdentifier:kBuildCompanyDetailTableViewCellID];
    [self.view addSubview:self.tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuildCompanyDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kBuildCompanyDetailTableViewCellID forIndexPath:indexPath];
    NSDictionary * infoDic = self.dataArray[indexPath.row];
    
    [cell refreshWith:infoDic];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
