//
//  BuildSearchViewController.h
//  louyu
//
//  Created by aaa on 2018/11/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildSearchViewController : UIViewController

@property (nonatomic, assign)BOOL isGetBuildName;
@property (nonatomic, copy)void(^GetBuildNameBlock)(NSString *buildName);

@end
