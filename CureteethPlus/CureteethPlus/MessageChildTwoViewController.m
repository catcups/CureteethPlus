//
//  MessageChildTwoViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/20.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MessageChildTwoViewController.h"
#import "MessageTableViewCell.h"
#import "MessageModel.h"
#import "MessageReq.h"
#import "MessageResultViewController.h"
@interface MessageChildTwoViewController ()

@end

@implementation MessageChildTwoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableview.tableFooterView = [[UIView alloc]init];
    MessageReq *req = [[MessageReq alloc]init];
    req.type = @"2";
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        self.dataSource = [NSMutableArray arrayWithArray:responseObject];
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageModel *model =self.dataSource[indexPath.row];
    MessageTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MessageTableViewCell" owner:nil options:nil] lastObject];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageResultViewController *message = [[MessageResultViewController alloc]init];
    [self.navigationController pushViewController:message animated:YES];
}

@end
