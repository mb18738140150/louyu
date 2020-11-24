//
//  CompanyDetailViewController.m
//  louyu
//
//  Created by aaa on 2018/11/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CompanyDetailViewController.h"

#import "BuildDetailTableViewCell.h"
#define kAddCompanyTableViewCellID @"BuildDetailTableViewCell"

@interface CompanyDetailViewController ()<UITableViewDelegate, UITableViewDataSource,MFoldingSectionHeaderDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataAarray;
@property (nonatomic, strong)NSArray * headerArray;

@property (nonatomic, strong)NSArray * basicInformationArray;
@property (nonatomic, strong)NSArray * yingyezhizhaoArray;
@property (nonatomic, strong)NSArray * addressInfoArray;
@property (nonatomic, strong)NSArray * otherInfoArray;


@property (nonatomic, strong) NSMutableArray *statusArray;
@property (nonatomic, assign)CGFloat contentOffset_Y;

@end

@implementation CompanyDetailViewController

-(NSMutableArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    if (_statusArray.count) {
        if (_statusArray.count > self.tableView.numberOfSections) {
            [_statusArray removeObjectsInRange:NSMakeRange(self.tableView.numberOfSections - 1, _statusArray.count - self.tableView.numberOfSections)];
        }else if (_statusArray.count < self.tableView.numberOfSections) {
            for (NSInteger i = self.tableView.numberOfSections - _statusArray.count; i < self.tableView.numberOfSections; i++) {
                [_statusArray addObject:[NSNumber numberWithInteger:MFoldingSectionStateFlod]];
            }
        }
    }else{
        for (NSInteger i = 0; i < self.tableView.numberOfSections; i++) {
            if (i == 0) {
                [_statusArray addObject:[NSNumber numberWithInteger:MFoldingSectionStateShow]];
            }else
            {
                [_statusArray addObject:[NSNumber numberWithInteger:MFoldingSectionStateFlod]];
            }
        }
    }
    return _statusArray;
}

- (NSMutableArray *)dataAarray
{
    if (!_dataAarray) {
        _dataAarray = [NSMutableArray array];
    }
    return _dataAarray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self navigationViewSetup];
    [self prepareUI];
}

- (void)loadData
{
    
    NSDictionary * basicEntity = [self.infoDic objectForKey:@"basicEntity"];
    NSDictionary * placeEntity = [self.infoDic objectForKey:@"placeEntity"];
    NSDictionary * otherEntity = [self.infoDic objectForKey:@"otherEntity"];
    
    
    self.headerArray = @[@{@"title":@"基本信息",@"image":@"ic_base_infor_normal",@"selectImage":@"ic_base_infor"},@{@"title":@"营业执照信息",@"image":@"ic_license_normal",@"selectImage":@"ic_license_select"},@{@"title":@"位置信息",@"image":@"ic_location_normal",@"selectImage":@"ic_location_select"},@{@"title":@"其他信息",@"image":@"ic_qi_infor_normal",@"selectImage":@"ic_qi_infor_select"}];
    
    self.yingyezhizhaoArray = @[@{@"title":@"营业执照",@"content":[basicEntity objectForKey:@"companyLicense"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)},@{@"title":@"信用代码",@"content":[basicEntity objectForKey:@"companyCredit"],@"type":@(CompanyInformationType_necessarily),@"enputType":@(EnPutType_nomal)},@{@"title":@"登记证",@"content":[basicEntity objectForKey:@"companyTax"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)}];
    
    self.basicInformationArray = @[@{@"title":@"公司名称",@"content":[basicEntity objectForKey:@"companyName"],@"type":@(CompanyInformationType_necessarily),@"enputType":@(EnPutType_picker)},@{@"title":@"联系方式",@"content":[basicEntity objectForKey:@"contactPhone"],@"type":@(CompanyInformationType_necessarily),@"enputType":@(EnPutType_nomal)},@{@"title":@"联系人",@"content":[basicEntity objectForKey:@"contactPerson"],@"type":@(CompanyInformationType_necessarily),@"enputType":@(EnPutType_nomal)},@{@"title":@"法人电话",@"content":[basicEntity objectForKey:@"legalPhone"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)},@{@"title":@"行业",@"content":[basicEntity objectForKey:@"industry"],@"type":@(CompanyInformationType_necessarily),@"enputType":@(EnPutType_picker)},@{@"title":@"经济性质",@"content":[basicEntity objectForKey:@"economicType"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)},@{@"title":@"企业法人",@"content":[basicEntity objectForKey:@"legalPerson"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)},@{@"title":@"企业负责人",@"content":[basicEntity objectForKey:@"headPerson"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)},@{@"title":@"企业类型",@"content":[basicEntity objectForKey:@"companyType"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_picker)},@{@"title":@"注册地址",@"content":[basicEntity objectForKey:@"regAddress"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)},@{@"title":@"上市类型",@"content":[basicEntity objectForKey:@"listedType"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_picker)},@{@"title":@"注册资本",@"content":[basicEntity objectForKey:@"regMoney"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)}];
    
    self.addressInfoArray = @[@{@"title":@"楼宇名称",@"content":[placeEntity objectForKey:@"buildName"],@"type":@(CompanyInformationType_necessarily),@"enputType":@(EnPutType_nomal)},@{@"title":@"公司面积",@"content":[placeEntity objectForKey:@"companyArea"],@"type":@(CompanyInformationType_necessarily),@"enputType":@(EnPutType_nomal)},@{@"title":@"楼层",@"content":[placeEntity objectForKey:@"floorNo"],@"type":@(CompanyInformationType_necessarily),@"enputType":@(EnPutType_nomal)},@{@"title":@"房间号",@"content":[placeEntity objectForKey:@"roomNo"],@"type":@(CompanyInformationType_necessarily),@"enputType":@(EnPutType_nomal)},@{@"title":@"分区",@"content":[placeEntity objectForKey:@"seatNo"],@"type":@(CompanyInformationType_fenqu),@"enputType":@(EnPutType_nomal)},@{@"title":@"社区",@"content":[placeEntity objectForKey:@"community"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)},@{@"title":@"街道",@"content":[placeEntity objectForKey:@"sliceName"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)}];
    
    self.otherInfoArray = @[@{@"title":@"产权单位",@"content":[otherEntity objectForKey:@"roomMaster"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)},@{@"title":@"产业类型",@"content":[otherEntity objectForKey:@"productType"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_picker)},@{@"title":@"从业人员",@"content":[NSString stringWithFormat:@"%@", [otherEntity objectForKey:@"employNum"]],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)},@{@"title":@"是否空挂户",@"content":[otherEntity objectForKey:@"emptyAccount"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_picker)},@{@"title":@"纳税机构",@"content":[otherEntity objectForKey:@"taxAgency"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_picker)},@{@"title":@"入驻时间",@"content":[otherEntity objectForKey:@"inTime"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)},@{@"title":@"月租金",@"content":[otherEntity objectForKey:@"monthRent"],@"type":@(CompanyInformationType_nomal),@"enputType":@(EnPutType_nomal)}];
    
    [self.dataAarray addObject:self.basicInformationArray];
    [self.dataAarray addObject:self.yingyezhizhaoArray];
    [self.dataAarray addObject:self.addressInfoArray];
    [self.dataAarray addObject:self.otherInfoArray];
    
    
}

#pragma mark - ui
- (void)navigationViewSetup
{
    self.navigationItem.title = @"添加企业";
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BuildDetailTableViewCell class] forCellReuseIdentifier:kAddCompanyTableViewCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (((NSNumber *)self.statusArray[section]).integerValue == MFoldingSectionStateShow) {
        if (section == 0) {
            return self.basicInformationArray.count;
        }else if (section == 1)
        {
            return self.yingyezhizhaoArray.count;
        }else if (section == 2)
        {
            return self.addressInfoArray.count;
        }else if (section == 3)
        {
            return self.otherInfoArray.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuildDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kAddCompanyTableViewCellID forIndexPath:indexPath];
    NSDictionary * infoDic = [[self.dataAarray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell refreshWith:infoDic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 53;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CategorySectionHeadView * view = [[CategorySectionHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) withTag:section];
    
    BOOL currentIsOpen = ((NSNumber *)self.statusArray[section]).boolValue;
    
    MFoldingSectionState state = 0;
    if (currentIsOpen) {
        state = MFoldingSectionStateShow;
    }else
    {
        state = MFoldingSectionStateFlod;
    }
    
    NSDictionary *dic = [self.headerArray objectAtIndex:section];
    view.isChapter = YES;
    [view setupWithBackgroundColor:UIColorFromRGB(0xf7f7f7f7) titleString:[dic objectForKey:@"title"] titleColor:kMainTextColor_100 titleFont:kMainFont descriptionString:@"" descriptionColor:kMainTextColor_100 descriptionFont:[UIFont systemFontOfSize:12] peopleCountString:@"" peopleCountColor:kMainTextColor_100 peopleCountFont:kMainFont arrowImage:[UIImage imageNamed:[dic objectForKey:@"image"]] arrowSelectImage:[UIImage imageNamed:[dic objectForKey:@"selectImage"]] learnImage:[UIImage imageNamed:@"ic_zoom"] learnSelcTImage:[UIImage imageNamed:@"expan"] arrowPosition:MFoldingSectionHeaderArrowPositionLeft sectionState:state];
    view.tapDelegate = self;
    return view;
}

#pragma mark - YUFoldingSectionHeaderDelegate

-(void)MFoldingSectionHeaderTappedAtIndex:(NSInteger)index
{
    BOOL currentIsOpen = ((NSNumber *)self.statusArray[index]).boolValue;
    
    [self.statusArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:!currentIsOpen]];
    
    NSDictionary *dic = [self.headerArray objectAtIndex:index ];
    NSArray *array = [self.dataAarray objectAtIndex:index];
    NSInteger numberOfRow = array.count;
    NSMutableArray *rowArray = [NSMutableArray array];
    if (numberOfRow) {
        for (NSInteger i = 0; i < numberOfRow; i++) {
            [rowArray addObject:[NSIndexPath indexPathForRow:i inSection:index]];
        }
    }
    self.contentOffset_Y = self.tableView.contentOffset.y;
    if (rowArray.count) {
        if (currentIsOpen) {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationNone];
            [UIView animateWithDuration:0.1 animations:^{
                [self.tableView setContentOffset:CGPointMake(0, self.contentOffset_Y) animated:NO];
            }];
            
        }else{
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationNone];
            [UIView animateWithDuration:0.1 animations:^{
                [self.tableView setContentOffset:CGPointMake(0, self.contentOffset_Y) animated:NO];
            }];
        }
    }
    NSLog(@"self.contentTableView 开始刷新");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%.2f",self.tableView.contentOffset.y);
    });
}



@end
