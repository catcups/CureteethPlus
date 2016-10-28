//
//  ForgetPasswordViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "GetCodeReq.h"
#import "ForgetPasswordReq.h"
@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UITextField *password1Text;
@property (weak, nonatomic) IBOutlet UITextField *password2Text;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic,strong)UIButton *codeButton;
@property (nonatomic,strong)NSTimer *getValidTimer;


@end

@implementation ForgetPasswordViewController
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"忘记密码";
    self.submitButton.layer.cornerRadius = 5;
    self.codeButton = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, self.codeText.frame.origin.y- 5, 80, 40)];
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.codeButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    self.codeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.codeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)see1paaword:(id)sender {
    self.password1Text.secureTextEntry = !self.password1Text.secureTextEntry;
}
- (IBAction)see2Password:(id)sender {
     self.password2Text.secureTextEntry = !self.password2Text.secureTextEntry;
}
- (IBAction)submit:(id)sender {
    if (![self check]) {
        return;
    }
    ForgetPasswordReq *req = [[ForgetPasswordReq alloc]init];
    req.password = self.password1Text.text;
    req.repassword = self.password2Text.text;
    req.mobile = self.mobileText.text;
    req.verify = self.codeText.text;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"提交成功!"];
        [self performSelector:@selector(back) withObject:nil afterDelay:1];
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)sendCode:(UIButton *)sender {
    if (self.mobileText.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空!"];
        return;
    }
//    if (![StringUtils isMobilePhone:self.mobileText.text]) {
//        [SVProgressHUD showErrorWithStatus:@"手机号格式不对!"];
//        return;
//    }
    self.getValidTimer = [self startTimerWithSEL:@selector(setValidCodeBtn:) Repeat:YES Dur:1];
    self.codeButton.tag = 60;
    [self.codeButton setEnabled:NO];
    GetCodeReq *req = [[GetCodeReq alloc]init];
    req.type = @"fogPassword";
    req.mobile = self.mobileText.text;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        ;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.codeButton.tag = 0;
    }];
}
- (void)setValidCodeBtn:(id)data
{
    self.codeButton.tag -= 1;
    if (self.codeButton.tag<= 0)
    {
        [self.codeButton setEnabled:YES];
        [self.getValidTimer invalidate];
        return;
    }
    NSString *resSecond = [NSString stringWithFormat:@"%ld",self.codeButton.tag];
    [self.codeButton setTitle:resSecond
                     forState:UIControlStateDisabled];
}
- (NSTimer *)startTimerWithSEL:(SEL)selector Repeat:(BOOL)repeat Dur:(int)second
{
    return [NSTimer scheduledTimerWithTimeInterval:second
                                            target:self
                                          selector:selector
                                          userInfo:nil
                                           repeats:repeat];
}


- (BOOL)check {
    if (self.mobileText.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空!"];
        return NO;
    }
    if (![StringUtils isMobilePhone:self.mobileText.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式不对!"];
        return NO;
    }
    if (self.codeText.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return NO;
    }
    if (self.password1Text.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码!"];
        return NO;
    }
    if (self.password2Text.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        return NO;
    }
    if (![self.password2Text.text isEqualToString:self.password1Text.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入不一致"];
        return NO;
    }
    return YES;
}
- (IBAction)tapGesturePressed:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}
@end
