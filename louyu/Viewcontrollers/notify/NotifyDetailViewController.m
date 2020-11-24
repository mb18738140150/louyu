//
//  NotifyDetailViewController.m
//  louyu
//
//  Created by aaa on 2018/11/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "NotifyDetailViewController.h"

@interface NotifyDetailViewController ()

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * timelLB;
@property (nonatomic, strong)UITextView * contentTextView;

@end

@implementation NotifyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationViewSetup];
    [self prepareUI];
}

#pragma mark - ui
- (void)navigationViewSetup
{
    if (self.notifyListVCType == NotifyListVCType_notify) {
        self.navigationItem.title = @"通知公告详情";
    }else
    {
        self.navigationItem.title = @"政法法规详情";
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareUI
{
    NSString * titleStr = [self.infoDic objectForKey:@"title"];
    float height = [titleStr boundingRectWithSize:CGSizeMake(kScreenWidth - 24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    
    if (height <= 20) {
        height = 20;
    }else
    {
        height = 45;
    }
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(12, 15, kScreenWidth - 24, height)];
    self.titleLB.numberOfLines = 0;
    self.titleLB.text = titleStr;
    [self.view addSubview:self.titleLB];
    
    self.timelLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.titleLB.frame) + 10, self.titleLB.hd_width, 15)];
    self.timelLB.text = [self.infoDic objectForKey:@"createTime"];
    self.timelLB.textColor = kCommonMainTextColor_150;
    self.timelLB.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.timelLB];
    
    UIView * separateLine = [[UIView alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.timelLB.frame) + 10, kScreenWidth - 24, 1)];
    separateLine.backgroundColor = UIRGBColor(184, 184, 184);
    [self.view addSubview:separateLine];
    
    self.contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(separateLine.frame) + 20, kScreenWidth - 24, kScreenHeight - CGRectGetMaxY(separateLine.frame) - 20 - kNavigationBarHeight - kStatusBarHeight)];
    self.contentTextView.font = kMainFont;
    NSAttributedString * attributeStr = [[NSAttributedString alloc] initWithData:[[self.infoDic objectForKey:@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    self.contentTextView.editable = NO;
    self.contentTextView.attributedText = attributeStr;
    [self.view addSubview:self.contentTextView];
    
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
