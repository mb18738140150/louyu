//
//  CompanySearchTableViewCell.m
//  louyu
//
//  Created by aaa on 2018/11/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CompanySearchTableViewCell.h"

@interface CompanySearchTableViewCell()

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * companyNameLB;
@property (nonatomic, strong)UIImageView * buildImageView;
@property (nonatomic, strong)UILabel * buildNameLB;

@end

@implementation CompanySearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * mainInfo = [infoDic objectForKey:@"placeEntity"];
    NSDictionary * basicInfo = [infoDic objectForKey:@"basicEntity"];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 20, 45, 45)];
    self.iconImageView.image = [UIImage imageNamed:@"ic_build"];
    [self.contentView addSubview:self.iconImageView];
    
    UIView * separeteLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, 50, kScreenWidth - CGRectGetMaxX(self.iconImageView.frame) - 20, 1)];
    separeteLine.backgroundColor = kCommonMainTextColor_200;
    [self.contentView addSubview:separeteLine];
    
    self.companyNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, 20, separeteLine.hd_width, 30)];
    self.companyNameLB.text = [basicInfo objectForKey:@"companyName"];
    self.companyNameLB.textColor = kCommonNavigationBarColor;
    self.companyNameLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.companyNameLB];
    
    self.buildImageView = [[UIImageView alloc]initWithFrame:CGRectMake(separeteLine.hd_x,CGRectGetMaxY(separeteLine.frame) + 10 , 15, 15)];
    self.buildImageView.image = [UIImage imageNamed:@"ic_company_name"];
    [self.contentView addSubview:self.buildImageView];
    
    self.buildNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buildImageView.frame) + 10, separeteLine.hd_y + 1, kScreenWidth -CGRectGetMaxX(self.buildImageView.frame) - 20 , 35)];
    self.buildNameLB.textColor = kCommonMainTextColor_50;
    self.buildNameLB.text = [mainInfo objectForKey:@"buildName"];
    self.buildNameLB.font = kMainFont;
    [self.contentView addSubview:self.buildNameLB];
    
    UIView * bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 3, kScreenWidth, 3)];
    bottomLineView.backgroundColor = UIRGBColor(238, 238, 238);
    [self.contentView addSubview:bottomLineView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
