//
//  AddCompany_scanfTableViewCell.m
//  louyu
//
//  Created by aaa on 2018/11/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AddCompany_scanfTableViewCell.h"

@interface AddCompany_scanfTableViewCell()

@property (nonatomic, strong)UIImageView * scanfImageView;
@property (nonatomic, strong)UILabel * tipLabel;
@property (nonatomic, strong)UIButton * foldBtn;

@end

@implementation AddCompany_scanfTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWithInfoDic:(NSDictionary *)infoDic andIsFold:(BOOL)isFold
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView removeAllSubviews];
    self.isFold = isFold;
    
    self.scanfImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 20, 15, 40, 40)];
    self.scanfImageView.image = [UIImage imageNamed:@"ic_scan_license"];
    [self.contentView addSubview:self.scanfImageView];
    self.imageView.userInteractionEnabled = YES;
    
    UIButton * scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = self.scanfImageView.frame;
    scanBtn.backgroundColor = [UIColor clearColor];
    [scanBtn addTarget:self action:@selector(scanfAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:scanBtn];
    
    self.tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 100, CGRectGetMaxY(self.scanfImageView.frame) + 10, 200, self.hd_height - 75)];
    self.tipLabel.text = @"扫描自动录入";
    self.tipLabel.textColor = kCommonMainOringeColor;
    self.tipLabel.font = [UIFont systemFontOfSize:15];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.tipLabel];
    
    self.foldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.foldBtn.frame = CGRectMake(kScreenWidth - 120, self.tipLabel.hd_y, 110, 20);
    if (isFold) {
        [self.foldBtn setTitle:@"手动输入" forState:UIControlStateNormal];
    }
    else
    {
        [self.foldBtn setTitle:@"隐藏自动输入" forState:UIControlStateNormal];
    }
    self.foldBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.foldBtn setTitleColor:UIRGBColor(59, 125, 253) forState:UIControlStateNormal];
    [self.foldBtn addTarget:self action:@selector(foldAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.foldBtn];
}

- (void)scanfAction
{
    if (self.ScanfActionBlock) {
        self.ScanfActionBlock(YES);
    }
}

- (void)foldAction
{
    if (self.FoldActionBlock) {
        self.FoldActionBlock(!self.isFold);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
