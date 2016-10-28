//
//  DoctorDtailViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/9/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DoctorDtailViewController.h"
#import "AskViewController.h"
#import "ReserveViewController.h"
@interface DoctorDtailViewController ()

@end

@implementation DoctorDtailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.askButton setTitleColor:KMainColor forState:UIControlStateNormal];
    [self.reseverButton setTitleColor:KMainColor forState:UIControlStateNormal];
    self.reseverButton.layer.borderWidth=self.askButton.layer.borderWidth = 0.5 ;
    self.reseverButton.layer.masksToBounds = self.askButton.layer.masksToBounds = YES;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/doctor/%@",self.model.photo]]];
    self.askButton.layer.borderColor = self.reseverButton.layer.borderColor = KMainColor.CGColor;
    self.title = self.model.name;
    self.contentTextView.text =  self.model.aboutMe;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toAsk:(id)sender {
    AskViewController *ask = [[AskViewController alloc]init];
    ask.doctorId1 = self.model.doctorId;
    ask.clinicId1 = self.model.clinicId;
    ask.changeAskMoreLB = YES;
    [self.navigationController pushViewController:ask animated:YES];
}
- (IBAction)toResever:(id)sender {
    ReserveViewController *resever = [[ReserveViewController alloc]init];
    resever.clinicId = self.model.clinicId;
    resever.doctorId = self.model.doctorId;
    [self.navigationController pushViewController:resever animated:YES];
}


@end
