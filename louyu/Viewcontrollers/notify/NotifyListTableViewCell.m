//
//  NotifyListTableViewCell.m
//  louyu
//
//  Created by aaa on 2018/11/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "NotifyListTableViewCell.h"

#define kCellHeight 120

@interface NotifyListTableViewCell()

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * imageLB;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UIView * bottomLine;

@end

@implementation NotifyListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary * )infoDic
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 30, 30)];
    self.imageLB = [[UILabel alloc]initWithFrame:self.iconImageView.frame];
    self.imageLB.layer.cornerRadius = self.imageLB.hd_height / 2;
    self.imageLB.font = kMainFont;
    self.imageLB.textColor = [UIColor whiteColor];
    self.imageLB.layer.masksToBounds = YES;
    if (self.notifyListVCType == NotifyListVCType_notify) {
        self.imageLB.text = @"公告";
        self.imageLB.backgroundColor = UIColorFromRGB(0xFE533B);
    }else
    {
        self.imageLB.text = @"法规";
        self.imageLB.backgroundColor = UIColorFromRGB(0x2CD286);
    }
//    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.imageLB];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, 21, self.hd_width - CGRectGetMaxX(self.iconImageView.frame) - 30, 18)];
    self.titleLB.text = [infoDic objectForKey:@"title"];
    [self.contentView addSubview:self.titleLB];
    
    
//    NSAttributedString * attributeStr = [[NSAttributedString alloc] initWithData:[[infoDic objectForKey:@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    NSString * str = [infoDic objectForKey:@"content"];
    [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    
    NSDictionary * attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [mStr addAttributes:attribute range:NSMakeRange(0, mStr.length)];
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.titleLB.frame) + 10, self.titleLB.hd_width, 40)];
    self.contentLB.font = [UIFont systemFontOfSize:14];
    self.contentLB.numberOfLines = 0;
    self.contentLB.attributedText = mStr;
    self.contentLB.textColor = kCommonMainTextColor_100;
    [self.contentView addSubview:self.contentLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.contentLB.hd_x, CGRectGetMaxY(self.contentLB.frame) + 5, self.titleLB.hd_width, 15)];
    self.timeLB.font = kMainFont;
    self.timeLB.text = [infoDic objectForKey:@"createTime"];
    self.timeLB.textColor = kCommonMainTextColor_150;
    [self.contentView addSubview:self.timeLB];
    
    self.bottomLine = [[UIView alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, self.hd_height - 1, self.titleLB.hd_width, 1)];
    self.bottomLine.backgroundColor = kCommonMainTextColor_200;
    [self.contentView addSubview:self.bottomLine];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
