//
//  BuildOperationView.h
//  louyu
//
//  Created by aaa on 2018/11/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildOperationView : UIView

@property (nonatomic, copy)void(^OperationBlock)(NSInteger index);

@end
