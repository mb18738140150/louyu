//
//  AddCompanyTableViewCell.m
//  louyu
//
//  Created by aaa on 2018/11/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AddCompanyTableViewCell.h"
#import "BuildingTypeView.h"

@interface AddCompanyTableViewCell()<UITextViewDelegate>

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)MKPPlaceholderTextView * contentTF;
@property (nonatomic, strong)UIImageView * tipImageView;
@property (nonatomic, strong)UIButton * clickBtn;

@end

@implementation AddCompanyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    __weak typeof(self)weakSelf = self;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 90, self.hd_height - 1)];
    self.titleLB.text = [infoDic objectForKey:@"title"];
    self.titleLB.font = [UIFont boldSystemFontOfSize:17];
    self.titleLB.textColor = kMainTextColor;
    [self.contentView addSubview:self.titleLB];
    
    self.contentTF = [[MKPPlaceholderTextView alloc]init];
    self.contentTF.returnKeyType = UIReturnKeyDone;
    self.contentTF.delegate = self;
    switch ([[infoDic objectForKey:@"type"] integerValue]) {
        case CompanyInformationType_nomal:
        {
            self.contentTF.frame = CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 10, 10, self.hd_width - CGRectGetMaxX(self.titleLB.frame) - 20, self.hd_height - 11);
            [self.contentView addSubview:self.contentTF];
        }
            break;
        case CompanyInformationType_necessarily:
        {
            self.contentTF.frame = CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 10, 10, self.hd_width - CGRectGetMaxX(self.titleLB.frame) - 40, self.hd_height - 11);
            [self.contentView addSubview:self.contentTF];
            self.tipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contentTF.frame) + 2, 10, 20, 20)];
            self.tipImageView.image = [UIImage imageNamed:@"ic_star"];
            [self.contentView addSubview:self.tipImageView];
            
        }
            break;
        case CompanyInformationType_fenqu:
        {
            self.contentTF.frame = CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 10, 10, self.hd_width - CGRectGetMaxX(self.titleLB.frame) - 180, self.hd_height - 11);
            [self.contentView addSubview:self.contentTF];
            BuildingTypeView * buildTypyView = [[BuildingTypeView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contentTF.frame) + 10, 10, 150, 30)];
            [self.contentView addSubview:buildTypyView];
            buildTypyView.BuildTypeSelectBlick = ^(NSString *buildTypeStr) {
                if (weakSelf.BuildTypeSelectBlick) {
                    weakSelf.BuildTypeSelectBlick(buildTypeStr);
                }
            };
        }
            break;
        default:
            break;
    }
    self.contentTF.text = [infoDic objectForKey:@"content"];
    self.contentTF.placeholder = [infoDic objectForKey:@"placeHolder"];
    self.contentTF.font = [UIFont systemFontOfSize:14];
    self.contentTF.textColor = kCommonMainTextColor_50;
    
    if ([[infoDic objectForKey:@"enputType"] integerValue] == EnPutType_picker || [[infoDic objectForKey:@"enputType"] integerValue] == EnPutType_push) {
        UIButton * choceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        choceBtn.frame = self.contentTF.frame;
        choceBtn.backgroundColor = [UIColor clearColor];
        [choceBtn addTarget:self action:@selector(choceAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:choceBtn];
    }
    
    
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(30, self.hd_height - 1, self.hd_width - 30, 1)];
    bottomLine.backgroundColor = UIRGBColor(200, 200, 200);
    [self.contentView addSubview:bottomLine];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.InformationChangeBlock) {
        self.InformationChangeBlock(textView.text);
    }
}

- (void)choceAction
{
    if (self.ChoceInformationChangeBlock) {
        self.ChoceInformationChangeBlock(@{});
    }
}

- (void)refreshContent:(NSString *)content
{
    self.contentTF.text = content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
