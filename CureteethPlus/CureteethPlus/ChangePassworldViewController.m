//
//  ChangePassworldViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ChangePassworldViewController.h"
#import "ChangePswReq.h"
@interface ChangePassworldViewController ()

@end

@implementation ChangePassworldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    self.submitButton.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submit:(UIButton *)sender {
    if(![self check]) {
        return;
    }
    ChangePswReq *req = [[ChangePswReq alloc]init];
    req.doctorId = [CommonTool readUserDefaultsByKey:KCustomerId];
    req.oldpass = self.oldPassword.text;
    req.newpass = self.password.text;
    req.repass = self.rePassword.text;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        [self performSelector:@selector(back) withObject:nil afterDelay:1];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)check{
    if (self.oldPassword.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入旧密码!"];
        return NO;
    }
    if (self.password.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码!"];
        return NO;
    }
    if (self.rePassword.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        return NO;
    }
    if (![self.password.text isEqualToString:self.rePassword.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入不一致"];
        return NO;
    }
    return YES;
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
