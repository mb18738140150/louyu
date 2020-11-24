//
//  AddCompanyTableViewCell.h
//  louyu
//
//  Created by aaa on 2018/11/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCompanyTableViewCell : UITableViewCell

@property (nonatomic, strong)void(^InformationChangeBlock)(NSString *information);
@property (nonatomic, strong)void(^ChoceInformationChangeBlock)(NSDictionary *info);
@property (nonatomic, strong)void (^BuildTypeSelectBlick)(NSString * buildTypeStr);

- (void)refreshWith:(NSDictionary *)infoDic;
- (void)refreshContent:(NSString *)content;
@end
