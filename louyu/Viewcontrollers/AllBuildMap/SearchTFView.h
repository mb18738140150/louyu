//
//  SearchTFView.h
//  louyu
//
//  Created by aaa on 2018/11/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTFView : UIView

@property (nonatomic, copy)void (^ClickBlock)(BOOL click);

- (void)resetTitle:(NSString *)str;

@end
