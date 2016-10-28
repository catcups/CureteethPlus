//
//  MoreViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MoreViewController.h"
#import "UnloginTableViewCell.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
@interface MoreViewController ()<UIAlertViewDelegate>

@end

@implementation MoreViewController
- (id)init {
    if (self = [super init]) {
        self.title = @"个人中心";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"更多", nil) image:[UIImage imageNamed:@"menu"] selectedImage:[[UIImage imageNamed:@"tabbar_SynthesisSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.logOutButton.layer.cornerRadius = 5;
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.imageArray = @[@"advisory",@"appintment",@"adv_pen"];
    self.titleArray = @[@"我的咨询记录",@"我的预约历史",@"意见反馈"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([CommonTool readUserDefaultsByKey:KisLogin]) {
        return 3;
    }else{
        return 2;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([CommonTool readUserDefaultsByKey:KisLogin]) {
        if (section == 0) {
            return 1;
        }else if (section == 1) {
            return 1;
        }else {
            return 3;
        }
    }else{
        if (section == 0) {
            return 1;
        }else{
            return 3;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if([CommonTool readUserDefaultsByKey:KisLogin]){
            LoginSuccessTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"LoginSuccessTableViewCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            UnloginTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"UnloginTableViewCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if ([CommonTool readUserDefaultsByKey:KisLogin]) {
        if (indexPath.section == 1) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"修改密码";
            [cell.imageView setImage:[UIImage imageNamed:@"password"]];
            return cell;
        }
        if (indexPath.section == 2) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = self.titleArray[indexPath.row];
            [cell.imageView setImage:[UIImage imageNamed:self.imageArray[indexPath.row]]];
            return cell;
        }
    }else {
        if (indexPath.section == 1) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = self.titleArray[indexPath.row];
            [cell.imageView setImage:[UIImage imageNamed:self.imageArray[indexPath.row]]];
            return cell;
        }
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![CommonTool readUserDefaultsByKey:KisLogin]) {
        if (indexPath.section == 0) {
            if (![CommonTool readUserDefaultsByKey:KisLogin]) {
                [self toLog];
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请先登录!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
                [alert show];
            } if (indexPath.row == 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请先登录!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
                [alert show];
            }
            if (indexPath.row == 2) {
                AdviceViewController *advice = [[AdviceViewController alloc]init];
                advice.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:advice animated:YES];
            }
        }
    }else {
        if (indexPath.section == 0) {
            if (![CommonTool readUserDefaultsByKey:KisLogin]) {
                [(AppDelegate *)[UIApplication sharedApplication].delegate tolog];
                [self.tableview reloadData];
            }
        }
        if (indexPath.section == 1) {
            ChangePassworldViewController *change = [[ChangePassworldViewController alloc]init];
            change.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:change animated:YES];
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                AskListViewController *ask = [[AskListViewController alloc]init];
                ask.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:ask animated:YES];
            } if (indexPath.row == 1) {
                ReseverListViewController *resever = [[ReseverListViewController alloc]init];
                resever.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:resever animated:YES];
            }
            if (indexPath.row == 2) {
                AdviceViewController *advice = [[AdviceViewController alloc]init];
                advice.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:advice animated:YES];
            }
        }
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 70;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else {
        return 0.1;
    }
}
- (IBAction)onLogOut:(UIButton *)sender {
    [SVProgressHUD show];
    [CommonTool storeUserDefaults:nil ForKey:KisLogin];
    [self.tableview reloadData];
    [SVProgressHUD dismiss];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self toLog];
    }
}

-(void)toLog{
    LoginViewController *log =[[LoginViewController alloc]init];
    log.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:log animated:YES];
}
@end
