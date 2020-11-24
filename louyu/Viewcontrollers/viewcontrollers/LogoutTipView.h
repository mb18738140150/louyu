//
//  LogoutTipView.h
//  louyu
//
//  Created by aaa on 2018/11/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoutTipView : UIView

@property (nonatomic, copy)void(^QuitBlock)(BOOL quit);

@end
