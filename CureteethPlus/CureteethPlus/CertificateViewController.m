//
//  CertificateViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/26.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "CertificateViewController.h"
#import "VerifyDetailReq.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@interface CertificateViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (nonatomic,strong)NSURL *image1Url;
@property (nonatomic,strong)NSURL *image2Url;

@end

@implementation CertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"医牙啊";
    VerifyDetailReq *req = [[VerifyDetailReq alloc]init];
    req.clinicId = self.clinicId;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject[@"data"][@"clinicInfo"]) {
            [self bindDatawithDic:responseObject[@"data"][@"clinicInfo"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)bindDatawithDic:(NSMutableDictionary *)dic {
    if (![dic[@"clinicCertificateNo"] isKindOfClass:[NSNull class]]) {
        self.label1.text = dic[@"clinicCertificateNo"];
    }
    if (![dic[@"healthCommissionNo"] isKindOfClass:[NSNull class]]) {
        self.label2.text = dic[@"healthCommissionNo"];
    }
    if (![dic[@"clinicCertificate"] isKindOfClass:[NSNull class]]) {
        self.image1Url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/clinic/%@",dic[@"clinicCertificate"]]];
        [self.button1 sd_setImageWithURL:self.image1Url forState:UIControlStateNormal];
    }
    if (![dic[@"healthCommission"] isKindOfClass:[NSNull class]]) {
        self.image2Url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/clinic/%@",dic[@"healthCommission"]]];
         [self.button2 sd_setImageWithURL:self.image2Url forState:UIControlStateNormal];
    }
    
}
- (IBAction)onButton2:(UIButton *)sender {
    // 弹出相册时显示的第一张图片是点击的图片
    if (!sender.currentImage) {
        return;
    }
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    // 弹出相册时显示的第一张图片是点击的图片
    NSMutableArray *photos = [NSMutableArray array];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = self.image2Url;
    photo.srcImageView = [[UIImageView alloc]init];
    photo.image = sender.currentImage; // 图片路径
    [photos addObject:photo];
    
    browser.currentPhotoIndex = 0;
    // 设置所有的图片。photos是一个包含所有图片的数组。
    browser.photos = photos;
    [browser show];
}
- (IBAction)onbutton1:(UIButton *)sender {
    if (!sender.currentImage) {
        return;
    }
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    // 弹出相册时显示的第一张图片是点击的图片
    NSMutableArray *photos = [NSMutableArray array];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = self.image1Url;
    photo.srcImageView = [[UIImageView alloc]init];
    photo.image = sender.currentImage; // 图片路径
    [photos addObject:photo];

    browser.currentPhotoIndex = 0;
    // 设置所有的图片。photos是一个包含所有图片的数组。
    browser.photos = photos;
    [browser show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
