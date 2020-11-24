//
//  SettingTableViewCell.m
//  louyu
//
//  Created by aaa on 2018/11/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "SettingTableViewCell.h"

@interface SettingTableViewCell()

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIImageView * goImageView;

@end

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    topView.backgroundColor = UIRGBColor(243, 243, 243);
    [self.contentView addSubview:topView];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 17, 17, 17)];
    self.iconImageView.image = [UIImage imageNamed:[infoDic objectForKey:@"imageStr"]];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 20, self.iconImageView.hd_y, kScreenWidth - 100, 17)];
    self.titleLB.text = [infoDic objectForKey:@"title"];
    self.titleLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLB];
    
    self.goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 26, 17, 9, 17)];
    self.goImageView.image = [UIImage imageNamed:@"ic_next"];
    [self.contentView addSubview:self.goImageView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
