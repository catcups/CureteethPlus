//
//  ScanViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//
// 扫二维码的主页面
#import "ScanViewController.h"
#import "ScanView.h"
#import "ScanShowView.h"
#import <ZXingObjC/ZXingObjC.h>
#import <AVFoundation/AVFoundation.h>
#import "ScanReq.h"
#import "ScanResultView.h"
@interface ScanViewController ()<ScanViewDelegate,ScanShowViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ScanResultViewDelegate>
@property (nonatomic, strong)ScanShowView *scanShow;
@property (nonatomic, strong)ScanView *view;

@property (nonatomic, strong)ScanResultView *resultView;
@end
@implementation ScanViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描页";
    BaseNavViewController *tmpNav = (BaseNavViewController *)self.navigationController;
    [tmpNav enableGesturePop:NO];
}

- (void)loadView {
    self.view = [ScanView createView];
    self.view.delegate = self;
}

-(void)backAction {
    [self.view returnThing];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showMessage:(NSString *)message
{
    self.resultView = [ScanResultView creatView];
    self.resultView.delegate = self;
    self.resultView.frame = self.view.bounds;
    [self.view addSubview:self.resultView];
    ScanReq *req = [[ScanReq alloc]init];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        ;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
//    self.scanShow = [ScanShowView createView];
//    self.scanShow.frame = self.view.bounds;
//    self.scanShow.delegate = self;
//    self.scanShow.alpha = 0.0;
//    [self.scanShow reMessage:   message];
//    [self.view addSubview:self.scanShow];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    self.scanShow.alpha = 1.0;
//    [UIView commitAnimations];
//    //发送一个通知
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"startScan" object:nil];
}

-(void)ScanResultViewDelegateOnsubmitButton:(ScanResultView *)view {
    [self.view returnThing];
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  取消
 */
-(void)cancelThing:(NSString *)title
{
    NSLog(@"cancel===%@",title);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.scanShow.alpha = 0.0;
    [UIView commitAnimations];
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.scanShow = nil;
        [weakSelf.scanShow removeFromSuperview];
    });
    
}
/**
 *  确定
 */
-(void)okThing:(NSString *)title context:(NSString *)result
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.scanShow.alpha = 0.0;
    [UIView commitAnimations];
    
    NSLog(@"ok==%@",title);
    if ([title isEqualToString:@"扫描结果"]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = result;
    }else if ([title isEqualToString:@"温馨提醒"])
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:result]];
    }
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.scanShow = nil;
        [weakSelf.scanShow removeFromSuperview];
    });
    
}
#pragma mark------扫描相册方法
/**
 *  进入相册
 */
-(void)clickXCToVC
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{}];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:^{
        [self getURLWithImage:image];
    }
     ];
    
}
-(void)getURLWithImage:(UIImage *)img{
    
    UIImage *loadImage= img;
    CGImageRef imageToDecode = loadImage.CGImage;
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        self.resultView = [ScanResultView creatView];
        self.resultView.frame = self.view.bounds;
        [self.view addSubview:self.resultView];
        ScanReq *req = [[ScanReq alloc]init];
        [req request:^(NSURLSessionDataTask *task, id responseObject) {
            ;
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
//        NSString *contents = result.text;
//        NSLog(@"contents =%@",contents);
//        //[self showMessage:contents];
//        self.scanShow = [ScanShowView createView];
//        self.scanShow.frame = self.view.bounds;
//        self.scanShow.delegate = self;
//        self.scanShow.alpha = 0.0;
//        [self.scanShow reMessage:contents];
//        [self.view addSubview:self.scanShow];
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.3];
//        self.scanShow.alpha = 1.0;
//        [UIView commitAnimations];
        
    } else {
        //[self showMessage:@"获取失败"];
        self.scanShow = [ScanShowView createView];
        self.scanShow.frame = self.view.bounds;
        self.scanShow.delegate = self;
        self.scanShow.alpha = 0.0;
        [self.scanShow reMessage:@"获取失败"];
        [self.view addSubview:self.scanShow];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.scanShow.alpha = 1.0;
        [UIView commitAnimations];
    }
}


@end


