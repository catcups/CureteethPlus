//
//  ResultClinicViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ResultClinicViewController.h"
#import "ResultClinicTableViewCell.h"
#import "SeachClinnicModel.h"
#import "MainDetailViewController.h"
@interface ResultClinicViewController ()<UITableViewDataSource,UITableViewDelegate,ResultClinicTableViewCellDelegate>

@end

@implementation ResultClinicViewController
- (id)initWithDataSource:(NSMutableArray *)array {
    self.dataSource = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SeachClinnicModel *model =self.dataSource[indexPath.row];
    ResultClinicTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ResultClinicTableViewCell" owner:nil options:nil] lastObject];
    cell.model = model;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)ResultClinicTableViewCellDelegateClikeInClinic:(ResultClinicTableViewCell *)cell model:(SeachClinnicModel *)model {
    MainDetailViewController *detail = [[MainDetailViewController alloc]init];
    detail.clinicId = model.clinicId;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
