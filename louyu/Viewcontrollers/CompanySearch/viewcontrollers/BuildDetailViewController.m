//
//  BuildDetailViewController.m
//  louyu
//
//  Created by aaa on 2018/11/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BuildDetailViewController.h"


#import "BuildDetailTableViewCell.h"
#define kAddCompanyTableViewCellID @"BuildDetailTableViewCell"


@interface BuildDetailViewController ()<UITableViewDelegate, UITableViewDataSource,MFoldingSectionHeaderDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataAarray;
@property (nonatomic, strong)NSArray * headerArray;

@property (nonatomic, strong)NSMutableArray * basicArray;
@property (nonatomic, strong)NSMutableArray * addressArray;
@property (nonatomic, strong)NSMutableArray * wuyeArray;
@property (nonatomic, strong)NSMutableArray * severArray;
@property (nonatomic, strong)NSMutableArray * suitArray;
@property (nonatomic, strong)NSMutableArray * workArray;

@property (nonatomic, strong) NSMutableArray *statusArray;
@property (nonatomic, assign)CGFloat contentOffset_Y;

@end

@implementation BuildDetailViewController

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
            [_statusArray addObject:[NSNumber numberWithInteger:MFoldingSectionStateFlod]];
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
    self.headerArray = @[@{@"title":@"基本信息",@"image":@"ic_base_infor_normal",@"selectImage":@"ic_base_infor"},@{@"title":@"位置信息",@"image":@"ic_location_normal",@"selectImage":@"ic_location_select"},@{@"title":@"物业信息",@"image":@"ic_property_normal",@"selectImage":@"ic_property_select"},@{@"title":@"服务水平",@"image":@"ic_server_normal",@"selectImage":@"ic_server_select"},@{@"title":@"配套环境",@"image":@"ic_suit_normal",@"selectImage":@"ic_suit_select"},@{@"title":@"办公环境",@"image":@"ic_work_normal",@"selectImage":@"ic_work_select"}];
    
    NSDictionary * basicEntity = [self.infoDic objectForKey:@"basicEntity"];
    NSDictionary * placeEntity = [self.infoDic objectForKey:@"placeEntity"];
    NSDictionary * propertyEntity = [self.infoDic objectForKey:@"propertyEntity"];
    NSDictionary * serverEntity = [self.infoDic objectForKey:@"serverEntity"];
    NSDictionary * suitEntity = [self.infoDic objectForKey:@"suitEntity"];
    NSDictionary * workEntity = [self.infoDic objectForKey:@"workEntity"];
    
    self.basicArray = [NSMutableArray array];
    NSMutableDictionary * basicDic1 = [NSMutableDictionary dictionary];
    [basicDic1 setObject:@"楼宇性质" forKey:@"title"];
    [basicDic1 setObject:[basicEntity objectForKey:@"buildType"] forKey:@"content"];
    
    NSMutableDictionary * basicDic2 = [NSMutableDictionary dictionary];
    [basicDic2 setObject:@"所属单位" forKey:@"title"];
    [basicDic2 setObject:[basicEntity objectForKey:@"buildUnit"] forKey:@"content"];
    
    NSMutableDictionary * basicDic3 = [NSMutableDictionary dictionary];
    [basicDic3 setObject:@"投入使用时间" forKey:@"title"];
    [basicDic3 setObject:[basicEntity objectForKey:@"usetime"] forKey:@"content"];
    
    NSMutableDictionary * basicDic4 = [NSMutableDictionary dictionary];
    [basicDic4 setObject:@"占地面积" forKey:@"title"];
    [basicDic4 setObject:[NSString stringWithFormat:@"%@", [basicEntity objectForKey:@"coverArea"]] forKey:@"content"];
    
    NSMutableDictionary * basicDic5 = [NSMutableDictionary dictionary];
    [basicDic5 setObject:@"建筑面积" forKey:@"title"];
    [basicDic5 setObject:[NSString stringWithFormat:@"%@", [basicEntity objectForKey:@"buildArea"]] forKey:@"content"];
    
    NSMutableDictionary * basicDic6 = [NSMutableDictionary dictionary];
    [basicDic6 setObject:@"商务面积" forKey:@"title"];
    [basicDic6 setObject:[NSString stringWithFormat:@"%@", [basicEntity objectForKey:@"merchantArea"]] forKey:@"content"];
    
    NSMutableDictionary * basicDic7 = [NSMutableDictionary dictionary];
    [basicDic7 setObject:@"商业面积" forKey:@"title"];
    [basicDic7 setObject:[NSString stringWithFormat:@"%@", [basicEntity objectForKey:@"businessArea"]] forKey:@"content"];
    
    NSMutableDictionary * basicDic8 = [NSMutableDictionary dictionary];
    [basicDic8 setObject:@"客梯数量" forKey:@"title"];
    [basicDic8 setObject:[NSString stringWithFormat:@"%@", [basicEntity objectForKey:@"personliftNum"]] forKey:@"content"];
    
    NSMutableDictionary * basicDic9 = [NSMutableDictionary dictionary];
    [basicDic9 setObject:@"货梯数量" forKey:@"title"];
    [basicDic9 setObject:[NSString stringWithFormat:@"%@", [basicEntity objectForKey:@"goodliftNum"]] forKey:@"content"];
    
    NSMutableDictionary * basicDic10 = [NSMutableDictionary dictionary];
    [basicDic10 setObject:@"自动扶梯" forKey:@"title"];
    [basicDic10 setObject:[NSString stringWithFormat:@"%@", [basicEntity objectForKey:@"autoliftNum"]] forKey:@"content"];
    
    NSMutableDictionary * basicDic11 = [NSMutableDictionary dictionary];
    [basicDic11 setObject:@"地上车位数" forKey:@"title"];
    [basicDic11 setObject:[NSString stringWithFormat:@"%@", [basicEntity objectForKey:@"aboveparkingNum"]] forKey:@"content"];
    
    NSMutableDictionary * basicDic12 = [NSMutableDictionary dictionary];
    [basicDic12 setObject:@"地下停车位" forKey:@"title"];
    [basicDic12 setObject:[NSString stringWithFormat:@"%@", [basicEntity objectForKey:@"underparkingNum"]] forKey:@"content"];
    
    NSMutableDictionary * basicDic13 = [NSMutableDictionary dictionary];
    [basicDic13 setObject:@"地下停车场面积" forKey:@"title"];
    [basicDic13 setObject:[NSString stringWithFormat:@"%@", [basicEntity objectForKey:@"underparkingArea"]] forKey:@"content"];
    
    [self.basicArray addObject:basicDic1];
    [self.basicArray addObject:basicDic2];
    [self.basicArray addObject:basicDic3];
    [self.basicArray addObject:basicDic4];
    [self.basicArray addObject:basicDic5];
    [self.basicArray addObject:basicDic6];
    [self.basicArray addObject:basicDic7];
    [self.basicArray addObject:basicDic8];
    [self.basicArray addObject:basicDic9];
    [self.basicArray addObject:basicDic10];
    [self.basicArray addObject:basicDic11];
    [self.basicArray addObject:basicDic12];
    [self.basicArray addObject:basicDic13];
    
    
    self.addressArray = [NSMutableArray array];
    
    NSMutableDictionary * addressDic1 = [NSMutableDictionary dictionary];
    [addressDic1 setObject:@"地址" forKey:@"title"];
    [addressDic1 setObject:[placeEntity objectForKey:@"address"] forKey:@"content"];
    
    NSMutableDictionary * addressDic2 = [NSMutableDictionary dictionary];
    [addressDic2 setObject:@"楼宇名称" forKey:@"title"];
    [addressDic2 setObject:[placeEntity objectForKey:@"buildName"] forKey:@"content"];
    
    NSMutableDictionary * addressDic3 = [NSMutableDictionary dictionary];
    [addressDic3 setObject:@"街道" forKey:@"title"];
    [addressDic3 setObject:[placeEntity objectForKey:@"sliceName"] forKey:@"content"];
    
    NSMutableDictionary * addressDic4 = [NSMutableDictionary dictionary];
    [addressDic4 setObject:@"社区" forKey:@"title"];
    [addressDic4 setObject:[placeEntity objectForKey:@"community"] forKey:@"content"];
    
    [self.addressArray addObject:addressDic1];
    [self.addressArray addObject:addressDic2];
    [self.addressArray addObject:addressDic3];
    [self.addressArray addObject:addressDic4];
    
    self.wuyeArray = [NSMutableArray array];
    NSMutableDictionary * wuyeDic1 = [NSMutableDictionary dictionary];
    [wuyeDic1 setObject:@"费用/月" forKey:@"title"];
    [wuyeDic1 setObject:[propertyEntity objectForKey:@"propertyMoney"] forKey:@"content"];
    
    NSMutableDictionary * wuyeDic2 = [NSMutableDictionary dictionary];
    [wuyeDic2 setObject:@"联系人[物业]" forKey:@"title"];
    [wuyeDic2 setObject:[propertyEntity objectForKey:@"propertyPerson"] forKey:@"content"];
    
    NSMutableDictionary * wuyeDic3 = [NSMutableDictionary dictionary];
    [wuyeDic3 setObject:@"联系方式" forKey:@"title"];
    [wuyeDic3 setObject:[propertyEntity objectForKey:@"propertyPhone"] forKey:@"content"];
    
    NSMutableDictionary * wuyeDic4 = [NSMutableDictionary dictionary];
    [wuyeDic4 setObject:@"物业单位" forKey:@"title"];
    [wuyeDic4 setObject:[propertyEntity objectForKey:@"propertyUnit"] forKey:@"content"];
    
    [self.wuyeArray addObject:wuyeDic1];
    [self.wuyeArray addObject:wuyeDic2];
    [self.wuyeArray addObject:wuyeDic3];
    [self.wuyeArray addObject:wuyeDic4];
    
    
    self.severArray = [NSMutableArray array];
    NSMutableDictionary * severDic1 = [NSMutableDictionary dictionary];
    [severDic1 setObject:@"内部环境设施" forKey:@"title"];
    [severDic1 setObject:[serverEntity objectForKey:@"propertyFacilities"] forKey:@"content"];
    
    NSMutableDictionary * severDic2 = [NSMutableDictionary dictionary];
    [severDic2 setObject:@"卫生整洁度" forKey:@"title"];
    [severDic2 setObject:[serverEntity objectForKey:@"propertyHealth"] forKey:@"content"];
    
    NSMutableDictionary * severDic3 = [NSMutableDictionary dictionary];
    [severDic3 setObject:@"楼宇整体外观" forKey:@"title"];
    [severDic3 setObject:[serverEntity objectForKey:@"propertyNice"] forKey:@"content"];
    
    NSMutableDictionary * severDic4 = [NSMutableDictionary dictionary];
    [severDic4 setObject:@"安保服务" forKey:@"title"];
    [severDic4 setObject:[serverEntity objectForKey:@"propertySecurity"] forKey:@"content"];
    
    [self.severArray addObject:severDic1];
    [self.severArray addObject:severDic2];
    [self.severArray addObject:severDic3];
    [self.severArray addObject:severDic4];
    
    
    
    self.suitArray = [NSMutableArray array];
    NSMutableDictionary * suitDic1 = [NSMutableDictionary dictionary];
    [suitDic1 setObject:@"文化设施" forKey:@"title"];
    [suitDic1 setObject:[suitEntity objectForKey:@"frameCulture"] forKey:@"content"];
    
    NSMutableDictionary * suitDic2 = [NSMutableDictionary dictionary];
    [suitDic2 setObject:@"教育设施" forKey:@"title"];
    [suitDic2 setObject:[suitEntity objectForKey:@"frameEducation"] forKey:@"content"];
    
    NSMutableDictionary * suitDic3 = [NSMutableDictionary dictionary];
    [suitDic3 setObject:@"金融服务" forKey:@"title"];
    [suitDic3 setObject:[suitEntity objectForKey:@"frameFinancial"] forKey:@"content"];
    
    NSMutableDictionary * suitDic4 = [NSMutableDictionary dictionary];
    [suitDic4 setObject:@"餐饮设施" forKey:@"title"];
    [suitDic4 setObject:[suitEntity objectForKey:@"frameFood"] forKey:@"content"];
    
    NSMutableDictionary * suitDic5 = [NSMutableDictionary dictionary];
    [suitDic5 setObject:@"交通和停车场" forKey:@"title"];
    [suitDic5 setObject:[suitEntity objectForKey:@"frameTraffic"] forKey:@"content"];
    
    [self.suitArray addObject:suitDic1];
    [self.suitArray addObject:suitDic2];
    [self.suitArray addObject:suitDic3];
    [self.suitArray addObject:suitDic4];
    [self.suitArray addObject:suitDic5];

    
    
    self.workArray = [NSMutableArray array];
    
    NSMutableDictionary * workDic1 = [NSMutableDictionary dictionary];
    [workDic1 setObject:@"楼宇自动控制系统" forKey:@"title"];
    [workDic1 setObject:[workEntity objectForKey:@"BA"] forKey:@"content"];
    
    NSMutableDictionary * workDic2 = [NSMutableDictionary dictionary];
    [workDic2 setObject:@"通讯自动化" forKey:@"title"];
    [workDic2 setObject:[workEntity objectForKey:@"CA"] forKey:@"content"];
    
    NSMutableDictionary * workDic3 = [NSMutableDictionary dictionary];
    [workDic3 setObject:@"消防自动化" forKey:@"title"];
    [workDic3 setObject:[workEntity objectForKey:@"FA"] forKey:@"content"];
    
    NSMutableDictionary * workDic4 = [NSMutableDictionary dictionary];
    [workDic4 setObject:@"办公自动化" forKey:@"title"];
    [workDic4 setObject:[workEntity objectForKey:@"OA"] forKey:@"content"];
    
    NSMutableDictionary * workDic5 = [NSMutableDictionary dictionary];
    [workDic5 setObject:@"安保自动化系统" forKey:@"title"];
    [workDic5 setObject:[workEntity objectForKey:@"SA"] forKey:@"content"];
    
    [self.workArray addObject:workDic1];
    [self.workArray addObject:workDic2];
    [self.workArray addObject:workDic3];
    [self.workArray addObject:workDic4];
    [self.workArray addObject:workDic5];
    
    [self.dataAarray addObject:self.basicArray];
    [self.dataAarray addObject:self.addressArray];
    [self.dataAarray addObject:self.wuyeArray];
    [self.dataAarray addObject:self.severArray];
    [self.dataAarray addObject:self.suitArray];
    [self.dataAarray addObject:self.workArray];
    
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
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (((NSNumber *)self.statusArray[section]).integerValue == MFoldingSectionStateShow) {
        if (section == 0) {
            return self.basicArray.count;
        }else if (section == 1)
        {
            return self.addressArray.count;
        }else if (section == 2)
        {
            return self.wuyeArray.count;
        }else if (section == 3)
        {
            return self.severArray.count;
        }else if (section == 4)
        {
            return self.suitArray.count;
        }else
        {
            return self.workArray.count;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
