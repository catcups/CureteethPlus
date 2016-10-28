//
//  Deatail1ViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "Deatail1ViewController.h"
#import "Detail1TableViewCell.h"
#import "Detail2TableViewCell.h"
#import "Detail3TableViewCell.h"
#import "CertificateViewController.h"

@interface Deatail1ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation Deatail1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Detail1TableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"Detail1TableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 1) {
        Detail2TableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"Detail2TableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 2) {
        Detail3TableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"Detail3TableViewCell" owner:nil options:nil] lastObject];
        cell.contentTextView.text = self.model.description1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return 80;
    }
   else if (indexPath.row ==2) {
        return 170;
   }else {
       return 44;
   }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        CertificateViewController *cert = [[CertificateViewController alloc]init];
        cert.clinicId = self.model.clinicId;
        [self.navigationController pushViewController:cert animated:YES];
    }
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
