//
//  ResultDoctorViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ResultDoctorViewController.h"
#import "ResultDoctorTableViewCell.h"
#import "SearchDoctorModel.h"
#import "ReserveViewController.h"
#import "AskViewController.h"
@interface ResultDoctorViewController ()<UITableViewDataSource,UITableViewDelegate,ResultDoctorTableViewCellDeleagte>

@end

@implementation ResultDoctorViewController
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchDoctorModel *model =self.dataSource[indexPath.row];
    ResultDoctorTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ResultDoctorTableViewCell" owner:nil options:nil] lastObject];
    cell.model = model;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)ResultDoctorTableViewCellDeleagteClikeAsk:(ResultDoctorTableViewCell *)cell model:(SearchDoctorModel *)model {
    AskViewController *ask = [[AskViewController alloc]init];
    ask.doctorId1 = model.doctorId;
    ask.clinicId1 = model.clinicId;
    [self.navigationController pushViewController:ask animated:YES];
}

-(void)ResultDoctorTableViewCellDeleagteClikeResever:(ResultDoctorTableViewCell *)cell model:(SearchDoctorModel *)model {
    ReserveViewController *resever = [[ReserveViewController alloc]init];
    resever.clinicId = model.clinicId;
    resever.doctorId = model.doctorId;
    [self.navigationController pushViewController:resever animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
