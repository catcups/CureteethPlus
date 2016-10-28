//
//  RegisterViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "RegisterViewController.h"
#import "GetCodeReq.h"
#import "RegisterReq.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIButton *codeButton;
@property (nonatomic,strong) NSTimer *getValidTimer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    // Do any additional setup after loading the view from its nib.
    self.codeButton = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, self.codeTextField.frame.origin.y- 5, 80, 40)];
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.codeButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    self.codeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.scrollview addSubview:self.codeButton];
    self.submitButton.layer.cornerRadius = 5;
    self.navigationController.navigationBarHidden = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)see1:(id)sender {
    self.passworld.secureTextEntry =!self.passworld.secureTextEntry;
}
- (IBAction)see2:(id)sender {
    self.passwold1.secureTextEntry = !self.passwold1.secureTextEntry ;
}

- (void)sendCode:(UIButton *)sender {
    if (self.mobileTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空!"];
        return;
    }
//    if (![StringUtils isMobilePhone:self.mobileTextField.text]) {
//        [SVProgressHUD showErrorWithStatus:@"手机号格式不对!"];
//        return;
//    }
    self.getValidTimer = [self startTimerWithSEL:@selector(setValidCodeBtn:) Repeat:YES Dur:1];
    self.codeButton.tag = 60;
    [self.codeButton setEnabled:NO];
    GetCodeReq *req = [[GetCodeReq alloc]init];
    req.type = @"reg";
    req.mobile = self.mobileTextField.text;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        [self performSelector:@selector(back) withObject:nil afterDelay:1];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.codeButton.tag = 0;
    }];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
- (IBAction)tapGesturePressed:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.passworld]) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.scrollview setContentOffset:CGPointMake(0, 70)];
        }];
    }
    if ([textField isEqual:self.passwold1]) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.scrollview setContentOffset:CGPointMake(0, 100)];
        }];
    }
}
- (IBAction)onSubmit:(UIButton *)sender {
    if ([self check]) {
        RegisterReq *req = [[RegisterReq alloc]init];
        req.mobile = self.mobileTextField.text;
        req.password = self.passworld.text;
        req.code = self.codeTextField.text;
        [req request:^(NSURLSessionDataTask *task, id responseObject) {
            ;
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
    }
    
}
- (BOOL)check {
    if (self.mobileTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空!"];
        return NO;
    }
    if (![StringUtils isMobilePhone:self.mobileTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式不对!"];
        return NO;
    }
    if (self.codeTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return NO;
    }
    if (self.passworld.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码!"];
        return NO;
    }
    if (self.passwold1.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        return NO;
    }
    if (![self.passwold1.text isEqualToString:self.passworld.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入不一致"];
        return NO;
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollview setContentOffset:CGPointMake(0, 0)];
    }];
}
@end
