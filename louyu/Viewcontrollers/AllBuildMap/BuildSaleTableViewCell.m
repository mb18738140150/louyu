//
//  BuildSaleTableViewCell.m
//  louyu
//
//  Created by aaa on 2018/11/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BuildSaleTableViewCell.h"

@interface BuildSaleTableViewCell()




@end

@implementation BuildSaleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)refreshWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    self.iconImageView.image = [UIImage imageNamed:@"ic_build_head"];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, 0, kScreenWidth - 50, 40)];
    self.titleLB.textColor = kCommonMainColor;
    self.titleLB.text = [infoDic objectForKey:@"title"];
    [self.contentView addSubview:self.titleLB];
    self.titleLB.font = kMainFont;
    self.titleLB.numberOfLines = 0;
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, kScreenWidth, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [self.contentView addSubview:bottomView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
