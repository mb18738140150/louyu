//
//  BuildingTypeView.h
//  louyu
//
//  Created by aaa on 2018/11/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildingTypeView : UIView

@property (nonatomic, strong)void (^BuildTypeSelectBlick)(NSString * buildTypeStr);

- (void)resetBtnEnable:(BOOL)btnEnable;
- (void)refreshNomal;

@end
