//
//  LogoutTipView.m
//  louyu
//
//  Created by aaa on 2018/11/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "LogoutTipView.h"

@implementation LogoutTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.4];
    
    UIView * tipView = [[UIView alloc]initWithFrame:CGRectMake(30, (kScreenHeight - 180) / 2, kScreenWidth - 60, 180)];
    tipView.backgroundColor = [UIColor whiteColor];
    tipView.layer.cornerRadius = 10;
    tipView.layer.masksToBounds = YES;
    tipView.clipsToBounds = YES;
    [self addSubview:tipView];
    
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, tipView.hd_width, 20)];
    titleLB.text = @"提示";
    titleLB.textAlignment = NSTextAlignmentCenter;
    [tipView addSubview:titleLB];
    
    UILabel * contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLB.frame) + 45, tipView.hd_width, 20)];
    contentLB.text = @"确定退出账号?";
    contentLB.textAlignment = NSTextAlignmentCenter;
    [tipView addSubview:contentLB];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, tipView.hd_height - 50, tipView.hd_width / 2, 50);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = UIRGBColor(251, 253, 253);
    [tipView addSubview:cancelBtn];
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(tipView.hd_width / 2, tipView.hd_height - 50, tipView.hd_width / 2, 50);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sureBtn.backgroundColor = UIRGBColor(251, 253, 253);
    [tipView addSubview:sureBtn];
    
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancelAction
{
    [self removeFromSuperview];
}

- (void)sureAction
{
    if (self.QuitBlock) {
        self.QuitBlock(YES);
    }
    [self removeFromSuperview];
}

@end
