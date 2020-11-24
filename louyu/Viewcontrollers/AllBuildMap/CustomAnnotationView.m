//
//  CustomAnnotationView.m
//  louyu
//
//  Created by aaa on 2018/11/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CustomAnnotationView.h"

#define kWidth  110.f
#define kHeight 50.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  30.f
#define kPortraitHeight 30.f

#define kCalloutWidth   200.0
#define kCalloutHeight  70.0

@interface CustomAnnotationView ()


@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CustomAnnotationView

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        
    }
    else
    {
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
//        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        self.backgroundColor = [UIColor clearColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth - kPortraitWidth) / 2, 0, kPortraitWidth, kPortraitHeight)];
        [self addSubview:self.portraitImageView];
        
        /* Create name label. */
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kHoriMargin,
                                                                   kPortraitHeight,
                                                                   kWidth,
                                                                   kHeight - kPortraitHeight)];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
        self.nameLabel.textColor        = kCommonMainTextColor_50;
        self.nameLabel.font             = [UIFont systemFontOfSize:15.f];
        [self addSubview:self.nameLabel];
    }
    
    return self;
}

@end
