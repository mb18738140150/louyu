//
//  BuildDetailTableViewCell.m
//  louyu
//
//  Created by aaa on 2018/11/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BuildDetailTableViewCell.h"
#import "BuildingTypeView.h"

@interface BuildDetailTableViewCell()

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * contentTF;

@end

@implementation BuildDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 90, self.hd_height - 1)];
    self.titleLB.text = [infoDic objectForKey:@"title"];
    self.titleLB.numberOfLines = 0;
    self.titleLB.textColor = kMainTextColor;
    self.titleLB.font = [UIFont boldSystemFontOfSize:17];
    [self.contentView addSubview:self.titleLB];
    
    self.contentTF = [[UILabel alloc]init];
    self.contentTF.frame = CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 10, 10, self.hd_width - CGRectGetMaxX(self.titleLB.frame) - 20, self.hd_height - 11);
    self.contentTF.text = [infoDic objectForKey:@"content"];
    self.contentTF.font = [UIFont systemFontOfSize:14];
    self.contentTF.textColor = kCommonMainTextColor_50;
    [self.contentView addSubview:self.contentTF];
    
    
    switch ([[infoDic objectForKey:@"type"] integerValue]) {
        case CompanyInformationType_nomal:
        {
            self.contentTF.frame = CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 10, 10, self.hd_width - CGRectGetMaxX(self.titleLB.frame) - 20, self.hd_height - 11);
            [self.contentView addSubview:self.contentTF];
        }
            break;
        case CompanyInformationType_fenqu:
        {
            self.contentTF.frame = CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 10, 10, self.hd_width - CGRectGetMaxX(self.titleLB.frame) - 180, self.hd_height - 11);
            BuildingTypeView * buildTypyView = [[BuildingTypeView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contentTF.frame) + 10, 10, 150, 30)];
            [self.contentView addSubview:buildTypyView];
            [buildTypyView resetBtnEnable:NO];
            
            if (self.contentTF.text.length <= 0) {
                [buildTypyView refreshNomal];
            }
            
        }
            break;
        default:
            break;
    }
    
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(30, self.hd_height - 1, self.hd_width - 30, 1)];
    bottomLine.backgroundColor = UIRGBColor(200, 200, 200);
    [self.contentView addSubview:bottomLine];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
