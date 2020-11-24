//
//  BuildCompanyDetailTableViewCell.m
//  louyu
//
//  Created by aaa on 2018/11/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BuildCompanyDetailTableViewCell.h"

@interface BuildCompanyDetailTableViewCell()

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * contentTF;
@end

@implementation BuildCompanyDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 90, self.hd_height - 1)];
    self.titleLB.text = [infoDic objectForKey:@"title"];
    self.titleLB.font = [UIFont boldSystemFontOfSize:17];
    self.titleLB.textColor = kMainTextColor;
    [self.contentView addSubview:self.titleLB];
    
    self.contentTF = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 10, 10, self.hd_width - CGRectGetMaxX(self.titleLB.frame) - 20, self.hd_height - 11)];
    self.contentTF.text = [infoDic objectForKey:@"content"];
    self.contentTF.font = [UIFont systemFontOfSize:14];
    self.contentTF.textColor = kCommonMainTextColor_50;
    [self.contentView addSubview:self.contentTF];
    
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(30, self.hd_height - 1, self.hd_width - 30, 1)];
    bottomLine.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [self.contentView addSubview:bottomLine];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
