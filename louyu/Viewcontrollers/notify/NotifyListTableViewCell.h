//
//  NotifyListTableViewCell.h
//  louyu
//
//  Created by aaa on 2018/11/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifyListTableViewCell : UITableViewCell

@property (nonatomic, assign)NotifyListVCType  notifyListVCType;
- (void)refreshWith:(NSDictionary * )infoDic;

@end
