//
//  BuildSearchResultTableViewCell.m
//  louyu
//
//  Created by aaa on 2018/11/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BuildSearchResultTableViewCell.h"

@interface BuildSearchResultTableViewCell()

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


@end


@implementation BuildSearchResultTableViewCell

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
    
    NSDictionary * addInfo = [infoDic objectForKey:@"placeEntity"];
    NSDictionary * contactInfo = [infoDic objectForKey:@"propertyEntity"];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 20, 45, 45)];
    self.iconImageView.image = [UIImage imageNamed:@"ic_build"];
    [self.contentView addSubview:self.iconImageView];
    
    UIView * separeteLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, 50, kScreenWidth - CGRectGetMaxX(self.iconImageView.frame) - 20, 1)];
    separeteLine.backgroundColor = kCommonMainTextColor_200;
    [self.contentView addSubview:separeteLine];
    
    self.companyNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, 20, separeteLine.hd_width, 30)];
    self.companyNameLB.text = [addInfo objectForKey:@"buildName"];
    self.companyNameLB.textColor = kCommonNavigationBarColor;
    self.companyNameLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.companyNameLB];
    
    self.buildImageView = [[UIImageView alloc]initWithFrame:CGRectMake(separeteLine.hd_x,CGRectGetMaxY(separeteLine.frame) + 10 , 15, 15)];
    self.buildImageView.image = [UIImage imageNamed:@"ic_company_name"];
    [self.contentView addSubview:self.buildImageView];
    
    self.buildNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buildImageView.frame) + 10, CGRectGetMaxY(separeteLine.frame) + 5, kScreenWidth -CGRectGetMaxX(self.buildImageView.frame) - 20 , 25)];
    self.buildNameLB.textColor = kCommonMainTextColor_50;
    self.buildNameLB.text = [addInfo objectForKey:@"address"];
    self.buildNameLB.font = kMainFont;
    [self.contentView addSubview:self.buildNameLB];
    
    self.addressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(separeteLine.hd_x,CGRectGetMaxY(self.buildImageView.frame) + 10 , 15, 15)];
    self.addressImageView.image = [UIImage imageNamed:@"ic_shequ"];
    [self.contentView addSubview:self.addressImageView];
    
    self.addressNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buildImageView.frame) + 10, CGRectGetMaxY(self.buildNameLB.frame), kScreenWidth -CGRectGetMaxX(self.buildImageView.frame) - 20 , 25)];
    self.addressNameLB.textColor = kCommonMainTextColor_50;
    self.addressNameLB.text = [addInfo objectForKey:@"community"];
    self.addressNameLB.font = kMainFont;
    [self.contentView addSubview:self.addressNameLB];
    
    self.industryTypeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(separeteLine.hd_x,CGRectGetMaxY(self.addressImageView.frame) + 10 , 15, 15)];
    self.industryTypeImageView.image = [UIImage imageNamed:@"ic_person"];
    [self.contentView addSubview:self.industryTypeImageView];
    
    self.industryTypeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buildImageView.frame) + 10, CGRectGetMaxY(self.addressNameLB.frame), kScreenWidth -CGRectGetMaxX(self.buildImageView.frame) - 20 , 25)];
    self.industryTypeLB.textColor = kCommonMainTextColor_50;
    self.industryTypeLB.text = [contactInfo objectForKey:@"propertyPerson"];
    self.industryTypeLB.font = kMainFont;
    [self.contentView addSubview:self.industryTypeLB];
    
    self.phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(separeteLine.hd_x,CGRectGetMaxY(self.industryTypeImageView.frame) + 10 , 15, 15)];
    self.phoneImageView.image = [UIImage imageNamed:@"ic_phone"];
    [self.contentView addSubview:self.phoneImageView];
    
    self.phoneLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buildImageView.frame) + 10, CGRectGetMaxY(self.industryTypeLB.frame), kScreenWidth -CGRectGetMaxX(self.buildImageView.frame) - 20 , 25)];
    self.phoneLB.textColor = kCommonMainTextColor_50;
    self.phoneLB.text = [contactInfo objectForKey:@"propertyPhone"];
    self.phoneLB.font = kMainFont;
    [self.contentView addSubview:self.phoneLB];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
