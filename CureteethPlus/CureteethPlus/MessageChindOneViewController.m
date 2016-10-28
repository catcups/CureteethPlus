//
//  MessageChindOneViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/20.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MessageChindOneViewController.h"
#import "MessageTableViewCell.h"
#import "MessageResultViewController.h"
#import "MessageReq.h"
@interface MessageChindOneViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MessageChindOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableview.tableFooterView = [[UIView alloc]init];
    MessageReq *req = [[MessageReq alloc]init];
    req.type = @"1";
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
    MessageModel *model =self.dataSource[indexPath.row];
    MessageResultViewController *message = [[MessageResultViewController alloc]init];
    message.messageId = model.messageId;
    [self.navigationController pushViewController:message animated:YES];
}
@end
