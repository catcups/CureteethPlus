//
//  LoginViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginReq.h"
#import "ForgetPasswordViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *pswText;
@property (weak, nonatomic) IBOutlet UIButton *logButton;
@property (weak, nonatomic) IBOutlet UIButton *wxloginBtn;
@property (weak, nonatomic) IBOutlet UIButton *toRegister;
@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.logButton.layer.cornerRadius = 10;
    self.toRegister.layer.cornerRadius = 10;
    self.wxloginBtn.layer.cornerRadius = 10;
    
    self.title = @"登录";
//    self.pswText.text = @"123456";
//    self.phoneText.text = @"18516677713";
}
- (IBAction)seePswButton:(id)sender {
    self.pswText.secureTextEntry = !self.pswText.secureTextEntry;
}

- (IBAction)onLogin:(id)sender {
    if (![self check]) {
        return;
    }
    [SVProgressHUD show];
    LoginReq *req = [[LoginReq alloc]init];
    req.password = self.pswText.text;
    req.mobile = self.phoneText.text;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if (![responseObject[@"photo"] isKindOfClass:[NSNull class]]) {
            [CommonTool storeUserDefaults:responseObject[@"photo"] ForKey:Kphoto];
        }
        if (![responseObject[@"name"] isKindOfClass:[NSNull class]] && responseObject[@"name"]) {
            [CommonTool storeUserDefaults:responseObject[@"name"] ForKey:KName];
        }
        if (![responseObject[@"customer_id"] isKindOfClass:[NSNull class]] && responseObject[@"customer_id"]) {
            [CommonTool storeUserDefaults:responseObject[@"customer_id"] ForKey:KCustomerId];
        }
        [CommonTool storeUserDefaults:self.phoneText.text ForKey:KPhoneNumber];
        [CommonTool storeUserDefaults:@"kislogin" ForKey:KisLogin];
        [CommonTool storeUserDefaults:self.pswText.text ForKey:Kpassworld];
        [(AppDelegate *)[UIApplication sharedApplication].delegate setRoot];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (IBAction)onForgetPsw:(id)sender { // 忘记密码
    [self.navigationController pushViewController:[[ForgetPasswordViewController alloc]init] animated:YES];
}

- (BOOL)check {
    if (self.phoneText.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"帐号不能为空!"];
        return NO;
    }
    if (self.pswText.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空!"];
        return NO;
    }
    return YES;
}
- (IBAction)wxLogin:(id)sender { // 微信登录
}

- (IBAction)tapgesture:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)toRegister:(id)sender { // 注册
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
