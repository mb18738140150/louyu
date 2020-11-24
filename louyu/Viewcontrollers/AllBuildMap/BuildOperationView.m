//
//  BuildOperationView.m
//  louyu
//
//  Created by aaa on 2018/11/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BuildOperationView.h"

@interface BuildOperationView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSArray * dataArray;
@property (nonatomic, strong)UIButton * closeBtn;

@end

@implementation BuildOperationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadData];
        [self prepareUI];
    }
    return self;
}

- (void)loadData
{
    self.dataArray = @[@{@"image":@"build_icon",@"title":@"楼宇详情"},@{@"image":@"enter_company_icon",@"title":@"入驻企业"},@{@"image":@"navigition_icon",@"title":@"导航指引"},@{@"image":@"order_busniss",@"title":@"招商租售"}];
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.7];
    
    UIView * operationView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.52, kScreenHeight * 0.4, kScreenWidth * 0.36, 170)];
    operationView.backgroundColor = kCommonMainColor;
    operationView.layer.cornerRadius = 10;
    operationView.layer.masksToBounds = YES;
    [self addSubview:operationView];
    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(operationView.hd_width - 30, 5, 25, 25);
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [operationView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, operationView.hd_width, 120) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableView.backgroundColor = kCommonMainColor;
    [operationView addSubview:self.tableView];
    
}

- (void)closeAction
{
    [self removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    cell.backgroundColor = kCommonMainColor;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView * iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 5, 20, 20)];
    iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"image"]]];
    [cell.contentView addSubview:iconImageView];
    
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) + 5, 0, cell.hd_width - CGRectGetMaxX(iconImageView.frame) - 10, cell.hd_height)];
    titleLB.textColor = [UIColor whiteColor];
    titleLB.font = [UIFont systemFontOfSize:15];
    titleLB.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    [cell.contentView addSubview:titleLB];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.OperationBlock) {
        self.OperationBlock(indexPath.row);
    }
}

@end
