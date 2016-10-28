//
//  ReseverListViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ReseverListViewController.h"
#import "AskListTableViewCell.h"
#import "ReseverLiatReq.h"
#import "ReseverListModel.h"
@interface ReseverListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ReseverListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约记录";
    [self onLeftButton:self.leftButton];
    self.tableview.tableFooterView = [[UIView alloc]init];
      // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReseverListModel *model = self.dataSource[indexPath.row];
    AskListTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"AskListTableViewCell" owner:nil options:nil] lastObject];
    cell.reseverModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (IBAction)onLeftButton:(id)sender {
    ReseverLiatReq *req = [[ReseverLiatReq alloc]init];
    req.oldApp = @"oldApp";
    [SVProgressHUD show];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        self.dataSource = [NSMutableArray arrayWithArray:responseObject];
        [self.tableview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (IBAction)onRightbutton:(id)sender {
    ReseverLiatReq *req = [[ReseverLiatReq alloc]init];
    req.oldApp = @"unApp";
    [SVProgressHUD show];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        self.dataSource = [NSMutableArray arrayWithArray:responseObject];
        [self.tableview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];

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
