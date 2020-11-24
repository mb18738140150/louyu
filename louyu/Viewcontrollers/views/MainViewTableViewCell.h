//
//  MainViewTableViewCell.h
//  louyu
//
//  Created by aaa on 2018/11/7.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewTableViewCell : UITableViewCell

@property (nonatomic, copy)void(^ClickBlock)(BOOL complate);
@property (nonatomic, assign)InformationType informationType;
- (void)refreshWith:(NSDictionary *)infoDic;

@end
