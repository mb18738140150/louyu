//
//  ChocePickerView.h
//  louyu
//
//  Created by aaa on 2018/11/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChocePickerView : UIView

- (instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)dataArray;

- (void)appearWithTitle:(NSString *)title subTitles:(NSArray *)subTitles selectedStr:(NSString *)selectedStr sureAction:(void(^)(NSInteger path,NSString *pathStr))sure cancleAction:(void(^)(void))cancle;

@end
