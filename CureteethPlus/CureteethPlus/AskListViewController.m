//
//  AskListViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AskListViewController.h"
#import "AskListTableViewCell.h"
#import "AskListReq.h"
#import "AskListModel.h"
#import "ChatViewController.h"
@interface AskListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation AskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"咨询记录";
    // Do any additional setup after loading the view from its nib.
    self.tableview.tableFooterView = [[UIView alloc]init];
    [self onLeftButton:self.leftButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}
- (IBAction)onLeftButton:(id)sender {
    AskListReq *req = [[AskListReq alloc]init];
    req.unAdv = @"unAdv";
    [SVProgressHUD show];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        self.dataSource = [NSMutableArray arrayWithArray:responseObject];
        [self.tableview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (IBAction)onMidButton:(id)sender {
    AskListReq *req = [[AskListReq alloc]init];
    req.Advisory = @"newAdvisory";
    [SVProgressHUD show];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        self.dataSource = [NSMutableArray arrayWithArray:responseObject];
        [SVProgressHUD dismiss];
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];

}
- (IBAction)onRightButton:(id)sender {
    AskListReq *req = [[AskListReq alloc]init];
    req.oldAdV = @"oldAdV";
    [SVProgressHUD show];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        self.dataSource = [NSMutableArray arrayWithArray:responseObject];
        [self.tableview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AskListModel *model = self.dataSource[indexPath.row];
    AskListTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"AskListTableViewCell" owner:nil options:nil] lastObject];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AskListModel *model = self.dataSource[indexPath.row];
    ChatViewController *chat = [[ChatViewController alloc]init];
    chat.advisoryId = model.askId;
//    chat.fromId = 
    [self.navigationController pushViewController:chat animated:YES];

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
