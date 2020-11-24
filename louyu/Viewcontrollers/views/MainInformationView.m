//
//  MainInformationView.m
//  louyu
//
//  Created by aaa on 2018/11/7.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MainInformationView.h"

@implementation MainInformationView

- (instancetype)initWithFrame:(CGRect)frame andType:(InformationType)informationType andInfo:(NSDictionary *)info
{
    if (self = [super initWithFrame:frame]) {
        self.informationType = informationType;
        self.infoDic = info;
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 15, 15)];
    if (self.informationType == InformationType_ruler) {
        self.imageView.image = [UIImage imageNamed:@"rule"];
    }else if (self.informationType == InformationType_notification)
    {
        self.imageView.image = [UIImage imageNamed:@"notice"];
    }
    [self addSubview:self.imageView];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame) + 10, 0, self.hd_width - 25, self.hd_height)];
    self.contentLB.text = [self.infoDic objectForKey:@"title"];
    self.contentLB.font = kMainFont;
    self.contentLB.textColor = kCommonMainTextColor_150;
    [self addSubview:self.contentLB];
    
}

@end
