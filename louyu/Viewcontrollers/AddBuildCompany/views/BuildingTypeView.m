//
//  BuildingTypeView.m
//  louyu
//
//  Created by aaa on 2018/11/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BuildingTypeView.h"

@interface BuildingTypeView()

@property (nonatomic, strong)UIButton * zuoBtn;
@property (nonatomic, strong)UIButton * unitBtn;
@property (nonatomic, strong)UIButton * dongBtn;

@end

@implementation BuildingTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareUI
{
    self.zuoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zuoBtn.frame = CGRectMake(0, 0, self.hd_width / 3, self.hd_height);
    self.zuoBtn.layer.borderWidth = 1;
    self.zuoBtn.layer.borderColor = kCommonMainOringeColor.CGColor;
    [self addSubview:self.zuoBtn];
    
    self.unitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.unitBtn.frame = CGRectMake(self.hd_width / 3 - 1, 0, self.hd_width / 3, self.hd_height);
    self.unitBtn.layer.borderWidth = 1;
    self.unitBtn.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
    [self addSubview:self.unitBtn];
    
    self.dongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dongBtn.frame = CGRectMake(CGRectGetMaxX(self.unitBtn.frame) - 1, 0, self.hd_width / 3, self.hd_height);
    self.dongBtn.layer.borderWidth = 1;
    self.dongBtn.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
    [self addSubview:self.dongBtn];
    
    [self bringSubviewToFront:self.zuoBtn];
    
    [self.zuoBtn setTitle:@"座号" forState:UIControlStateNormal];
    [self.unitBtn setTitle:@"楼号" forState:UIControlStateNormal];
    [self.dongBtn setTitle:@"商业" forState:UIControlStateNormal];
    
    self.zuoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.unitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.dongBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.zuoBtn setTitleColor:kCommonMainOringeColor forState:UIControlStateNormal];
    [self.unitBtn setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
    [self.dongBtn setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
    
    [self.zuoBtn addTarget:self action:@selector(choceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.unitBtn addTarget:self action:@selector(choceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.dongBtn addTarget:self action:@selector(choceAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)choceAction:(UIButton *)button
{
    if ([button isEqual:self.zuoBtn]) {
        self.zuoBtn.layer.borderColor = kCommonMainOringeColor.CGColor;
        self.unitBtn.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
        self.dongBtn.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
        
        [self.zuoBtn setTitleColor:kCommonMainOringeColor forState:UIControlStateNormal];
        [self.unitBtn setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
        [self.dongBtn setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
        
        [self bringSubviewToFront:self.zuoBtn];
    }else if ([button isEqual:self.unitBtn]){
        self.zuoBtn.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
        self.unitBtn.layer.borderColor = kCommonMainOringeColor.CGColor;
        self.dongBtn.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
        
        [self.unitBtn setTitleColor:kCommonMainOringeColor forState:UIControlStateNormal];
        [self.zuoBtn setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
        [self.dongBtn setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
        
        [self bringSubviewToFront:self.unitBtn];
    }else
    {
        self.zuoBtn.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
        self.unitBtn.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
        self.dongBtn.layer.borderColor = kCommonMainOringeColor.CGColor;
        
        [self.dongBtn setTitleColor:kCommonMainOringeColor forState:UIControlStateNormal];
        [self.unitBtn setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
        [self.zuoBtn setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
        
        [self bringSubviewToFront:self.dongBtn];
    }
    if (self.BuildTypeSelectBlick) {
        self.BuildTypeSelectBlick(button.titleLabel.text);
    }
}

- (void)resetBtnEnable:(BOOL)btnEnable
{
    self.zuoBtn.enabled = btnEnable;
    self.unitBtn.enabled = btnEnable;
    self.dongBtn.enabled = btnEnable;
}

- (void)refreshNomal
{
    self.zuoBtn.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
    self.unitBtn.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
    self.dongBtn.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
    
    [self.dongBtn setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
    [self.unitBtn setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
    [self.zuoBtn setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
}

@end
