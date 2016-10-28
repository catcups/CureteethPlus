//
//  SarchResultViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "SarchResultViewController.h"
#import "ResultClinicViewController.h"
#import "ResultDoctorViewController.h"
@interface SarchResultViewController ()
@property (nonatomic,strong)UIView *linView;
@property (nonatomic,strong)ResultClinicViewController *chinldOne;
@property (nonatomic,strong)ResultDoctorViewController *childTwo;
@end

@implementation SarchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.linView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, ScrMain_Width/2, 1)];
    self.linView.backgroundColor = KMainColor;
    [self onLeftButton:self.leftButton];
    [self.view addSubview:self.linView];
    self.title = @"搜索列表";
}
- (IBAction)onLeftButton:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.linView.frame = CGRectMake(0, 40, ScrMain_Width/2, 1);
    }];
    [self getChinldViewOne];
}
- (IBAction)onRightButton:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.linView.frame = CGRectMake(ScrMain_Width/2, 40, ScrMain_Width/2, 1);
    }];
    [self getChinldViewTwo];
}

-(void)getChinldViewOne {
    if (!_chinldOne) {
        _chinldOne = [[ResultClinicViewController alloc]initWithDataSource:self.dicDataSource[@"clinincArray"]];
        _chinldOne.view.frame = CGRectMake(0, 41, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-  41);
        [self.view addSubview:_chinldOne.view];
        [self addChildViewController:_chinldOne];

    }
    if (_childTwo) {
        _childTwo.view.hidden = YES;
    }
    _chinldOne.view.hidden = NO;
}

-(void)getChinldViewTwo{
    if (!_childTwo) {
        _childTwo = [[ResultDoctorViewController alloc]initWithDataSource:self.dicDataSource[@"doctorArray"]];
        _childTwo.view.frame = CGRectMake(0, 41, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) -  41);
        [self.view addSubview:_childTwo.view];
        [self addChildViewController:_childTwo];
    };
    if (_chinldOne) {
        _chinldOne.view.hidden = YES;
    }
    _childTwo.view.hidden = NO;
}

@end
