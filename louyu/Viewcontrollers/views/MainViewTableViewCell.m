//
//  MainViewTableViewCell.m
//  louyu
//
//  Created by aaa on 2018/11/7.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MainViewTableViewCell.h"
#import "MainInformationView.h"

#define kCellHeight (kScreenHeight * 0.243)


@interface MainViewTableViewCell()

@property (nonatomic, strong)UIButton * actionBtn;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)BasicCategoryView * basicCategoryView;

@end

@implementation MainViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth / 2, kCellHeight * 0.227)];
    self.titleLB.text = [infoDic objectForKey:@"title"];
    self.titleLB.textColor = kCommonMainTextColor_50;
    self.titleLB.font = kMainFont;
    [self.contentView addSubview:self.titleLB];
    
    UIImageView * goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 22, (self.titleLB.hd_height - 13) / 2, 7, 13)];
    goImageView.image = [UIImage imageNamed:@"ic_next"];
    [self.contentView addSubview:goImageView];
    
    self.actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.actionBtn.frame = CGRectMake(0, 0, kScreenWidth, self.titleLB.hd_height);
    self.actionBtn.backgroundColor = [UIColor clearColor];
    [self.actionBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.actionBtn];
    
    UIView * hSeparateLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.actionBtn.hd_height, kScreenWidth, 1)];
    hSeparateLine.backgroundColor = UIRGBColor(238, 238, 238);
    [self.contentView addSubview:hSeparateLine];
    
    self.basicCategoryView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(hSeparateLine.frame) + kCellHeight * 0.15, kScreenWidth * 0.22, kScreenWidth * 0.22) andInfo:@{@"imageStr":[infoDic objectForKey:@"categoryIcon"],@"title":[infoDic objectForKey:kcategoryName],@"type":@(BasicCategoryType_course)}];
    self.basicCategoryView.titleLB.textColor = kMainTextColor_100;
    [self.contentView addSubview:self.basicCategoryView];
    
    UIView * vSeparateLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.basicCategoryView.frame) + 10, CGRectGetMaxY(hSeparateLine.frame) + kCellHeight * 0.1, 1, kCellHeight * 0.55)];
    vSeparateLine.backgroundColor = UIRGBColor(238, 238, 238);;
    [self.contentView addSubview:vSeparateLine];
    
    NSArray * dataArray = [infoDic objectForKey:@"contentList"];
    if (dataArray.count == 0) {
        return;
    }
    switch (dataArray.count) {
        case 1:
            {
                MainInformationView * mainInfoView = [[MainInformationView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(vSeparateLine.frame) + 20, CGRectGetMidY(vSeparateLine.frame) - 12, kScreenWidth - CGRectGetMaxX(vSeparateLine.frame) - 20 - 15, 25) andType:self.informationType andInfo:dataArray[0]];
                [self.contentView addSubview:mainInfoView];
            }
            break;
        case 2:
        {
            MainInformationView * mainInfoView = [[MainInformationView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(vSeparateLine.frame) + 20, CGRectGetMidY(vSeparateLine.frame) - 25, kScreenWidth - CGRectGetMaxX(vSeparateLine.frame) - 20 - 15, 25) andType:self.informationType andInfo:dataArray[0]];
            [self.contentView addSubview:mainInfoView];
            
            MainInformationView * mainInfoView1 = [[MainInformationView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(vSeparateLine.frame) + 20, CGRectGetMidY(vSeparateLine.frame), kScreenWidth - CGRectGetMaxX(vSeparateLine.frame) - 20 - 15, 25) andType:self.informationType andInfo:dataArray[1]];
            [self.contentView addSubview:mainInfoView1];
        }
            break;
            
        default:
        {
            MainInformationView * mainInfoView = [[MainInformationView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(vSeparateLine.frame) + 20, CGRectGetMidY(vSeparateLine.frame) - 37, kScreenWidth - CGRectGetMaxX(vSeparateLine.frame) - 20 - 15, 25) andType:self.informationType andInfo:dataArray[0]];
            [self.contentView addSubview:mainInfoView];
            
            MainInformationView * mainInfoView1 = [[MainInformationView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(vSeparateLine.frame) + 20, CGRectGetMidY(vSeparateLine.frame) - 12, kScreenWidth - CGRectGetMaxX(vSeparateLine.frame) - 20 - 15, 25) andType:self.informationType andInfo:dataArray[1]];
            [self.contentView addSubview:mainInfoView1];
            
            MainInformationView * mainInfoView2 = [[MainInformationView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(vSeparateLine.frame) + 20, CGRectGetMidY(vSeparateLine.frame) + 13, kScreenWidth - CGRectGetMaxX(vSeparateLine.frame) - 20 - 15, 25) andType:self.informationType andInfo:dataArray[2]];
            [self.contentView addSubview:mainInfoView2];
        }
            
            break;
    }
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(vSeparateLine.frame) + kCellHeight * 0.1, kScreenWidth, self.hd_height - CGRectGetMaxY(vSeparateLine.frame) - kCellHeight * 0.1)];
    bottomView.backgroundColor = UIRGBColor(238, 238, 238);
    [self.contentView addSubview:bottomView];
    
}

- (void)clickAction
{
    if (self.ClickBlock) {
        self.ClickBlock(YES);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
