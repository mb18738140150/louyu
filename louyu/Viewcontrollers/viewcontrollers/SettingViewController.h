//
//  SettingViewController.h
//  louyu
//
//  Created by aaa on 2018/11/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController

@property (nonatomic, copy)void(^QuitBlock)(BOOL quit);
@property (nonatomic, copy)void(^ChangeIconBlock)(UIImage * image);

@end
