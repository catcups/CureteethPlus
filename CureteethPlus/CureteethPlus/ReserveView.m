//
//  ReserveView.m
//  CureteethPlus
//
//  Created by Denny on 16/7/28.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ReserveView.h"
#import "GetCodeReq.h"
#import "CheckMobile.h"
#import "ReseverSubmitReq.h"
@implementation ReserveView

-(void)awakeFromNib {
    self.mobileTfd.delegate = self.nameTfd.delegate = self.messageTfd.delegate = self.unMobileText.delegate =self.unNameText.delegate = self.unCodeText.delegate = self.unPassworldText.delegate = self.unMessageText.delegate= self;
    self.mobileTfd.text = [CommonTool readUserDefaultsByKey:KPhoneNumber];
    self.mainView.layer.cornerRadius = self.loginedView.layer.cornerRadius = self.unLoginView.layer.cornerRadius =self.submitBtn.layer.cornerRadius = 5;
    self.mainView.layer.masksToBounds =self.submitBtn.layer.masksToBounds =self.loginedView.layer.masksToBounds =self.unLoginView.layer.cornerRadius= YES;
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    if([CommonTool readUserDefaultsByKey:KisLogin]){
        self.loginedView.hidden = NO;
        self.unLoginView.hidden = YES;
        self.height1.constant = 440;
        self.height2.constant = 273;
        self.topMagrin = 0;
    }else {
        self.loginedView.hidden = YES;
        self.unLoginView.hidden = NO;
        self.topMagrin = 0;
        self.height1.constant = 470;
        self.height2.constant = 300;
        self.codeButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.unCodeText.frame) +20, self.unCodeText.frame.origin.y , 80, 30)];
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.codeButton.layer.cornerRadius =5;
        [self.codeButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
        self.codeButton.backgroundColor = KMainColor;
        self.codeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.unLoginView addSubview:self.codeButton];
        [self.unMobileText addTarget:self action:@selector(unMobileTextchange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGeature:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    self.marginTop.constant = self.topMagrin;
}

- (void)tapGeature:(UITapGestureRecognizer *)tap {
    [self endEditing:YES];
}
+(instancetype)createView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ReserveView" owner:nil options:nil] lastObject];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        self.marginTop.constant = self.topMagrin;
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        self.marginTop.constant = self.topMagrin;
    }];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.mobileTfd]) {
        [UIView animateWithDuration:0.4 animations:^{
            self.marginTop.constant = 0;
        }];
    }else if([textField isEqual:self.nameTfd] ||[textField isEqual:self.unNameText]){
        [UIView animateWithDuration:0.4 animations:^{
            self.marginTop.constant = -30;
        }];
    }else if ([textField isEqual:self.messageTfd]){
        [UIView animateWithDuration:0.4 animations:^{
            self.marginTop.constant = -70;
        }];
    }else if ([textField isEqual:self.unCodeText]){
        [UIView animateWithDuration:0.4 animations:^{
            self.marginTop.constant = -60;
        }];
    }else if ([textField isEqual:self.unPassworldText]){
        [UIView animateWithDuration:0.4 animations:^{
            self.marginTop.constant = -80;
        }];
    }else if ([textField isEqual:self.unMessageText]){
        [UIView animateWithDuration:0.4 animations:^{
            self.marginTop.constant = -140;
        }];
    }else if ([textField isEqual:_unMobileText]){
        [UIView animateWithDuration:0.4 animations:^{
            self.marginTop.constant = -40;
        }];
    }
}
- (IBAction)onTopLeftBtn:(UIButton *)sender {
    [self toSubmit];
}
- (IBAction)onRightBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ReserveViewDelegateOnclikeDismisView:)]) {
        [self.delegate ReserveViewDelegateOnclikeDismisView:self];
    }
}

-(void)toSubmit {
    [self endEditing:YES];
    if (![self check]) {
        return;
    }
    ReseverSubmitReq *req = [[ReseverSubmitReq alloc]init];
    req.doctorId = self.doctorId;
    req.clinicId = self.clinicId;
    req.holdTime = self.holdTime;
    req.targetDate = self.targetDate;
    if ([CommonTool readUserDefaultsByKey:KisLogin]) {
        req.customerId = [CommonTool readUserDefaultsByKey:KCustomerId];
        req.mobile = self.mobileTfd.text;
        if (self.messageTfd.text.length!=0) {
            req.message = self.messageTfd.text;
        }
        req.name = self.nameTfd.text;
    }else {
        req.mobile = self.unMobileText.text;
        req.name = self.unNameText.text;
        req.password = self.unPassworldText.text;
        if (self.unMessageText.text.length!=0) {
            req.message = self.unMessageText.text;
        }
        if (!self.haveRegister) {
            req.code = self.unCodeText.text;
        }
    }
    [SVProgressHUD show];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"提交预约成功"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(ReserveViewDelegateOnclikeDismisView:)]) {
            [self.delegate ReserveViewDelegateOnclikeDismisView:self];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (IBAction)onSubmitBtn:(UIButton *)sender {
    [self toSubmit];
}
- (IBAction)onPrivacy:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ReserveViewDelegateOnclikePrivacy:)]) {
        [self.delegate ReserveViewDelegateOnclikePrivacy:self];
    }
}
- (void)unMobileTextchange:(UITextField *)textxfield {
    CheckMobile *check = [[CheckMobile alloc]init];
    check.mobile = textxfield.text;
    [check request:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"data"] isEqualToString:@"yes"]) {
            self.codeButton.hidden = YES;
            self.unCodeText.hidden = YES;
            self.lineViewTop.constant = -38;
            self.lineView.hidden = YES;
            self.haveRegister = YES;
            self.unPassworldText.placeholder = @"请输入密码!";
        }else {
            self.codeButton.hidden = NO;
            self.unCodeText.hidden = NO;
            self.lineViewTop.constant = 7;
            self.lineView.hidden = NO;
            self.haveRegister = NO;
            self.unPassworldText.placeholder = @"请设置一个登录密码!";
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];

}
#pragma mark ---------------------code
- (void)sendCode:(UIButton *)sender {
    if (self.unMobileText.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空!"];
        return;
    }
    if (![StringUtils isMobilePhone:self.unMobileText.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式不对!"];
        return;
    }
    self.getValidTimer = [self startTimerWithSEL:@selector(setValidCodeBtn:) Repeat:YES Dur:1];
    self.codeButton.tag = 60;
    [self.codeButton setEnabled:NO];
    GetCodeReq *req = [[GetCodeReq alloc]init];
    req.type = @"fogPassword";
    req.mobile = self.unMobileText.text;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        ;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.codeButton.tag = 0;
    }];
}
- (void)setValidCodeBtn:(id)data{
    self.codeButton.tag -= 1;
    if (self.codeButton.tag<= 0){
        [self.codeButton setEnabled:YES];
        [self.getValidTimer invalidate];
        return;
    }
    NSString *resSecond = [NSString stringWithFormat:@"%ld",self.codeButton.tag];
    [self.codeButton setTitle:resSecond
                     forState:UIControlStateDisabled];
}
- (NSTimer *)startTimerWithSEL:(SEL)selector Repeat:(BOOL)repeat Dur:(int)second {
    return [NSTimer scheduledTimerWithTimeInterval:second
                                            target:self
                                          selector:selector
                                          userInfo:nil
                                           repeats:repeat];
}
- (BOOL)check {
    if ([CommonTool readUserDefaultsByKey:KisLogin]) {
        if (self.mobileTfd.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入您的手机号码!"];
            return NO;
        }
        if (![StringUtils isMobilePhone:self.mobileTfd.text]) {
            [SVProgressHUD showErrorWithStatus:@"手机号格式不对!"];
            return NO;
        }
        if (self.nameTfd.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入您的姓名!"];
            return NO;
        }
    }else {
        if (self.unMobileText.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入您的手机号码!"];
            return NO;
        }
//        if (![StringUtils isMobilePhone:self.unMobileText.text]) {
//            [SVProgressHUD showErrorWithStatus:@"手机号格式不对!"];
//            return NO;
//        }
        if (self.unNameText.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入您的姓名!"];
            return NO;
        }
        if (self.haveRegister) {
            if(self.unPassworldText.text.length == 0){
                [SVProgressHUD showErrorWithStatus:@"请输入密码!"];
                return NO;
            }
        }else{
            if(self.unCodeText.text.length == 0){
                [SVProgressHUD showErrorWithStatus:@"请输入验证码!"];
                return NO;
            }
            if(self.unPassworldText.text.length == 0){
                [SVProgressHUD showErrorWithStatus:@"请输入密码!"];
                return NO;
            }
        }
    }
    return YES;
}


@end
