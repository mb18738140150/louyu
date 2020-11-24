//
//  AllBuildMapViewController.m
//  louyu
//
//  Created by aaa on 2018/11/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AllBuildMapViewController.h"
#import "SearchTFView.h"
#import "CustomAnnotationView.h"
#import "BuildOperationView.h"
#import "ChocePickerView.h"
#import "BuildDetailViewController.h"
#import "BuildNavigationViewController.h"
#import "BuildSaleViewController.h"
#import "BuildCompanyListViewController.h"

@interface AllBuildMapViewController ()<MAMapViewDelegate,UserData_DeleteMyCollectiontextBook, UserData_DeleteMyBookmark, UITextViewDelegate, UserData_MyBookMarkList,UserData_ClearnMyBookmark, UserData_MyQuestionDetail, UserData_SetaHaveReadQuestion>

@property (nonatomic, strong)MAMapView * mapView;
@property (nonatomic, strong)SearchTFView * departmentView;
@property (nonatomic, strong)SearchTFView * typeView;
@property (nonatomic, strong)MKPPlaceholderTextView * keyTV;

@property (nonatomic, strong)NSMutableArray * departmentArray;
@property (nonatomic, strong)NSArray * buildTypeArray;
@property (nonatomic, strong)BuildOperationView * buildOperationView;
@property (nonatomic, strong)ChocePickerView *attendancePickerView;

@property (nonatomic, strong)NSArray * buildLocationArray;
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, strong)NSDictionary * currentSelectBuildInfo;

@property (nonatomic, strong)NSNumber *depareNumberID;
@property (nonatomic, strong)NSString * typeId;
@property (nonatomic, strong)NSString * buildName;
@property (nonatomic, strong)NSDictionary * navigationEndPoint;

@end

@implementation AllBuildMapViewController

- (NSMutableArray *)annotations
{
    if (!_annotations) {
        _annotations = [NSMutableArray array];
    }
    return _annotations;
}

- (NSMutableArray *)departmentArray
{
    if (!_departmentArray) {
        _departmentArray = [NSMutableArray array];
    }
    return _departmentArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self navigationViewSetup];
    
    [self prepareUI];
    
//    [AMapServices sharedServices].enableHTTPS = YES;
}

- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestDepartmentListWithWithDic:@{} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestNavigationEndPointWithWithDic:@{} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestAllBuildLocationWithWithDic:@{@"buildName":@"",
                                                                         @"sliceId":@(0),
                                                                         @"typeId":@"0"} withNotifiedObject:self];
    self.depareNumberID = @0;
    self.typeId = @"0";
    self.buildName = @"";
    self.buildTypeArray = @[@{@"title":@"非纯商务楼宇"},@{@"title":@"纯商务楼宇"}];
}


- (void)navigationViewSetup
{
    self.navigationItem.title = @"全域楼宇";
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
    __weak typeof(self)weakSelf = self;
    UIView * searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    searchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchView];
    
    self.departmentView = [[SearchTFView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.03, 6, kScreenWidth * 0.35, 33)];
    [self.departmentView resetTitle:@"全部部门"];
    [searchView addSubview:self.departmentView];
    
    self.departmentView.ClickBlock = ^(BOOL click) {
        [weakSelf.attendancePickerView appearWithTitle:@"" subTitles:weakSelf.departmentArray selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
            [weakSelf.departmentView resetTitle:pathStr];
            for (NSDictionary * info in weakSelf.departmentArray) {
                if ([[info objectForKey:@"title"] isEqualToString:pathStr]) {
                    weakSelf.depareNumberID = [info objectForKey:@"value"];
                }
            }
            
        } cancleAction:^{
            
        }];;
    };
    
    
    self.typeView = [[SearchTFView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.departmentView.frame) + kScreenWidth * 0.03, self.departmentView.hd_y, kScreenWidth * 0.25, self.departmentView.hd_height)];
    [self.typeView resetTitle:@"全部类型"];
    [searchView addSubview:self.typeView];
    
    self.typeView.ClickBlock = ^(BOOL click) {
        [weakSelf.attendancePickerView appearWithTitle:@"" subTitles:weakSelf.buildTypeArray selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
            [weakSelf.typeView resetTitle:pathStr];
            if ([pathStr isEqualToString:@"非纯商务楼宇"]) {
                weakSelf.typeId = @"0";
            }else
            {
                weakSelf.typeId = @"1";
            }
        } cancleAction:^{
            
        }];;
    };
    
    
    self.keyTV = [[MKPPlaceholderTextView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.7, self.departmentView.hd_y, kScreenWidth * 0.15, self.departmentView.hd_height)];
    self.keyTV.returnKeyType = UIReturnKeyDone;
    self.keyTV.placeholder = @"关键字";
    self.keyTV.layer.cornerRadius = 5;
    self.keyTV.layer.masksToBounds = YES;
    self.keyTV.layer.borderWidth = 1;
    self.keyTV.layer.borderColor = UIRGBColor(218, 218, 218).CGColor;
    self.keyTV.textAlignment = NSTextAlignmentCenter;
    self.keyTV.font = kMainFont;
    self.keyTV.textColor = kCommonMainTextColor_50;
    self.keyTV.delegate = self;
    [searchView addSubview:self.keyTV];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(CGRectGetMaxX(self.keyTV.frame), 0, kScreenWidth - CGRectGetMaxX(self.keyTV.frame), searchView.hd_height);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:kCommonMainColor forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    
    
    
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, searchView.hd_height, kScreenWidth, kScreenHeight - searchView.hd_height)];
    self.mapView = mapView;
    self.mapView.delegate = self;
    [self.view addSubview:mapView];
    
    NSString *path = [NSString stringWithFormat:@"%@/style.data", [NSBundle mainBundle].bundlePath];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.mapView setCustomMapStyleWithWebData:data];
    [self.mapView setCustomMapStyleEnabled:YES];
}

- (ChocePickerView *)attendancePickerView
{
    if (!_attendancePickerView) {
        _attendancePickerView = [[ChocePickerView alloc]initWithFrame:self.view.bounds];
    }
    return _attendancePickerView;
}

- (void)searchAction
{
    [self.keyTV resignFirstResponder];
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestAllBuildLocationWithWithDic:@{@"buildName":self.buildName,
                                                                         @"sliceId":self.depareNumberID,
                                                                         @"typeId":self.typeId} withNotifiedObject:self];
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@", textView.text);
    self.buildName = textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - mapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        
        NSArray * buildLocationArray = [[UserManager sharedManager] getAllBuildLocationArray];
        
        NSUInteger * index = [self.annotations indexOfObject:annotation];
        
        [annotationView.portraitImageView sd_setImageWithURL:[NSURL URLWithString:[[buildLocationArray objectAtIndex:index] objectForKey:@"icon"]]];
        annotationView.name = [[buildLocationArray objectAtIndex:index] objectForKey:@"buildName"];
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
}

- (void)mapView:(MAMapView *)mapView didAnnotationViewTapped:(MAAnnotationView *)view
{
    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
    
    CustomAnnotationView * customView = (CustomAnnotationView *)view;
    
    for (NSDictionary * infoDic in self.buildLocationArray) {
        if ([[infoDic objectForKey:@"buildName"] isEqualToString:customView.name]) {
            self.currentSelectBuildInfo = infoDic;
        }
    }
    
    __weak typeof(self)weakSelf = self;
    self.buildOperationView = [[BuildOperationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.buildOperationView.OperationBlock = ^(NSInteger index) {
        NSLog(@"***** %d *** %@", index, customView.name);
        [weakSelf buildOperation:index andBuildInfo:weakSelf.currentSelectBuildInfo];
        [weakSelf.buildOperationView removeFromSuperview];
    };
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self.buildOperationView];
}

- (void)buildOperation:(NSInteger)index andBuildInfo:(NSDictionary *)buildInfo
{
    switch (index) {
        case 0:
            {
                NSLog(@"楼宇详情");
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestSearchBuildingInfoWithWithDic:@{kbuildName:[buildInfo objectForKey:@"buildName"]} withNotifiedObject:self];
            }
            break;
        case 1:
        {
            NSLog(@"入驻企业");
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestBuildCompanyListWithWithDic:@{kbuildName:[buildInfo objectForKey:@"buildName"],@"seatNo":[buildInfo objectForKey:@"seatNo"],@"floorNo":@"",@"page":@(1)} withNotifiedObject:self];
            
        }
            break;
        case 2:
        {
            NSLog(@"导航指引");
            BuildNavigationViewController * vc = [[BuildNavigationViewController alloc]init];
            vc.startLocationPoint  = [buildInfo objectForKey:@"point"];
            vc.endLocationPoint = [self.navigationEndPoint objectForKey:@"point"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            NSLog(@"招商租售");
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestbuildSaleWithWithDic:@{kbuildName:[buildInfo objectForKey:@"buildName"],@"page":@(1)} withNotifiedObject:self];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - requestDelegate
- (void)didRequestDeleteMyCollectiontextBookSuccessed
{
    [SVProgressHUD dismiss];
    
    [self.departmentArray removeAllObjects];
    
    NSDictionary * infoDic = @{@"title":@"全部部门",@"value":@(0)};
    [self.departmentArray addObject:infoDic];
    
    for (NSDictionary * industryDic in [[UserManager sharedManager] getDepartmentArray]) {
        NSDictionary * infoDic = @{@"title":[industryDic objectForKey:@"name"],@"value":[industryDic objectForKey:@"value"]};
        [self.departmentArray addObject:infoDic];
    }
}

- (void)didRequestDeleteMyCollectiontextBookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


- (void)didRequestDeleteMyBookmarkFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestDeleteMyBookmarkSuccessed
{
    [SVProgressHUD dismiss];
    
    [self.mapView removeAnnotations:self.annotations];
    [self.annotations removeAllObjects];
    self.buildLocationArray = [[UserManager sharedManager] getAllBuildLocationArray];
    
    for (int i = 0; i < self.buildLocationArray.count; ++i)
    {
        NSDictionary * infoDic = [self.buildLocationArray objectAtIndex:i];
        NSString * locationStr = [infoDic objectForKey:@"point"];
        
        float lon = [[[locationStr componentsSeparatedByString:@","] firstObject] floatValue];
        float lat = [[[locationStr componentsSeparatedByString:@","] lastObject] floatValue];
        
        
        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
        a1.coordinate = CLLocationCoordinate2DMake(lat, lon);
        a1.title      = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"buildName"]];
        [self.annotations addObject:a1];
    }
    [self.mapView addAnnotations:self.annotations];
    [self.mapView showAnnotations:self.annotations animated:YES];
}

- (void)didRequestMyBookMarkListSuccessed
{
    [SVProgressHUD dismiss];
    NSDictionary * infoDic = [[[UserManager sharedManager] getBuildArray] firstObject];
    BuildDetailViewController * buildDetailVC = [[BuildDetailViewController alloc]init];
    buildDetailVC.infoDic = infoDic;
    [self.navigationController pushViewController:buildDetailVC animated:YES];
}

- (void)didRequestMyBookMarkListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestClearnMyBookmarkSuccessed
{
    [SVProgressHUD dismiss];
    self.navigationEndPoint = [[UserManager sharedManager] getNavigationEndPoint];
}

- (void)didRequestClearnMyBookmarkFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyQuestionDetailSuccessed
{
    NSLog(@"楼宇内企业");
    [SVProgressHUD dismiss];

    BuildCompanyListViewController * vc = [[BuildCompanyListViewController alloc]init];
    vc.infoDic = self.currentSelectBuildInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didRequestMyQuestionDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestSetaHaveReadQuestionSuccessed
{
    NSLog(@"楼宇招租信息");
    [SVProgressHUD dismiss];
    BuildSaleViewController * vc = [[BuildSaleViewController alloc]init];
    vc.infoDic = self.currentSelectBuildInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didRequestSetaHaveReadQuestionFailed:(NSString *)failedInfo
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
