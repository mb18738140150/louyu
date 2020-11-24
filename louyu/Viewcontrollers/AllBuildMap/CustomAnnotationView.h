//
//  CustomAnnotationView.h
//  louyu
//
//  Created by aaa on 2018/11/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *portrait;
@property (nonatomic, strong) UIImageView *portraitImageView;
//@property (nonatomic, copy)

@end
