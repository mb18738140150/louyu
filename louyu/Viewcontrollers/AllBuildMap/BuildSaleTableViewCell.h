//
//  BuildSaleTableViewCell.h
//  louyu
//
//  Created by aaa on 2018/11/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildSaleTableViewCell : UITableViewCell

- (void)refreshWith:(NSDictionary *)infoDic;

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@end
