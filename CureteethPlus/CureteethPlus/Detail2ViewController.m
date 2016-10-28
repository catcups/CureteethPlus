//
//  Detail2ViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "Detail2ViewController.h"
#import "SearchDoctorModel.h"
#import "ResultDoctorTableViewCell.h"
#import "SearchDoctorModel.h"
#import "ReserveViewController.h"
#import "AskViewController.h"
#import "DoctorDtailViewController.h"
@interface Detail2ViewController ()<ResultDoctorTableViewCellDeleagte,UITableViewDataSource,UITableViewDelegate>

@end

@implementation Detail2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableview.tableFooterView = [[UIView alloc]init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchDoctorModel *model = self.dataSource[indexPath.row];
    ResultDoctorTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ResultDoctorTableViewCell" owner:nil options:nil] lastObject];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}
- (void)ResultDoctorTableViewCellDeleagteClikeAsk:(ResultDoctorTableViewCell *)cell model:(SearchDoctorModel *)model {
    AskViewController *ask = [[AskViewController alloc]init];
    ask.doctorId1 = model.doctorId;
    ask.clinicId1 = self.clinicId;
    ask.changeAskMoreLB = YES;
    [self.navigationController pushViewController:ask animated:YES];
}

-(void)ResultDoctorTableViewCellDeleagteClikeResever:(ResultDoctorTableViewCell *)cell model:(SearchDoctorModel *)model {
    ReserveViewController *resever = [[ReserveViewController alloc]init];
    resever.clinicId = self.clinicId;
    resever.doctorId = model.doctorId;
    [self.navigationController pushViewController:resever animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SearchDoctorModel *model = self.dataSource[indexPath.row];
    model.clinicId = self.clinicId;
    DoctorDtailViewController *detail = [[DoctorDtailViewController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];

}
@end
