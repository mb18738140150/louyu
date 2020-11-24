//
//  BasicCategoryView.m
//  qianshutang
//
//  Created by aaa on 2018/7/16.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicCategoryView.h"

@implementation BasicCategoryView

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)infoDic
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI:infoDic];
    }
    return self;
}

- (void)prepareUI:(NSDictionary *)infoDic
{
//    self.backgroundColor = [UIColor whiteColor];
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width / 4, 5, self.hd_width / 2, self.hd_width / 2)];
    [self addSubview:self.iconImageView];
    
    self.headLB = [[UILabel alloc]initWithFrame:self.iconImageView.frame];
    self.headLB.font = [UIFont systemFontOfSize:24];
    self.headLB.textAlignment = NSTextAlignmentCenter;
    self.headLB.hidden = YES;
    [self addSubview:self.headLB];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame) + 10, self.hd_width, self.hd_height - self.hd_width / 2 - 15)];
    CGFloat fontsize = (self.hd_height - self.hd_width) * 0.7;
    if (fontsize < 10) {
        fontsize = 10;
    }
    self.titleLB.font = kMainFont;
    if (kScreenWidth <= 375) {
        self.titleLB.font = [UIFont systemFontOfSize:12];
    }
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLB];
    
    self.clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clickBtn.frame = CGRectMake(0, 0, self.hd_width, self.hd_height);
    [self.clickBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.clickBtn];
    
    self.iconImageView.image = [UIImage imageNamed:[infoDic objectForKey:@"imageStr"]];
    self.titleLB.text = [infoDic objectForKey:@"title"];
    
    self.type = [[infoDic objectForKey:@"type"] integerValue];
}

- (void)resetTitleColor:(UIColor *)color
{
    self.titleLB.textColor = color;
}

- (void)resetIconImageView:(NSString *)iconStr
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconStr] placeholderImage:[UIImage imageNamed:@""]];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)resetTitle:(NSString *)title
{
    self.titleLB.text = title;
}

- (void)clickAction
{
    if (self.ClickBlock) {
        self.ClickBlock(self.type);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
