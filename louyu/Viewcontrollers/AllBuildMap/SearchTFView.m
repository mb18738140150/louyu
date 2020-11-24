//
//  SearchTFView.m
//  louyu
//
//  Created by aaa on 2018/11/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "SearchTFView.h"

@interface SearchTFView()

@property (nonatomic, strong)UIImageView * arrow_downImageView;
@property (nonatomic, strong)UIButton * titleBtn;

@end


@implementation SearchTFView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = UIRGBColor(218, 218, 218).CGColor;
    
    self.arrow_downImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width - 15, 6, 15, 15)];
    self.arrow_downImageView.image = [UIImage imageNamed:@"arrow_down"];
    [self addSubview:self.arrow_downImageView];
    
    self.titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.titleBtn.frame = CGRectMake(5, 3, self.hd_width - 25, self.hd_height - 6);
    [self.titleBtn setTitleColor:kCommonMainTextColor_50 forState:UIControlStateNormal];
    [self.titleBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    self.titleBtn.titleLabel.font = kMainFont;
    [self addSubview:self.titleBtn];
    
}

- (void)clickAction
{
    if (self.ClickBlock) {
        self.ClickBlock(YES);
    }
}

- (void)resetTitle:(NSString *)str
{
    [self.titleBtn setTitle:str forState:UIControlStateNormal];
}

@end
