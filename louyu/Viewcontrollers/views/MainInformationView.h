//
//  MainInformationView.h
//  louyu
//
//  Created by aaa on 2018/11/7.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MainInformationView : UIView

- (instancetype)initWithFrame:(CGRect)frame andType:(InformationType)informationType andInfo:(NSDictionary *)info;

@property (nonatomic, assign)InformationType informationType;
@property (nonatomic, strong)NSDictionary * infoDic;

@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, strong)UILabel * contentLB;

@end
