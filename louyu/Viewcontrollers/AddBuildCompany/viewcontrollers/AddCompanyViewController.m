//
//  AddCompanyViewController.m
//  louyu
//
//  Created by aaa on 2018/11/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AddCompanyViewController.h"

#import "AddCompanyTableViewCell.h"
#define kAddCompanyTableViewCellID @"AddCompanyTableViewCell"
#import "AddCompany_scanfTableViewCell.h"
#define kAddCompany_scanfTableViewCellID @"AddCompany_scanfTableViewCell"

#import "ScanQRCodeViewController.h"
#import "ChocePickerView.h"
#import "GSPickerView.h"
#import "BuildSearchViewController.h"

@interface AddCompanyViewController ()<UITableViewDelegate, UITableViewDataSource,MFoldingSectionHeaderDelegate, UserInfo_NotificationNoDisturbConfig,UserData_MyHeadQuestion>

@property (nonatomic, strong)UITableView * tableview;

@property (nonatomic, strong)NSArray * yingyezhizhaoArray;
@property (nonatomic, strong)NSString * companyName;
@property (nonatomic, strong)NSString * legalPerson;
@property (nonatomic, strong)NSString * companyLicense;// 营业执照
@property (nonatomic, strong)NSString * companyCredit;// 信用代码
@property (nonatomic, strong)NSString * companyTax;// 登记证
@property (nonatomic,assign)BOOL isHide;

@property (nonatomic, strong)NSArray * basicInformationArray;
@property (nonatomic, strong)NSString * belongTime;
@property (nonatomic, strong)NSString * contactPhone;// 联系方式
@property (nonatomic, strong)NSString * contactPerson;//
@property (nonatomic, strong)NSString * legalPhone;
@property (nonatomic, strong)NSString * industry;// 行业
@property (nonatomic, strong)NSString * economicType;// 经济性质
@property (nonatomic, strong)NSString * headPerson;// 企业负责人
@property (nonatomic, strong)NSString * companyType;
@property (nonatomic, strong)NSString * regAddress;// 注册地址
@property (nonatomic, strong)NSString * listedType;// 上市类型
@property (nonatomic, strong)NSString * regMoney;// 注册资本

@property (nonatomic, strong)NSArray * addressInfoArray;
@property (nonatomic, strong)NSString * buildName;// 楼宇名称
@property (nonatomic, strong)NSString * companyArea;//
@property (nonatomic, strong)NSString * floorNo;
@property (nonatomic, strong)NSString * roomNo;
@property (nonatomic, strong)NSString * seatNo;
@property (nonatomic, strong)NSString * community; // 社区
@property (nonatomic, strong)NSString * buildTypeStr;

@property (nonatomic, strong)NSArray * otherInfoArray;
@property (nonatomic, strong)NSString * roomMaster;// 产权单位
@property (nonatomic, strong)NSString * productType;// 产业类型
@property (nonatomic, strong)NSString * employNum;// 从业人员
@property (nonatomic, assign)int  emptyAccount;// 是否空挂户
@property (nonatomic, strong)NSString * taxAgency;// 纳税机构
@property (nonatomic, strong)NSString * inTime;// 入驻时间
@property (nonatomic, strong)NSString * monthRent;// 月租金

@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSArray * basicHeadArray;
@property (nonatomic, strong) NSMutableArray *statusArray;
@property (nonatomic, assign)CGFloat contentOffset_Y;

@property (nonatomic, strong)NSArray * imageDataArray;

@property (nonatomic, strong)NSMutableArray * industry_choseArray;
@property (nonatomic, strong)NSArray * companyType_choseArray;
@property (nonatomic, strong)NSArray * listedType_choseArray;
@property (nonatomic, strong)NSArray * productType_choseArray;
@property (nonatomic, strong)NSArray * emptyAccount_choseArray;
@property (nonatomic, strong)NSArray * taxAgency_choseArray;

@property (nonatomic, strong)ChocePickerView *attendancePickerView;
@property (nonatomic, strong)GSPickerView * pickerView;

@end



@implementation AddCompanyViewController

-(NSMutableArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    if (_statusArray.count) {
        if (_statusArray.count > self.tableview.numberOfSections) {
            [_statusArray removeObjectsInRange:NSMakeRange(self.tableview.numberOfSections - 1, _statusArray.count - self.tableview.numberOfSections)];
        }else if (_statusArray.count < self.tableview.numberOfSections) {
            for (NSInteger i = self.tableview.numberOfSections - _statusArray.count; i < self.tableview.numberOfSections; i++) {
                [_statusArray addObject:[NSNumber numberWithInteger:MFoldingSectionStateFlod]];
            }
        }
    }else{
        for (NSInteger i = 0; i < self.tableview.numberOfSections; i++) {
            if (i == 0 || i == 4) {
                [_statusArray addObject:[NSNumber numberWithInteger:MFoldingSectionStateShow]];
            }else
            {
                [_statusArray addObject:[NSNumber numberWithInteger:MFoldingSectionStateFlod]];
            }
        }
    }
    return _statusArray;
}

- (NSMutableArray *)industry_choseArray
{
    if (!_industry_choseArray) {
        _industry_choseArray = [NSMutableArray array];
    }
    return _industry_choseArray;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (GSPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GSPickerView alloc]initWithFrame:self.view.bounds];
    }
    return _pickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self navigationViewSetup];
    [self prepareUI];
}

- (void)loadData
{
    self.companyName = @"";
    self.legalPerson = @"";
    self.companyLicense = @"";
    self.companyCredit = @"";
    self.companyTax = @"";
    
    self.belongTime = @"";
    self.contactPhone = @"";
    self.contactPerson = @"";
    self.legalPhone = @"";
    self.industry = @"";
    self.economicType = @"";
    self.headPerson = @"";
    self.companyType = @"";
    self.regAddress = @"";
    self.listedType = @"";
    self.regMoney = @"";
    
    self.buildName = @"";
    self.companyArea = @"";
    self.floorNo = @"";
    self.roomNo = @"";
    self.seatNo = @"";
    self.community = @"";
    self.buildTypeStr = @"";
    
    self.roomMaster = @"";
    self.productType = @"";
    self.employNum = @"";
    self.taxAgency = @"";
    self.inTime = @"";
    self.monthRent = @"";
    
    NSMutableDictionary * firstInfo = [NSMutableDictionary dictionary];
    [firstInfo setObject:@"" forKey:@"title"];
    [firstInfo setObject:@"" forKey:@"placeHolder"];
    [firstInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [firstInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [firstInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * companyNameInfo = [NSMutableDictionary dictionary];
    [companyNameInfo setObject:@"公司名称" forKey:@"title"];
    [companyNameInfo setObject:@"请填写公司明名称" forKey:@"placeHolder"];
    [companyNameInfo setObject:@(CompanyInformationType_necessarily) forKey:@"type"];
    [companyNameInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [companyNameInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * legalPersonInfo = [NSMutableDictionary dictionary];
    [legalPersonInfo setObject:@"企业法人" forKey:@"title"];
    [legalPersonInfo setObject:@"请填写企业法人" forKey:@"placeHolder"];
    [legalPersonInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [legalPersonInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [legalPersonInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * companyLisenceInfo = [NSMutableDictionary dictionary];
    [companyLisenceInfo setObject:@"营业执照" forKey:@"title"];
    [companyLisenceInfo setObject:@"请填写营业执照" forKey:@"placeHolder"];
    [companyLisenceInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [companyLisenceInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [companyLisenceInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * companyCreditInfo = [NSMutableDictionary dictionary];
    [companyCreditInfo setObject:@"信用代码" forKey:@"title"];
    [companyCreditInfo setObject:@"请填写信用代码" forKey:@"placeHolder"];
    [companyCreditInfo setObject:@(CompanyInformationType_necessarily) forKey:@"type"];
    [companyCreditInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [companyCreditInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * companyTaxInfo = [NSMutableDictionary dictionary];
    [companyTaxInfo setObject:@"登记证" forKey:@"title"];
    [companyTaxInfo setObject:@"请填写登记证" forKey:@"placeHolder"];
    [companyTaxInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [companyTaxInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [companyTaxInfo setObject:@"" forKey:@"content"];
    
    self.yingyezhizhaoArray = @[firstInfo,companyNameInfo,legalPersonInfo,companyLisenceInfo,companyCreditInfo,companyTaxInfo];
    
    
    NSMutableDictionary * belongTimeInfo = [NSMutableDictionary dictionary];
    [belongTimeInfo setObject:@"所属时间" forKey:@"title"];
    [belongTimeInfo setObject:@"请选择所属时间" forKey:@"placeHolder"];
    [belongTimeInfo setObject:@(CompanyInformationType_necessarily) forKey:@"type"];
    [belongTimeInfo setObject:@(EnPutType_picker) forKey:@"enputType"];
    [belongTimeInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * contackPhoneInfo = [NSMutableDictionary dictionary];
    [contackPhoneInfo setObject:@"联系方式" forKey:@"title"];
    [contackPhoneInfo setObject:@"请填写联系方式" forKey:@"placeHolder"];
    [contackPhoneInfo setObject:@(CompanyInformationType_necessarily) forKey:@"type"];
    [contackPhoneInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [contackPhoneInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * contackPersonInfo = [NSMutableDictionary dictionary];
    [contackPersonInfo setObject:@"联系人" forKey:@"title"];
    [contackPersonInfo setObject:@"请填写联系人" forKey:@"placeHolder"];
    [contackPersonInfo setObject:@(CompanyInformationType_necessarily) forKey:@"type"];
    [contackPersonInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [contackPersonInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * legalPhoneInfo = [NSMutableDictionary dictionary];
    [legalPhoneInfo setObject:@"法人电话" forKey:@"title"];
    [legalPhoneInfo setObject:@"请填写法人电话" forKey:@"placeHolder"];
    [legalPhoneInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [legalPhoneInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [legalPhoneInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * industryInfo = [NSMutableDictionary dictionary];
    [industryInfo setObject:@"行业" forKey:@"title"];
    [industryInfo setObject:@"请选择行业" forKey:@"placeHolder"];
    [industryInfo setObject:@(CompanyInformationType_necessarily) forKey:@"type"];
    [industryInfo setObject:@(EnPutType_picker) forKey:@"enputType"];
    [industryInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * economicTypeInfo = [NSMutableDictionary dictionary];
    [economicTypeInfo setObject:@"经济性质" forKey:@"title"];
    [economicTypeInfo setObject:@"请填写经济性质" forKey:@"placeHolder"];
    [economicTypeInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [economicTypeInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [economicTypeInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * headPersonInfo = [NSMutableDictionary dictionary];
    [headPersonInfo setObject:@"企业负责人" forKey:@"title"];
    [headPersonInfo setObject:@"请填写企业负责人" forKey:@"placeHolder"];
    [headPersonInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [headPersonInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [headPersonInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * companyTypeInfo = [NSMutableDictionary dictionary];
    [companyTypeInfo setObject:@"企业类型" forKey:@"title"];
    [companyTypeInfo setObject:@"请选择企业类型" forKey:@"placeHolder"];
    [companyTypeInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [companyTypeInfo setObject:@(EnPutType_picker) forKey:@"enputType"];
    [companyTypeInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * regAddressInfo = [NSMutableDictionary dictionary];
    [regAddressInfo setObject:@"注册地址" forKey:@"title"];
    [regAddressInfo setObject:@"请填写注册地址" forKey:@"placeHolder"];
    [regAddressInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [regAddressInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [regAddressInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * listedTypeInfo = [NSMutableDictionary dictionary];
    [listedTypeInfo setObject:@"上市类型" forKey:@"title"];
    [listedTypeInfo setObject:@"请选择上市类型" forKey:@"placeHolder"];
    [listedTypeInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [listedTypeInfo setObject:@(EnPutType_picker) forKey:@"enputType"];
    [listedTypeInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * regMoneyInfo = [NSMutableDictionary dictionary];
    [regMoneyInfo setObject:@"注册资本" forKey:@"title"];
    [regMoneyInfo setObject:@"请输入注册资本" forKey:@"placeHolder"];
    [regMoneyInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [regMoneyInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [regMoneyInfo setObject:@"" forKey:@"content"];
    
    self.basicInformationArray = @[belongTimeInfo,contackPhoneInfo,contackPersonInfo,legalPhoneInfo,industryInfo,economicTypeInfo,headPersonInfo,companyTypeInfo,regAddressInfo,listedTypeInfo,regMoneyInfo];
    
    
    NSMutableDictionary * buildNameInfo = [NSMutableDictionary dictionary];
    [buildNameInfo setObject:@"楼宇名称" forKey:@"title"];
    [buildNameInfo setObject:@"请选择楼宇名称" forKey:@"placeHolder"];
    [buildNameInfo setObject:@(CompanyInformationType_necessarily) forKey:@"type"];
    [buildNameInfo setObject:@(EnPutType_push) forKey:@"enputType"];
    [buildNameInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * companyAreaInfo = [NSMutableDictionary dictionary];
    [companyAreaInfo setObject:@"公司面积" forKey:@"title"];
    [companyAreaInfo setObject:@"请填写公司面积" forKey:@"placeHolder"];
    [companyAreaInfo setObject:@(CompanyInformationType_necessarily) forKey:@"type"];
    [companyAreaInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [companyAreaInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * floorNoInfo = [NSMutableDictionary dictionary];
    [floorNoInfo setObject:@"楼层" forKey:@"title"];
    [floorNoInfo setObject:@"请填写楼层" forKey:@"placeHolder"];
    [floorNoInfo setObject:@(CompanyInformationType_necessarily) forKey:@"type"];
    [floorNoInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [floorNoInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * roomNoInfo = [NSMutableDictionary dictionary];
    [roomNoInfo setObject:@"房间号" forKey:@"title"];
    [roomNoInfo setObject:@"房间号" forKey:@"placeHolder"];
    [roomNoInfo setObject:@(CompanyInformationType_necessarily) forKey:@"type"];
    [roomNoInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [roomNoInfo setObject:@"" forKey:@"content"];

    NSMutableDictionary * seatNoInfo = [NSMutableDictionary dictionary];
    [seatNoInfo setObject:@"分区" forKey:@"title"];
    [seatNoInfo setObject:@"请填写" forKey:@"placeHolder"];
    [seatNoInfo setObject:@(CompanyInformationType_fenqu) forKey:@"type"];
    [seatNoInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [seatNoInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * communityInfo = [NSMutableDictionary dictionary];
    [communityInfo setObject:@"社区" forKey:@"title"];
    [communityInfo setObject:@"请填写社区" forKey:@"placeHolder"];
    [communityInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [communityInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [communityInfo setObject:@"" forKey:@"content"];
    
    self.addressInfoArray = @[buildNameInfo,companyAreaInfo,floorNoInfo,roomNoInfo,seatNoInfo,communityInfo];
    
    
    NSMutableDictionary * roomMasterInfo = [NSMutableDictionary dictionary];
    [roomMasterInfo setObject:@"产权单位" forKey:@"title"];
    [roomMasterInfo setObject:@"请填写产权单位" forKey:@"placeHolder"];
    [roomMasterInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [roomMasterInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [roomMasterInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * productTypeInfo = [NSMutableDictionary dictionary];
    [productTypeInfo setObject:@"产业类型" forKey:@"title"];
    [productTypeInfo setObject:@"请选择产业类型" forKey:@"placeHolder"];
    [productTypeInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [productTypeInfo setObject:@(EnPutType_picker) forKey:@"enputType"];
    [productTypeInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * employNumInfo = [NSMutableDictionary dictionary];
    [employNumInfo setObject:@"从业人员" forKey:@"title"];
    [employNumInfo setObject:@"请填写从业人员数量" forKey:@"placeHolder"];
    [employNumInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [employNumInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [employNumInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * emptyAccountInfo = [NSMutableDictionary dictionary];
    [emptyAccountInfo setObject:@"是否空挂户" forKey:@"title"];
    [emptyAccountInfo setObject:@"请选择是否空挂户" forKey:@"placeHolder"];
    [emptyAccountInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [emptyAccountInfo setObject:@(EnPutType_picker) forKey:@"enputType"];
    [emptyAccountInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * taxAgencyInfo = [NSMutableDictionary dictionary];
    [taxAgencyInfo setObject:@"纳税机构" forKey:@"title"];
    [taxAgencyInfo setObject:@"请选择纳税机构" forKey:@"placeHolder"];
    [taxAgencyInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [taxAgencyInfo setObject:@(EnPutType_picker) forKey:@"enputType"];
    [taxAgencyInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * inTimeInfo = [NSMutableDictionary dictionary];
    [inTimeInfo setObject:@"入驻时间" forKey:@"title"];
    [inTimeInfo setObject:@"请填写入驻时间" forKey:@"placeHolder"];
    [inTimeInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [inTimeInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [inTimeInfo setObject:@"" forKey:@"content"];
    
    NSMutableDictionary * monthRentInfo = [NSMutableDictionary dictionary];
    [monthRentInfo setObject:@"月租金" forKey:@"title"];
    [monthRentInfo setObject:@"请填写月租金" forKey:@"placeHolder"];
    [monthRentInfo setObject:@(CompanyInformationType_nomal) forKey:@"type"];
    [monthRentInfo setObject:@(EnPutType_nomal) forKey:@"enputType"];
    [monthRentInfo setObject:@"" forKey:@"content"];
    
    self.otherInfoArray = @[roomMasterInfo,productTypeInfo,employNumInfo,emptyAccountInfo,taxAgencyInfo,inTimeInfo,monthRentInfo];
    
    [self.dataArray addObject:self.yingyezhizhaoArray];
    [self.dataArray addObject:self.basicInformationArray];
    [self.dataArray addObject:self.addressInfoArray];
    [self.dataArray addObject:self.otherInfoArray];
    
    self.basicHeadArray = @[@{@"title":@"营业执照"},@{@"title":@"基本信息"},@{@"title":@"地址信息"},@{@"title":@"其他信息"}];
    
    self.imageDataArray = @[@{@"image":@"ic_license_normal",@"selectImage":@"ic_license_select"},@{@"image":@"ic_base_infor_normal",@"selectImage":@"ic_base_infor"},@{@"image":@"ic_location_normal",@"selectImage":@"ic_location_select"},@{@"image":@"ic_qi_infor_normal",@"selectImage":@"ic_qi_infor_select"}];
    
//    self.industry_choseArray = @[@{@"title":@"A 农、林、牧、渔业"},@{@"title":@"B 采矿业"},@{@"title":@"C 制造业"},@{@"title":@"D 电力、热力、燃气及水生产和供应业"},@{@"title":@"E 建筑业"},@{@"title":@"F 批发和零售业"},@{@"title":@"G 交通运输、仓储和邮政业"},@{@"title":@"H 住宿和餐饮业"},@{@"title":@"I 信息传输、软件和信息技术服务业"},@{@"title":@"J 金融业"},@{@"title":@"K 房地产业"},@{@"title":@"L 租赁和商务服务业"},@{@"title":@"M 科学研究和技术服务业"},@{@"title":@"N 水利、环境和公共设施管理业"},@{@"title":@"O 居民服务、修理和其他服务业"},@{@"title":@"P 教育"},@{@"title":@"Q 卫生和社会工作"},@{@"title":@"R 文化、体育和娱乐业"},@{@"title":@"S 公共管理、社会保障和社会组织"},@{@"title":@"T 国际组织"}];
    [self.industry_choseArray removeAllObjects];
    for (NSDictionary * industryDic in [[UserManager sharedManager]getAllBuildTypeArray]) {
        NSDictionary * infoDic = @{@"title":[industryDic objectForKey:@"name"]};
        [self.industry_choseArray addObject:infoDic];
    }
    
    
    self.companyType_choseArray = @[@{@"title":@"A、世界500强（总部、区域总部、智能型总部等）"},@{@"title":@"B、国内500强企业"},@{@"title":@"C、省内10强企业"},@{@"title":@"D、民营100强企业"},@{@"title":@"E、行业100强企业"},@{@"title":@"F、上市公司总或分支机构"},@{@"title":@"G、在本区以外有三个以上分支机构的连锁经营企业"},@{@"title":@"H、其他"}];
    
    self.listedType_choseArray = @[@{@"title":@"A、主板上市企业"},@{@"title":@"B、新三板上市企业"},@{@"title":@"C、非上市企业"}];
    
    self.productType_choseArray = @[@{@"title":@"第一产业"},@{@"title":@"第二产业"},@{@"title":@"第三产业"}];
    
    self.emptyAccount_choseArray = @[@{@"title":@"否"},@{@"title":@"是"}];
    
    self.taxAgency_choseArray = @[@{@"title":@"A、区内"},@{@"title":@"A、区内"},@{@"title":@"B、省直"},@{@"title":@"C、市直"},@{@"title":@"D、涉外"},@{@"title":@"E、区外"},@{@"title":@"F、其他"}];
    
    [[UserManager sharedManager] didRequestAllBuildTypeListWithWithDic:@{} withNotifiedObject:self];
}

- (ChocePickerView *)attendancePickerView
{
    if (!_attendancePickerView) {
        _attendancePickerView = [[ChocePickerView alloc]initWithFrame:self.view.bounds];
    }
    return _attendancePickerView;
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
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)prepareUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerClass:[AddCompanyTableViewCell class] forCellReuseIdentifier:kAddCompanyTableViewCellID];
    [self.tableview registerClass:[AddCompany_scanfTableViewCell class] forCellReuseIdentifier:kAddCompany_scanfTableViewCellID];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:self.tableview];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (((NSNumber *)self.statusArray[section]).integerValue == MFoldingSectionStateShow) {
        if (section == 0) {
            if (self.isHide) {
                return 1;
            }else
            {
                return self.yingyezhizhaoArray.count;
            }
        }else if (section == 1)
        {
            return self.basicInformationArray.count;
        }else if (section == 2)
        {
            return self.addressInfoArray.count;
        }else if (section == 3)
        {
            return self.otherInfoArray.count;
        }else
        {
            return 0;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (indexPath.section == 0 && indexPath.row == 0) {
        AddCompany_scanfTableViewCell * scanCell = [tableView dequeueReusableCellWithIdentifier:kAddCompany_scanfTableViewCellID forIndexPath:indexPath];
        
        [scanCell refreshWithInfoDic:@{} andIsFold:self.isHide];
        scanCell.FoldActionBlock = ^(BOOL fold) {
            weakSelf.isHide = fold;
            [weakSelf.tableview reloadData];
        };
        scanCell.ScanfActionBlock = ^(BOOL scanf) {
            ScanQRCodeViewController * zbarVC = [[ScanQRCodeViewController alloc]init];
            zbarVC.ScanComplateBlock = ^(NSDictionary *infoDic) {
                weakSelf.companyName = [infoDic objectForKey:@"companyName"];
                weakSelf.legalPerson = [infoDic objectForKey:@"legalPerson"];
                weakSelf.companyCredit = [infoDic objectForKey:@"companyCredit"];
                AddCompanyTableViewCell * companyNameCell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                AddCompanyTableViewCell * legalPersonCell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                AddCompanyTableViewCell * companyCreditCell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
                [companyNameCell refreshContent:weakSelf.companyName];
                [companyCreditCell refreshContent:weakSelf.companyCredit];
                [legalPersonCell refreshContent:weakSelf.legalPerson];
                
                NSMutableDictionary * mInfo = [[self.dataArray objectAtIndex:0] objectAtIndex:1];
                [mInfo setObject:weakSelf.companyName forKey:@"content"];
                
                NSMutableDictionary * mInfo1 = [[self.dataArray objectAtIndex:0] objectAtIndex:2];
                [mInfo1 setObject:weakSelf.legalPerson forKey:@"content"];
                
                NSMutableDictionary * mInfo2 = [[self.dataArray objectAtIndex:0] objectAtIndex:4];
                [mInfo2 setObject:weakSelf.companyCredit forKey:@"content"];
                
            };
            [weakSelf.navigationController pushViewController:zbarVC animated:YES];
        };
        return scanCell;
    }
    if (indexPath.section == 4) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        [cell.contentView removeAllSubviews];
        UIButton * complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        complateBtn.frame = CGRectMake(15, 15, kScreenWidth - 24, 40);
        [complateBtn setTitle:@"确定" forState:UIControlStateNormal];
        complateBtn.layer.cornerRadius = 5;
        complateBtn.layer.masksToBounds = YES;
        complateBtn.backgroundColor = kCommonMainColor;
        [complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:complateBtn];
        
        return cell;
    }
    
    AddCompanyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kAddCompanyTableViewCellID forIndexPath:indexPath];
    NSDictionary * infoDic = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell refreshWith:infoDic];
    
    cell.InformationChangeBlock = ^(NSString *information) {
        [weakSelf refreshInformation:indexPath and:information];
    };
    cell.ChoceInformationChangeBlock = ^(NSDictionary *info) {
        [weakSelf choceInformation:indexPath];
    };
    cell.BuildTypeSelectBlick = ^(NSString *buildTypeStr) {
        weakSelf.buildTypeStr = buildTypeStr;
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 100;
    }
    if (indexPath.section == 4) {
        return 55;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 53;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 4) {
        UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 53)];
        headView.backgroundColor = [UIColor whiteColor];
        
        UIButton * complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        complateBtn.frame = CGRectMake(15, 15, kScreenWidth - 24, 40);
        [complateBtn setTitle:@"确定" forState:UIControlStateNormal];
        complateBtn.layer.cornerRadius = 5;
        complateBtn.layer.masksToBounds = YES;
        [headView addSubview:complateBtn];
        [complateBtn addTarget:self action:@selector(ComplateAction) forControlEvents:UIControlEventTouchUpInside];
        complateBtn.backgroundColor = kCommonMainColor;
        [complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        return headView;
    }
    
    CategorySectionHeadView * view = [[CategorySectionHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) withTag:section];
    
    BOOL currentIsOpen = ((NSNumber *)self.statusArray[section]).boolValue;
    
    MFoldingSectionState state = 0;
    if (currentIsOpen) {
        state = MFoldingSectionStateShow;
    }else
    {
        state = MFoldingSectionStateFlod;
    }
    
    NSDictionary *dic = [self.basicHeadArray objectAtIndex:section];
    NSDictionary * imageInfoDic = [self.imageDataArray objectAtIndex:section];
    view.isChapter = YES;
    [view setupWithBackgroundColor:UIColorFromRGB(0xf7f7f7f7) titleString:[dic objectForKey:@"title"] titleColor:kMainTextColor_100 titleFont:kMainFont descriptionString:@"" descriptionColor:kMainTextColor_100 descriptionFont:[UIFont systemFontOfSize:12] peopleCountString:@"" peopleCountColor:kMainTextColor_100 peopleCountFont:kMainFont arrowImage:[UIImage imageNamed:[imageInfoDic objectForKey:@"image"]] arrowSelectImage:[UIImage imageNamed:[imageInfoDic objectForKey:@"selectImage"]] learnImage:[UIImage imageNamed:@"ic_zoom"] learnSelcTImage:[UIImage imageNamed:@"expan"] arrowPosition:MFoldingSectionHeaderArrowPositionLeft sectionState:state];
    view.tapDelegate = self;
    return view;
}


- (void)refreshInformation:(NSIndexPath *)indexpath and:(NSString *)information
{
    NSMutableDictionary * mInfo = [[self.dataArray objectAtIndex:indexpath.section] objectAtIndex:indexpath.row];
    [mInfo setObject:information forKey:@"content"];
    switch (indexpath.section) {
        case 0:
            {
                switch (indexpath.row) {
                    case 1:
                        {
                            self.companyName = information;
                        }
                        break;
                    case 2:
                    {
                        self.legalPerson = information;
                    }
                        break;
                    case 3:
                    {
                        self.companyLicense = information;
                    }
                        break;
                    case 4:
                    {
                        self.companyCredit = information;
                    }
                        break;
                    case 5:
                    {
                        self.companyTax = information;
                    }
                        break;
                        
                    default:
                        break;
                }
            }
            break;
        case 1:
        {
            switch (indexpath.row) {
                case 1:
                {
                    self.contactPhone = information;
                }
                    break;
                case 2:
                {
                    self.contactPerson = information;
                }
                    break;
                case 3:
                {
                    self.legalPhone = information;
                }
                    break;
                case 5:
                {
                    self.economicType = information;
                }
                    break;
                case 6:
                {
                    self.headPerson = information;
                }
                    break;
                case 8:
                {
                    self.regAddress = information;
                }
                    break;
                case 10:
                {
                    self.regMoney = information;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexpath.row) {
                case 0:
                {
                    NSLog(@"选择楼宇名称");
                }
                    break;
                case 1:
                    {
                        self.companyArea = information;
                    }
                    break;
                case 2:
                {
                    self.floorNo = information;
                }
                    break;
                case 3:
                {
                    self.roomNo = information;
                }
                    break;
                case 4:
                {
                    self.seatNo = information;
                }
                    break;
                case 5:
                {
                    self.community = information;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexpath.row) {
                case 0:
                {
                    self.roomMaster = information;
                }
                    break;
                case 2:
                {
                    self.employNum = information;
                }
                    break;
                case 5:
                {
                    self.inTime = information;
                }
                    break;
                case 6:
                {
                    self.monthRent = information;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)choceInformation:(NSIndexPath *)indexpath
{
    NSMutableDictionary * mInfo = [[self.dataArray objectAtIndex:indexpath.section] objectAtIndex:indexpath.row];
    
    AddCompanyTableViewCell * cell = [self.tableview cellForRowAtIndexPath:indexpath];
    __weak typeof(self)weakSelf = self;
    __weak typeof(cell)weakCell = cell;
    
    
    switch (indexpath.section) {
        case 1:
        {
            switch (indexpath.row) {
                case 0:
                    {
                        NSLog(@"所属时间");
                        
                        __weak typeof(self)weakSelf = self;
                        [self.pickerView appearWithTitle:@"选择日期(北京时间)" pickerType:GSPickerTypeDatePicker subTitles:nil selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
                            
                            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
                            formatter.dateFormat = @"yyyy-MM-dd";
                            
                            NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
                            formatter1.dateFormat = @"yyyy年MM月dd日";
                            
                            NSDate * date = [formatter1 dateFromString:pathStr];
                            NSString * currentDateStr = [formatter stringFromDate:date];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [weakCell refreshContent:currentDateStr];
                                weakSelf.belongTime = currentDateStr;
                                [mInfo setObject:currentDateStr forKey:@"content"];
                            });
                            
                            [weakSelf.pickerView removeFromSuperview];
                            
                        } cancleAction:^{
                            
                        }];
                        
                    }
                    break;
                case 4:
                {
                    
                    [self.attendancePickerView appearWithTitle:@"" subTitles:self.industry_choseArray selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
                        [weakCell refreshContent:pathStr];
                        weakSelf.industry = pathStr;
                        [mInfo setObject:pathStr forKey:@"content"];
                    } cancleAction:^{
                        
                    }];
                    
                }
                    break;
                case 7:
                {
                    [self.attendancePickerView appearWithTitle:@"" subTitles:self.companyType_choseArray selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
                        [weakCell refreshContent:pathStr];
                        weakSelf.companyType = pathStr;
                        [mInfo setObject:pathStr forKey:@"content"];
                    } cancleAction:^{
                        
                    }];
                    
                }
                    break;
                case 9:
                {
                    [self.attendancePickerView appearWithTitle:@"" subTitles:self.listedType_choseArray selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
                        [weakCell refreshContent:pathStr];
                        weakSelf.listedType = pathStr;
                        [mInfo setObject:pathStr forKey:@"content"];
                    } cancleAction:^{
                        
                    }];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexpath.row) {
                case 0:
                    {
                        BuildSearchViewController * buildVc = [[BuildSearchViewController alloc]init];
                        buildVc.isGetBuildName = YES;
                        buildVc.GetBuildNameBlock = ^(NSString *buildName) {
                            [weakCell refreshContent:buildName];
                            weakSelf.buildName = buildName;
                            [mInfo setObject:buildName forKey:@"content"];
                        };
                        [self.navigationController pushViewController:buildVc animated:YES];
                    }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexpath.row) {
                case 1:
                {
                    [self.attendancePickerView appearWithTitle:@"" subTitles:self.productType_choseArray selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
                        [weakCell refreshContent:pathStr];
                        weakSelf.productType = pathStr;
                        [mInfo setObject:pathStr forKey:@"content"];
                    } cancleAction:^{
                        
                    }];
                }
                    break;
                case 3:
                {
                    
                    [self.attendancePickerView appearWithTitle:@"" subTitles:self.emptyAccount_choseArray selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
                        [weakCell refreshContent:pathStr];
                        [mInfo setObject:pathStr forKey:@"content"];
                        if ([pathStr isEqualToString:@"是"]) {
                            weakSelf.emptyAccount = 1;
                        }else
                        {
                            weakSelf.emptyAccount = 0;
                        }
                    } cancleAction:^{
                        
                    }];
                }
                    break;
                case 4:
                {
                    
                    [self.attendancePickerView appearWithTitle:@"" subTitles:self.taxAgency_choseArray selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
                        [cell refreshContent:pathStr];
                        self.taxAgency = pathStr;
                        [mInfo setObject:pathStr forKey:@"content"];
                    } cancleAction:^{
                        
                    }];
                }
                    break;
                
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)ComplateAction
{
    if (self.companyName.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"公司名称不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (self.companyCredit.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"信用代码不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (self.belongTime.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"所属时间不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (self.contactPhone.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"联系电话不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (self.contactPerson.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"联系人不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (self.industry.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"行业不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    self.buildName = @"zhongtianhangkongdasha";
    if (self.buildName.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"楼宇名称不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (self.companyArea.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"公司面积不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (self.floorNo.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"楼层不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (self.roomNo.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"房间号不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    
    
    NSDictionary *dic = @{
                          @"sliceId":@([[UserManager sharedManager] getSliceId]),
                          kbuildName:self.buildName,
                          @"seatNo":self.seatNo,
                          @"community":self.community,
                          @"companyArea":self.companyArea,
                          @"industry":self.industry,
                          @"companyName":self.companyName,
                          @"belongTime":self.belongTime,
                          @"companyLicense":self.companyLicense,
                          @"companyTax":self.companyTax,
                          @"companyCredit":self.companyCredit,
                          @"regAddress":self.regAddress,
                          @"economicType":self.economicType,
                          @"legalPerson":self.legalPerson,
                          @"headPerson":self.headPerson,
                          @"legalPhone":self.legalPhone,
                          @"taxAgency":self.taxAgency,
                          @"emptyAccount":[NSString stringWithFormat:@"%d", self.emptyAccount],
                          @"productType":self.productType,
                          @"inTime":self.inTime,
                          @"roomMaster":self.roomMaster,
                          @"floorNo":self.floorNo,
                          @"roomNo":self.roomNo,
                          @"employNum":self.employNum,
                          @"monthRent":self.monthRent,
                          @"companyType":self.companyType,
                          @"listedType":self.listedType,
                          @"contactPerson":self.contactPerson,
                          @"contactPhone":self.contactPhone,
                          @"regMoney":self.regMoney,
                          };
    
    NSLog(@"addCompany = %@", dic);
    
    [[UserManager sharedManager] didRequestAddCompanyWithWithDic:dic withNotifiedObject:self];
}

- (void)didRequestNotificationNoDisturbConfigSuccessed
{
    [SVProgressHUD showSuccessWithStatus:@"添加成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestNotificationNoDisturbConfigFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - YUFoldingSectionHeaderDelegate

-(void)MFoldingSectionHeaderTappedAtIndex:(NSInteger)index
{
    BOOL currentIsOpen = ((NSNumber *)self.statusArray[index]).boolValue;
    
    [self.statusArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:!currentIsOpen]];
    
    NSDictionary *dic = [self.basicHeadArray objectAtIndex:index ];
    NSArray *array = [self.dataArray objectAtIndex:index];
    NSInteger numberOfRow = array.count;
    NSMutableArray *rowArray = [NSMutableArray array];
    if (numberOfRow) {
        for (NSInteger i = 0; i < numberOfRow; i++) {
            [rowArray addObject:[NSIndexPath indexPathForRow:i inSection:index]];
        }
    }
    self.contentOffset_Y = self.tableview.contentOffset.y;
    if (rowArray.count) {
        if (currentIsOpen) {
            [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationNone];
            [UIView animateWithDuration:0.1 animations:^{
                [self.tableview setContentOffset:CGPointMake(0, self.contentOffset_Y) animated:NO];
            }];
            
        }else{
            [self.tableview insertRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationNone];
            [UIView animateWithDuration:0.1 animations:^{
                [self.tableview setContentOffset:CGPointMake(0, self.contentOffset_Y) animated:NO];
            }];
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%.2f",self.tableview.contentOffset.y);
    });
}

- (void)didRequestMyHeadQuestionSuccessed
{
    [SVProgressHUD dismiss];
    if (self.industry_choseArray.count <= 0) {
        [self.industry_choseArray removeAllObjects];
        for (NSDictionary * industryDic in [[UserManager sharedManager]getAllBuildTypeArray]) {
            NSDictionary * infoDic = @{@"title":[industryDic objectForKey:@"name"]};
            [self.industry_choseArray addObject:infoDic];
        }
    }
}

- (void)didRequestMyHeadQuestionFailed:(NSString *)failedInfo
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
