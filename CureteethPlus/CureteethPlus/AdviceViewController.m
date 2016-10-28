//
//  AdviceViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AdviceViewController.h"
#import "AdviceReq.h"
@interface AdviceViewController ()

@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.submitButton.layer.cornerRadius = self.contentTextfield.layer.cornerRadius= 5;
    self.contentTextfield.placeholder = @"您的宝贵意见,将是我们进步的源泉!";
    self.contentTextfield.layer.borderColor = KGrayColor.CGColor;
    self.contentTextfield.layer.borderWidth = 0.5;
    self.contentTextfield.layer.masksToBounds = YES;
}
- (IBAction)onSubmit:(UIButton *)sender {
    if (![self check]) {
        return;
    }
    [SVProgressHUD show];
    AdviceReq *req = [[AdviceReq alloc]init];
    req.customerId = [CommonTool readUserDefaultsByKey:KCustomerId];
    req.question = self.titleTextfiled.text;
    req.content = self.contentTextfield.text;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"提交成功!"];
        [self performSelector:@selector(back) withObject:nil afterDelay:1];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapGesture:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


-(BOOL)check {
    if (self.titleTextfiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的手机号或者Email!"];
        return NO;

    }
    if (self.contentTextfield.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您想对我们说的!"];
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
