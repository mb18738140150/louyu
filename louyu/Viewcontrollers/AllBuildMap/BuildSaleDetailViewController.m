//
//  BuildSaleDetailViewController.m
//  louyu
//
//  Created by aaa on 2018/11/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BuildSaleDetailViewController.h"

@interface BuildSaleDetailViewController ()

@end

@implementation BuildSaleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationViewSetup];
    
    [self prepareUI];
    
}

- (void)navigationViewSetup
{
    
    self.navigationItem.title = @"招商租售详情";
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
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [self.view addSubview:backView];
    
    NSString * content = [self.infoDic objectForKey:@"info"];
    CGFloat height = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    
    CGFloat scrollHeight = height + 20;
    if (height + 20 > kScreenHeight - kNavigationBarHeight - kStatusBarHeight ) {
        scrollHeight = kScreenHeight - kNavigationBarHeight - kStatusBarHeight;
    }
    
    UIScrollView *backLBView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, scrollHeight)];
    backLBView.backgroundColor = [UIColor whiteColor];
    backLBView.contentSize = CGSizeMake(kScreenWidth, height + 20);
    [self.view addSubview:backLBView];
    
    UILabel * contentLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, height)];
    contentLB.backgroundColor = [UIColor whiteColor];
    contentLB.textColor = kCommonMainTextColor_50;
    contentLB.text = content;
    contentLB.numberOfLines = 0;
    [backLBView addSubview:contentLB];
    
    
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
