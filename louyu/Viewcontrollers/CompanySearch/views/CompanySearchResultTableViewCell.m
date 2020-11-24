//
//  CompanySearchResultTableViewCell.m
//  louyu
//
//  Created by aaa on 2018/11/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CompanySearchResultTableViewCell.h"

@interface CompanySearchResultTableViewCell()

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * companyNameLB;
@property (nonatomic, strong)UIImageView * buildImageView;
@property (nonatomic, strong)UILabel * buildNameLB;
@property (nonatomic, strong)UIImageView * addressImageView;
@property (nonatomic, strong)UILabel * addressNameLB;
@property (nonatomic, strong)UIImageView * industryTypeImageView;
@property (nonatomic, strong)UILabel * industryTypeLB;
@property (nonatomic, strong)UIImageView * phoneImageView;
@property (nonatomic, strong)UILabel * phoneLB;
@property (nonatomic, strong)UIImageView * remarkImageView;
@property (nonatomic, strong)UILabel * remarkLB;

@end

@implementation CompanySearchResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView * bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 3)];
    bottomLineView.backgroundColor = UIRGBColor(238, 238, 238);
    [self.contentView addSubview:bottomLineView];
    
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
    
    self.buildNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buildImageView.frame) + 10, CGRectGetMaxY(separeteLine.frame) + 5, kScreenWidth -CGRectGetMaxX(self.buildImageView.frame) - 20 , 25)];
    self.buildNameLB.textColor = kCommonMainTextColor_50;
    self.buildNameLB.text = [mainInfo objectForKey:@"buildName"];
    self.buildNameLB.font = kMainFont;
    [self.contentView addSubview:self.buildNameLB];
    
    self.addressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(separeteLine.hd_x,CGRectGetMaxY(self.buildImageView.frame) + 10 , 15, 15)];
    self.addressImageView.image = [UIImage imageNamed:@"ic_shequ"];
    [self.contentView addSubview:self.addressImageView];
    
    self.addressNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buildImageView.frame) + 10, CGRectGetMaxY(self.buildNameLB.frame), kScreenWidth -CGRectGetMaxX(self.buildImageView.frame) - 20 , 25)];
    self.addressNameLB.textColor = kCommonMainTextColor_50;
    self.addressNameLB.text = [mainInfo objectForKey:@"community"];
    self.addressNameLB.font = kMainFont;
    [self.contentView addSubview:self.addressNameLB];
    
    self.industryTypeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(separeteLine.hd_x,CGRectGetMaxY(self.addressImageView.frame) + 10 , 15, 15)];
    self.industryTypeImageView.image = [UIImage imageNamed:@"ic_type"];
    [self.contentView addSubview:self.industryTypeImageView];
    
    self.industryTypeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buildImageView.frame) + 10, CGRectGetMaxY(self.addressNameLB.frame), kScreenWidth -CGRectGetMaxX(self.buildImageView.frame) - 20 , 25)];
    self.industryTypeLB.textColor = kCommonMainTextColor_50;
    self.industryTypeLB.text = [basicInfo objectForKey:@"industry"];
    self.industryTypeLB.font = kMainFont;
    [self.contentView addSubview:self.industryTypeLB];
    
    self.phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(separeteLine.hd_x,CGRectGetMaxY(self.industryTypeImageView.frame) + 10 , 15, 15)];
    self.phoneImageView.image = [UIImage imageNamed:@"ic_phone"];
    [self.contentView addSubview:self.phoneImageView];
    
    self.phoneLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buildImageView.frame) + 10, CGRectGetMaxY(self.industryTypeLB.frame), kScreenWidth -CGRectGetMaxX(self.buildImageView.frame) - 20 , 25)];
    self.phoneLB.textColor = kCommonMainTextColor_50;
    self.phoneLB.text = [basicInfo objectForKey:@"contactPhone"];
    self.phoneLB.font = kMainFont;
    [self.contentView addSubview:self.phoneLB];
    
    self.remarkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(separeteLine.hd_x,CGRectGetMaxY(self.phoneImageView.frame) + 10 , 15, 15)];
    self.remarkImageView.image = [UIImage imageNamed:@"ic_remark"];
    [self.contentView addSubview:self.remarkImageView];
    
    self.remarkLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buildImageView.frame) + 10, CGRectGetMaxY(self.phoneLB.frame), kScreenWidth -CGRectGetMaxX(self.buildImageView.frame) - 20 , 25)];
    self.remarkLB.textColor = kCommonMainTextColor_50;
    self.remarkLB.text = [basicInfo objectForKey:@"companyTax"];
    self.remarkLB.font = kMainFont;
    [self.contentView addSubview:self.remarkLB];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
