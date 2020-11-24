//
//  BuildSearchViewController.m
//  louyu
//
//  Created by aaa on 2018/11/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BuildSearchViewController.h"
#import "BuildSearchTableViewCell.h"
#define kBuildSearchTableViewCellID @"BuildSearchTableViewCell"
#import "BuildSearchResultTableViewCell.h"
#define kBuildSearchResultTableViewCellID @"BuildSearchResultTableViewCell"
#import "BuildDetailViewController.h"

@interface BuildSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UserData_MyBookMarkList>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSArray * datArray;

@property (nonatomic, strong)MKPPlaceholderTextView * textView;
@property (nonatomic, strong)NSString * searchStr;
@property (nonatomic, assign)BOOL isHaveSearchContent;
@end

@implementation BuildSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationViewSetup];
    [self prepareUI];
}

- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestSearchBuildingInfoWithWithDic:@{kbuildName:@""} withNotifiedObject:self];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"查询楼宇信息";
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
    if (self.isGetBuildName) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)prepareUI
{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[BuildSearchTableViewCell class] forCellReuseIdentifier:kBuildSearchTableViewCellID];
    [self.tableView registerClass:[BuildSearchResultTableViewCell class] forCellReuseIdentifier:kBuildSearchResultTableViewCellID];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isHaveSearchContent) {
        BuildSearchResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kBuildSearchResultTableViewCellID forIndexPath:indexPath];
        [cell refreshWith:self.datArray[indexPath.row]];
        return cell;
    }
    
    BuildSearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kBuildSearchTableViewCellID forIndexPath:indexPath];
    [cell refreshWith:self.datArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isHaveSearchContent) {
        return 170;
    }
    return 95;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    headView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    UIView * searchView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 70, 30)];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.layer.cornerRadius = searchView.hd_height / 2;
    searchView.layer.masksToBounds = YES;
    searchView.layer.borderWidth = 1;
    searchView.layer.borderColor = kCommonMainTextColor_200.CGColor;
    [headView addSubview:searchView];
    
    UIImageView * searchIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 16, 16)];
    searchIconImageView.image = [UIImage imageNamed:@"ic_search"];
    [searchView addSubview:searchIconImageView];
    
    MKPPlaceholderTextView * textView = [[MKPPlaceholderTextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(searchIconImageView.frame) + 10, 0, searchView.hd_width - 45, 30)];
    textView.returnKeyType = UIReturnKeyDone;
    textView.delegate = self;
    textView.placeholder = @"请输入要查询的楼宇名称";
    textView.text = self.searchStr;
    textView.font = [UIFont systemFontOfSize:15];
    self.textView = textView;
    [searchView addSubview:textView];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(CGRectGetMaxX(searchView.frame) + 5, 0, kScreenWidth - CGRectGetMaxX(searchView.frame) - 10, 50);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:kCommonMainColor forState:UIControlStateNormal];
    [headView addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * infoDic = self.datArray[indexPath.row];
    if (self.isGetBuildName ) {
        if (self.GetBuildNameBlock) {
            self.GetBuildNameBlock([[infoDic objectForKey:@"placeEntity"] objectForKey:@"buildName"]);
        }
        [self backAction:[UIButton buttonWithType:UIButtonTypeCustom]];
        return;
    }
    
    BuildDetailViewController * buildDetailVC = [[BuildDetailViewController alloc]init];
    buildDetailVC.infoDic = infoDic;
    [self.navigationController pushViewController:buildDetailVC animated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    self.searchStr = textView.text;
}

- (void)searchAction
{
    [self.textView resignFirstResponder];
    if (self.searchStr.length > 0) {
        self.isHaveSearchContent = YES;
    }else
    {
        self.isHaveSearchContent = NO;
    }
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestSearchBuildingInfoWithWithDic:@{kbuildName:self.searchStr} withNotifiedObject:self];
}

- (void)didRequestMyBookMarkListSuccessed
{
    [SVProgressHUD dismiss];
    self.datArray = [[UserManager sharedManager] getBuildArray];
    [self.tableView reloadData];
}

- (void)didRequestMyBookMarkListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
