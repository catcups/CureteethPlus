//
//  AskViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AskViewController.h"
#import "AskReq.h"
#import "AskModel.h"
#import "DoctorModel.h"
#import "PresentView.h"
#import "GetAskReq.h"
#import "CheckMobile.h"
#import "GetCodeReq.h"
#import "ForgetPasswordViewController.h"
#import "AskListViewController.h"
@interface AskViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,CustomPickerViewDelegate,PresentViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)AskModel *askModel;
@property (nonatomic,strong)NSMutableArray *doctorArray;
@property (nonatomic,strong)NSMutableDictionary *doctorDic;
@property (nonatomic,strong)CustomPickerView *doctorPicker;
@property (nonatomic,strong)PresentView *presentView;
@property (nonatomic,strong)UIButton *currentButton;
@property (nonatomic,assign)BOOL haveRegest;
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)UIButton *codeButton;
@property (nonatomic,strong)NSTimer *getValidTimer;
@property (nonatomic,assign)BOOL button1HaveImage;
@property (nonatomic,assign)BOOL button2HaveImage;
@property (nonatomic,assign)BOOL button3HaveImage;
@end

@implementation AskViewController {
    
}
- (id)init {
    if (self = [super init]) {
        self.title = @"工作台";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"咨询", nil) image:[UIImage imageNamed:@"message"] selectedImage:[[UIImage imageNamed:@"tabbar_SynthesisSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}
-(CustomPickerView *)doctorPicker {
    if (!_doctorPicker) {
        _doctorPicker = [[CustomPickerView alloc] initWithDelegate:self];
    }
    return _doctorPicker;
}

-(void)viewDidLayoutSubviews {
    self.title = @"咨询";
    self.content.layer.cornerRadius = self.submitButton.layer.cornerRadius = 5;
    self.content.layer.masksToBounds = self.submitButton.layer.masksToBounds =YES;
    self.content.layer.borderWidth =self.submitButton.layer.borderWidth= 0.5;
    self.content.layer.borderColor = [UIColor lightGrayColor].CGColor;
}
- (UIButton *)codeButton {
    if (!_codeButton) {
        _codeButton = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, self.codeTextfield.frame.origin.y- 5, 80, 40)];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_codeButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _codeButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mobileTextField addTarget:self action:@selector(textChangeValue:) forControlEvents:UIControlEventEditingChanged];
    [self.codeView addSubview:self.codeButton];
    AskReq *req = [[AskReq alloc]init];
    if(!self.clinicId1 && !self.doctorId1){
        req.lat = [CommonTool readUserDefaultsByKey:Klat];
        req.lng = [CommonTool readUserDefaultsByKey:Klng];
        NSLog(@"!self.clinicID-doctorID---%@, %@", req.lat, req.lng);
    }
    if(self.doctorId1){
        req.doctorId = self.doctorId1;
        NSLog(@"doctorID%@", req.doctorId);
    }if (self.clinicId1) {
        req.clinicId = self.clinicId1;
        NSLog(@"clinicID-%@", req.clinicId);
    }
    [req request:^(NSURLSessionDataTask *task, AskModel *responseObject) {
        [self handDataWith:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)sendCode:(UIButton *)sender {
    if (self.mobileTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空!"];
        return;
    }
    if (![StringUtils isMobilePhone:self.mobileTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式不对!"];
        return;
    }
    self.getValidTimer = [self startTimerWithSEL:@selector(setValidCodeBtn:) Repeat:YES Dur:1];
    self.codeButton.tag = 60;
    [self.codeButton setEnabled:NO];
    GetCodeReq *req = [[GetCodeReq alloc]init];
    req.type = @"advisory";
    req.mobile = self.mobileTextField.text;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        ;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.codeButton.tag = 0;
    }];
}
- (void)handDataWith:(AskModel *)model {
    self.askModel = model;
    self.doctorId = model.doctorId;
    if (self.changeAskMoreLB) {
        [self.askMoreLB setText:@"医生回复需要时间,请耐心等待"];
        self.minButton.selected = YES;
        self.minButton.userInteractionEnabled = NO;
    }
    [self.leftButton setTitle:model.clinicName forState:UIControlStateNormal];
    [self.rightButton setTitle:model.doctorName forState:UIControlStateNormal];
    self.doctorDic = [NSMutableDictionary dictionary];
    self.doctorArray = [NSMutableArray array];
    for (DoctorModel *model1 in model.doctorModelArray) {
        [self.doctorDic setObject:model1.doctorId forKey:model1.name];
        [self.doctorArray addObject:model1.name];
    }
    self.doctorPicker.options = self.doctorArray;
}
- (IBAction)onLeftButton:(id)sender {
    
}
- (IBAction)onRightButton:(id)sender {
    if (self.doctorPicker.options.count == 0) {
        return;
    }
    [_doctorPicker show];
}
- (void)setPickerDoneCallback:(NSInteger)index PickerView:(CustomPickerView *)pickerView{
    [self.rightButton setTitle:pickerView.options[index] forState:UIControlStateNormal];
    self.doctorId = [self.doctorDic objectForKey:pickerView.options[index]];
}

- (IBAction)onMinButton:(UIButton *)sender {
    self.minButton.selected = !self.minButton.selected;
}
- (IBAction)longGesture:(UILongPressGestureRecognizer *)sender {
    [self.view endEditing:YES];
    if (sender.state == UIGestureRecognizerStateBegan){
        if (self.button1.currentImage && self.button1HaveImage) {
            self.currentButton = self.button1;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"医牙啊" message:@"是否删除图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
}

- (IBAction)longGesture2:(UILongPressGestureRecognizer*)sender {
    [self.view endEditing:YES];
    if (sender.state == UIGestureRecognizerStateBegan){
        if (self.button2.currentImage && self.button2HaveImage) {
            self.currentButton = self.button2;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"医牙啊" message:@"是否删除图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
}
- (IBAction)longGesture3:(UILongPressGestureRecognizer*)sender {
    [self.view endEditing:YES];
    if (sender.state == UIGestureRecognizerStateBegan){
        if (self.button3.currentImage && self.button3HaveImage) {
            self.currentButton = self.button3;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"医牙啊" message:@"是否删除图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
}

- (IBAction)onButton1:(UIButton *)sender {
    [self.view endEditing:YES];
    self.currentButton = sender;
    if (self.button1HaveImage) {
        return;
    }
    self.presentView = [[PresentView alloc]initWithFrame:self.view.frame];
    [self.presentView.contentImage setImage:[UIImage imageNamed:@"tip1"]];
    self.presentView.LB1.text = @"Setp.1 仰头45度角,尽可能将嘴张大";
    self.presentView.LB2.text = @"Setp.2 打开照相机和闪光灯,手机高举贴近嘴部";
    self.presentView.LB3.text = @"Setp.3 拍照后确保照片清晰可见";
    self.presentView.LB4.text = @"Tips: 如果可以,请找人帮忙拍摄";
    self.presentView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self.presentView];
}
- (IBAction)onButton2:(UIButton *)sender {
    [self.view endEditing:YES];
    self.currentButton = sender;
    if (self.button2HaveImage) {
        return;
    }
    self.presentView = [[PresentView alloc]initWithFrame:self.view.frame];
    [self.presentView.contentImage setImage:[UIImage imageNamed:@"tip2"]];
    self.presentView.LB1.text = @"Setp.1 将头放平,尽可能将嘴张大";
    self.presentView.LB2.text = @"Setp.2 打开照相机和闪光灯,手机放低贴近嘴部";
    self.presentView.LB3.text = @"Setp.3 拍照后确保照片清晰可见";
    self.presentView.LB4.text = @"Tips: 如果可以,请找人帮忙拍摄";
    self.presentView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self.presentView];
}
- (IBAction)onButton3:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.button3HaveImage) {
        return;
    }
    self.currentButton = sender;
    self.presentView = [[PresentView alloc]initWithFrame:self.view.frame];
    self.presentView.delegate = self;
    [self.presentView.contentImage setImage:[UIImage imageNamed:@"tip3"]];
    self.presentView.LB1.text = @"Setp.1 将头放平,张开嘴,咬紧牙关。";
    self.presentView.LB2.text = @"Setp.2 打开照相机和闪光灯,手机平放贴近嘴部";
    self.presentView.LB3.text = @"Setp.3 拍照后确保照片清晰可见";
    self.presentView.LB4.text = @"Tips: 如果可以,请找人帮忙拍摄";
    [[UIApplication sharedApplication].keyWindow addSubview:self.presentView];
}

-(void)PresentViewDelegateClikeSure:(PresentView *)vc {
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [self.view endEditing:YES];
    [self.presentView removeFromSuperview];
    [action showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self camera];
    }
    if (buttonIndex == 1) {
        [self photoClumn];
    }
}

- (void)camera {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
//    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)photoClumn {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]){
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self.currentButton setImage:image forState:UIControlStateNormal];
        if (self.currentButton.tag  == 50) {
            self.button1HaveImage = YES;
        }if (self.currentButton.tag  == 51) {
            self.button2HaveImage = YES;
        }if (self.currentButton.tag  == 52) {
            self.button3HaveImage = YES;
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self.currentButton setImage:[UIImage imageNamed:@"file"] forState:UIControlStateNormal];
        if (self.currentButton.tag  == 50) {
            self.button1HaveImage = NO;
        }if (self.currentButton.tag  == 51) {
            self.button2HaveImage = NO;
        }if (self.currentButton.tag  == 52) {
            self.button3HaveImage = NO;
        }

    }
}
-(void)PresentViewDelegateClikeCancel:(PresentView *)vc {
    [self.presentView removeFromSuperview];
    self.presentView = nil;
}
- (void)textChangeValue:(UITextField *)textfield {
    if (textfield.text.length == 0) {
        return;
    }
    CheckMobile *check = [[CheckMobile alloc]init];
    check.mobile = textfield.text;
    [check request:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"data"] isEqualToString:@"yes"]) {
            self.passwordView.hidden = NO;
            self.codeView.hidden = YES;
            self.haveRegest = YES;
        }else {
            self.passwordView.hidden = YES;
            self.codeView.hidden = NO;
            self.haveRegest = NO;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.4 animations:^{
        self.scrollview.contentOffset = CGPointMake(0, 180);
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.4 animations:^{
        self.scrollview.contentOffset = CGPointMake(0, 0);
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    self.scrollview.contentOffset = CGPointMake(0, 0);
    return YES;
}

- (BOOL)check {
    if (self.content.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入咨询问题!"];
        return NO;
    }
    if (self.mobileTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号!"];
        return NO;
    }
    if (![StringUtils isMobilePhone:self.mobileTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不合法!"];
        return NO;
    }
    if (self.haveRegest) {
        if (self.passwordTextField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码!"];
            return NO;
        }
    }else {
        if (self.codeTextfield.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入验证码!"];
            return NO;
        }
    }
    return YES;
}
- (IBAction)onForgetPassword:(id)sender {
    ForgetPasswordViewController *foeget = [[ForgetPasswordViewController alloc]init];
    foeget.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:foeget animated:YES];
}
- (IBAction)onsubmit:(id)sender {
    if(![self check]){
        return;
    }
    [SVProgressHUD show];
    GetAskReq *req = [[GetAskReq alloc]init];
    if (self.minButton.selected) {
        req.askMore = @"1";
    }else {
        req.askMore = @"0";
    }
    if (self.haveRegest) {
        req.passowrd = self.passwordTextField.text;
    }else {
        req.code = self.codeTextfield.text;
    }
    req.clinicId = self.askModel.clinicId;
    req.doctorId = self.doctorId;
    req.content = self.content.text;
    req.mobile = self.mobileTextField.text;
    req.imageArray = [NSMutableArray arrayWithArray:[self getimageArray]];
    req.customerId = [CommonTool readUserDefaultsByKey:KCustomerId];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"提交成功!"];
        [self remoeText];
        [self performSelector:@selector(toAskList) withObject:nil afterDelay:1.0];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
-(void)toAskList {
    AskListViewController *ask =[[AskListViewController alloc] init];
    ask.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ask animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
-(NSMutableArray *)getimageArray {
    NSMutableArray *array = [NSMutableArray array];
    if (self.button1.currentImage && self.button1HaveImage) {
        [array addObject:UIImageJPEGRepresentation(self.button1.currentImage, 0.0000001)];
    }
    if (self.button2.currentImage && self.button2HaveImage) {
        [array addObject:UIImageJPEGRepresentation(self.button2.currentImage, 0.0000001)];
    }
    if (self.button3.currentImage && self.button3HaveImage) {
        [array addObject:UIImageJPEGRepresentation(self.button3.currentImage, 0.0000001)];
    }
    return array;
}
- (NSTimer *)startTimerWithSEL:(SEL)selector Repeat:(BOOL)repeat Dur:(int)second
{
    return [NSTimer scheduledTimerWithTimeInterval:second
                                            target:self
                                          selector:selector
                                          userInfo:nil
                                           repeats:repeat];
}
- (void)setValidCodeBtn:(id)data {
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
- (IBAction)dismissKeyBoardGesture:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

-(void)remoeText {
    self.content.text = @"";
    self.mobileTextField.text = @"";
    self.passwordTextField.text = @"";
    self.codeTextfield.text = @"";
    [self.button1 setImage:[UIImage imageNamed:@"file"] forState:UIControlStateNormal];
    [self.button2 setImage:[UIImage imageNamed:@"file"] forState:UIControlStateNormal];
    self.button1HaveImage = self.button3HaveImage = self.button2HaveImage = NO;
    [self.button3 setImage:[UIImage imageNamed:@"file"] forState:UIControlStateNormal];
}
@end
