//
//  ChocePickerView.m
//  louyu
//
//  Created by aaa on 2018/11/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ChocePickerView.h"


# define GSLog(fmt, ...) NSLog((@"[方法:%s____" "行:%d]\n " fmt),  __FUNCTION__, __LINE__, ##__VA_ARGS__);
/** 宽高*/
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
/** window*/
#define kWindow [UIApplication sharedApplication].keyWindow

@interface ChocePickerView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSArray *subTitles;
@property (nonatomic,strong)void(^sure)(NSInteger path,NSString *pathStr);
@property (nonatomic,strong)void(^cancle)(void);

@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic, strong)NSMutableArray * startTimeArray;

@property (nonatomic,strong)UIPickerView *picker;
@property (nonatomic,assign)NSInteger selectedRow;

@end


@implementation ChocePickerView



- (UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(10, 0, 60, 40);
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
- (void)cancleBtnAction{
    if (self.cancle) {
        self.cancle();
    }
    [self disAppear];
}
- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(kScreenWidth - 70, 0, 60, 40);
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:kCommonMainOringeColor forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (void)sureBtnAction{
    if (self.sure) {
        self.sure(self.selectedRow, [self.startTimeArray[self.selectedRow] objectForKey:@"title"]);
    }
    [self disAppear];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, kScreenWidth - 140, 40)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(50, 40, kScreenWidth - 100, 200)];
        _picker.backgroundColor = [UIColor whiteColor];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 240, kScreenWidth, 240)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)dataArray
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        [self addSubview:self.contentView];
        UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        topView.backgroundColor = UIColorFromRGB(0xeeeeee);
        [self.contentView addSubview:topView];
        
        
        [self.contentView addSubview:self.cancleBtn];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.sureBtn];
        [self.contentView addSubview:self.picker];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        [self addSubview:self.contentView];
        UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        topView.backgroundColor = UIColorFromRGB(0xeeeeee);
        [self.contentView addSubview:topView];
        
        
        [self.contentView addSubview:self.cancleBtn];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.sureBtn];
        [self.contentView addSubview:self.picker];
    }
    return self;
}

- (void)appearWithTitle:(NSString *)title subTitles:(NSArray *)subTitles selectedStr:(NSString *)selectedStr sureAction:(void(^)(NSInteger path,NSString *pathStr))sure cancleAction:(void(^)(void))cancle{
    _titleLabel.text = title;
    [self.startTimeArray removeAllObjects];
    self.startTimeArray = [subTitles mutableCopy];
    [self.picker reloadAllComponents];
    _subTitles = subTitles;
    _sure = sure;
    _cancle = cancle;
    
    [kWindow addSubview:self];
}
- (void)disAppear{
    [self removeFromSuperview];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return kScreenWidth - 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0)
    {
        return [self.startTimeArray count];
        
    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _selectedRow = row;
        [pickerView reloadAllComponents];
    }
}
#pragma mark - UIPickerViewDatasource
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    [self changeSpearatorLineColor];
    
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(50.0, 0.0, kScreenWidth - 100, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    
    if (component == 0)
    {
        pickerLabel.text =  [[self.startTimeArray objectAtIndex:row] objectForKey:@"title"]; // Year
    }
    
    if (row == _selectedRow) {
        pickerLabel.textColor = kCommonMainColor;
    }
    
    return pickerLabel;
}

#pragma mark - 改变分割线的颜色
- (void)changeSpearatorLineColor
{
    for(UIView *speartorView in self.picker.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.backgroundColor = kCommonMainColor;//隐藏分割线
        }
    }
}



@end