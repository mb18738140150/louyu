//
//  CompanySearchViewController.m
//  louyu
//
//  Created by aaa on 2018/11/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CompanySearchViewController.h"
#import "CompanySearchTableViewCell.h"
#define kCompanySearchTableViewCellID @"CompanySearchTableViewCell"
#import "CompanySearchResultTableViewCell.h"
#define kCompanySearchResultTableViewCellID @"CompanySearchResultTableViewCell"
#import "CompanyDetailViewController.h"

@interface CompanySearchViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UserData_SearchMyCollectiontextBook>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * datArray;

@property (nonatomic, strong)MKPPlaceholderTextView * textView;
@property (nonatomic, strong)NSString * searchStr;
@property (nonatomic, assign)BOOL isHaveSearchContent;
@property (nonatomic, assign)int currentPage;

@end

@implementation CompanySearchViewController

- (NSMutableArray *)datArray
{
    if (!_datArray) {
        _datArray = [NSMutableArray array];
    }
    return _datArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchStr = @"";
    self.currentPage = 1;
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationViewSetup];
    [self prepareUI];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"查询企业";
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
    [SVProgressHUD dismiss];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)prepareUI
{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CompanySearchTableViewCell class] forCellReuseIdentifier:kCompanySearchTableViewCellID];
    [self.tableView registerClass:[CompanySearchResultTableViewCell class] forCellReuseIdentifier:kCompanySearchResultTableViewCellID];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
}

- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestSearchCompanyInfoWithDic:@{kcompanyName:self.searchStr,@"page":@1} withNotifiedObject:self];
    self.currentPage = 1;
}

- (void)footRefresh
{
    [SVProgressHUD show];
    self.currentPage++;
    [[UserManager sharedManager] didRequestSearchCompanyInfoWithDic:@{kcompanyName:self.searchStr,@"page":@(self.currentPage)} withNotifiedObject:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isHaveSearchContent) {
        CompanySearchResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCompanySearchResultTableViewCellID forIndexPath:indexPath];
        [cell refreshWith:self.datArray[indexPath.row]];
        return cell;
    }
    
    CompanySearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCompanySearchTableViewCellID forIndexPath:indexPath];
    [cell refreshWith:self.datArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isHaveSearchContent) {
        return 195;
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
    textView.placeholder = @"请输入要查询的企业名称";
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
    CompanyDetailViewController * buildDetailVC = [[CompanyDetailViewController alloc]init];
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
    self.currentPage = 1;
    [[UserManager sharedManager] didRequestSearchCompanyInfoWithDic:@{kcompanyName:self.searchStr,@"page":@(self.currentPage)} withNotifiedObject:self];
}

- (void)didRequestSearchMyCollectiontextBookSuccessed
{
    [SVProgressHUD dismiss];
    [self.tableView.mj_header endRefreshing];
    
    if ([[[UserManager sharedManager] getCompanyArray] count] > self.datArray.count) {
        // 新页码有数据
        [self.tableView.mj_footer endRefreshing];
    }else
    {
        if (self.currentPage > 1) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.currentPage--;
        }
    }

    [self.datArray removeAllObjects];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getCompanyArray]) {
        [self.datArray addObject:infoDic];
    }
    
    [self.tableView reloadData];
}

- (void)didRequestSearchMyCollectiontextBookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
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
