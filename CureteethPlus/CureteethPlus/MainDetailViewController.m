//
//  MainDetailViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MainDetailViewController.h"
#import "Deatail1ViewController.h"
#import "Detail2ViewController.h"
#import "MainDetailReq.h"
#import "DetailClinicModel.h"
#import "SearchDoctorModel.h"
#import "MapViewController.h"
#import "ReserveViewController.h"
#import "AskViewController.h"
@interface MainDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonright;
@property (weak, nonatomic) IBOutlet UIButton *buttonleft;
@property (nonatomic,strong)Deatail1ViewController *childOne;
@property (nonatomic,strong)Detail2ViewController *childTwo;
@property (nonatomic,strong) DetailClinicModel *clinicModel;
@property (nonatomic,strong)NSMutableArray *doctorArray;
@property (nonatomic,strong)UIView *lineView;
@end

@implementation MainDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MainDetailReq *req = [[MainDetailReq alloc]init];
    req.start = [NSNumber numberWithInteger:0];
    req.count = [NSNumber numberWithInteger:20]; ;
    req.clinicId =self.clinicId;
    [SVProgressHUD show];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [self bindDataWithDic:responseObject];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
    // Do any additional setup after loading the view from its nib.
}

-(void)bindDataWithDic:(id)responseObject {
    self.clinicModel = responseObject[@"clinicModel"];
    DetailClinicModel *model = responseObject[@"clinicModel"];
    [self.phoneButton setTitle:model.telephone forState:UIControlStateNormal];
    [self.localButton setTitle:model.address forState:UIControlStateNormal];
    self.clinicLabel.text = model.name;
    self.title = model.name;
    self.leftTimeLabel.text = model.time;
    [self.dennyScrollView getDennyImageArray:model.imageArray];
    self.dennyScrollView.pageControl.hidden = YES;
    [self midButtonPressed:self.buttonleft];
    self.leftView.backgroundColor = self.rightView.backgroundColor= [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 288, ([UIScreen mainScreen].bounds.size.width-10)/2, 2)];
    self.lineView.backgroundColor = KMainColor;
    [self.view addSubview:self.lineView];
    self.leftView.layer.cornerRadius = self.rightView.layer.cornerRadius = 5;
    self.leftButton.layer.masksToBounds = self.rightButton.layer.masksToBounds = YES;
    self.leftButton.layer.borderWidth  = self.rightButton.layer.borderWidth = 1;
    self.leftButton.layer.borderColor = self.rightButton.layer.borderColor = KMainColor.CGColor;
    
    [self.leftButton setTitleColor:KMainColor forState:UIControlStateNormal];
    [self.rightButton setTitleColor:KMainColor forState:UIControlStateNormal];
    self.doctorArray =[NSMutableArray arrayWithArray: responseObject[@"doctorArray"]];
}

- (IBAction)onLocalButton:(id)sender {
    if (self.clinicModel.clinicLat && self.clinicModel.clinicLng) {
        MapViewController *map = [[MapViewController alloc]initWithLng:[self.clinicModel.clinicLng doubleValue] lat:[self.clinicModel.clinicLat doubleValue]];
        map.title1 = self.localButton.titleLabel.text;
        [self.navigationController pushViewController:map animated:YES];
    }
}

-(void)getChildOne {
    if (!_childOne) {
        _childOne = [[Deatail1ViewController alloc]init];
        _childOne.model = self.clinicModel;
        _childOne.view.frame = CGRectMake(0, 318, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 318);
        [self.view addSubview:_childOne.view];
        [self addChildViewController:_childOne];
    }
}
- (IBAction)onCall:(UIButton *)sender {
    if (sender.titleLabel.text.length !=0) {
        [StringUtils makeCall:sender.titleLabel.text];
    }
}
-(void)getChildTwo{
    if (!_childTwo) {
        _childTwo = [[Detail2ViewController alloc]init];
        _childTwo.dataSource = self.doctorArray;
        _childTwo.clinicId = self.clinicId;
        _childTwo.view.frame = CGRectMake(0, 318, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 318);
        [self.view addSubview:_childTwo.view];
        [self addChildViewController:_childTwo];
    }
}
- (IBAction)onButtonSelected:(UIButton *)sender {
    if (sender.tag == 20) {
        AskViewController *ask = [[AskViewController alloc]init];
        ask.clinicId1 = self.clinicId;
        ask.changeAskMoreLB = YES;
        [self.navigationController pushViewController:ask animated:YES];
    }
    if (sender.tag == 21) {
        ReserveViewController *resever = [[ReserveViewController alloc]init];
        resever.clinicId = self.clinicId;
        [self.navigationController pushViewController:resever animated:YES];
    }

}
- (IBAction)midButtonPressed:(UIButton *)sender {
    if (sender.tag == 50) {
        [self getChildOne];
        _childTwo.view.hidden = YES;
        _childOne.view.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.lineView.frame = CGRectMake(0, 288, ([UIScreen mainScreen].bounds.size.width-10)/2, 2);
        }];
    }
    if (sender.tag == 51) {
        [self getChildTwo];
        _childTwo.view.hidden = NO;
        _childOne.view.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.lineView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 + 10, 288, ([UIScreen mainScreen].bounds.size.width-10)/2, 2);
        }];
    }
}

@end
