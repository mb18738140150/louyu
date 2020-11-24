//
//  AddCompany_scanfTableViewCell.h
//  louyu
//
//  Created by aaa on 2018/11/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCompany_scanfTableViewCell : UITableViewCell

@property (nonatomic, copy)void(^ScanfActionBlock)(BOOL scanf);
@property (nonatomic, copy)void(^FoldActionBlock)(BOOL fold);

@property (nonatomic, assign)BOOL isFold;
- (void)refreshWithInfoDic:(NSDictionary *)infoDic andIsFold:(BOOL)isFold;

@end
