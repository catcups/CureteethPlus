        //
//  ReserveViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//
// 我要预约
#import "ReserveViewController.h"
#import "ReseverReq.h"
#import "ReserveView.h"
#import "GetAbleDoctorReq.h"
#import "GetAbleTimeReq.h"
@interface ReserveViewController ()<LGCalendarDelegate,ReserveViewDelegate,CustomPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (nonatomic,strong)NSMutableArray *unAbleDays;
@property (nonatomic,strong)ReserveView *reserView;
@property (nonatomic,strong)NSString *selectYear;
@property (nonatomic,strong)NSString *selectMonth;
@property (nonatomic,strong)NSString *selectDay;
@property (nonatomic,strong)NSString *clinicImageString;
@property (nonatomic,strong)NSString *clinicName;
@property (nonatomic,strong)NSString *targetDate;
@property (nonatomic,strong)NSString *holdTime;
@property (nonatomic,strong)NSString *doctorId1;
@property (nonatomic,strong)NSString *clinicId1;

@end

@implementation ReserveViewController
- (id)init {
    if (self = [super init]) {
        self.title = @"预约就诊";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"我要预约", nil) image:[UIImage imageNamed:@"person"] selectedImage:[[UIImage imageNamed:@"tabbar_SynthesisSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}

-(void)bindDataWithDic:(NSMutableDictionary *)responseObject {
    if (responseObject[@"name"] == nil) {
        [self.rightButton setTitle:responseObject[@"doctorName"]forState:UIControlStateNormal];
    }else{
        [self.rightButton setTitle:responseObject[@"name"]forState:UIControlStateNormal];
    }
    [self.leftButton setTitle:responseObject[@"clinicName"]forState:UIControlStateNormal];
    self.clinicName = responseObject[@"clinicName"];
    self.clinicId1 = responseObject[@"clinic_id"];
    self.doctorId1 = responseObject[@"doctor_id"];
    self.clinicImageString = responseObject[@"clinicLogo"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [SVProgressHUD show];

    ReseverReq *req = [[ReseverReq alloc]init];
    if (self.clinicId) {
        req.clinicId = self.clinicId;
    }
    if (self.doctorId) {
        req.doctorId = self.doctorId;
    }
    if (!self.doctorId && !self.clinicId) {
        req.lat = [CommonTool readUserDefaultsByKey:Klat];
        req.lng = [CommonTool readUserDefaultsByKey:Klng];
    }
    __weak ReserveViewController *blockSelf = self;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [blockSelf bindDataWithDic:(NSMutableDictionary *)responseObject];
        GetAbleTimeReq *req = [[GetAbleTimeReq alloc]init];
        req.month = [StringUtils getCurrentSpTimeOfMonth];
        req.year = [StringUtils getCurrentSpTimeOfYear];
        req.doctorId = self.doctorId1;
        req.clinicId = self.clinicId1;
        [req request:^(NSURLSessionDataTask *task, id responseObject) {
            [SVProgressHUD dismiss];
            blockSelf.unAbleDays = [NSMutableArray arrayWithArray:responseObject[@"data"][@"data"][@"allday"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [blockSelf addLgCalender];
            });
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [SVProgressHUD dismiss];
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];

    }];
}

-(void)addLgCalender {
   LGCalendar *le  = [[LGCalendar alloc] initWithFrame:CGRectMake(4, 70, [UIScreen mainScreen].bounds.size.width - 8, 270)];
   le.delegate = self;
    [self.view addSubview:le];
    self.lgCalendar = le;
}
-(void)LGCalendar:(LGCalendar *)calendar didSelectDate:(NSString *)selectDate currtentYear:(NSInteger)currentYear currtentMonth:(NSInteger)currentMonth currentDay:(NSInteger)currentday{
    self.targetDate = selectDate;
    if (![self.unAbleDays containsObject:[NSNumber numberWithInteger:currentday]]) {
        GetAbleDoctorReq *req = [[GetAbleDoctorReq alloc]init];
        req.clinicId = self.clinicId1;
        req.doctorId = self.doctorId1;
        req.year = [NSString stringWithFormat:@"%ld",(long)currentYear];
        req.month = [NSString stringWithFormat:@"%ld",(long)currentMonth];
        req.day = [NSString stringWithFormat:@"%ld",(long)currentday];
        [req request:^(NSURLSessionDataTask *task, id responseObject) {
            CustomPickerView *datePicker = [[CustomPickerView alloc] initWithDelegate:self];
            NSMutableArray *optionArray = [NSMutableArray array];
            if (responseObject[@"data"][@"timetable"]) {
                for (NSDictionary *dic in responseObject[@"data"][@"timetable"]) {
                    [optionArray addObject:dic[@"name"]];
                }
            }
            datePicker.options = optionArray;
            self.selectMonth = [NSString stringWithFormat:@"%ld",(long)currentMonth];
            self.selectDay = [NSString stringWithFormat:@"%ld",(long)currentday];
            self.selectYear = [NSString stringWithFormat:@"%ld",(long)currentYear];
            [datePicker show];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"该日期不可选" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)setPickerDoneCallback:(NSInteger)index PickerView:(CustomPickerView *)pickerView {
    self.reserView= [ReserveView createView];
    self.reserView.delegate = self;
    [self.reserView.clinicImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/clinic/%@",self.clinicImageString]]];
    self.reserView.clinicNameLB.text = self.clinicName;
    self.reserView.targetDate = self.targetDate;
    self.reserView.timeLB.text = [NSString stringWithFormat:@"%@ %@",self.targetDate,pickerView.options[index]];
    self.reserView.holdTime = pickerView.options[index];
    self.reserView.clinicId = self.clinicId1;
    self.reserView.doctorId = self.doctorId1;
    self.reserView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64- 50);
    [self.view addSubview:self.reserView];

}
-(void)ReserveViewDelegateOnclikePrivacy:(ReserveView *)view {

}

-(void)ReserveViewDelegateOnclikeSubmitButton:(ReserveView *)view {

}

-(void)ReserveViewDelegateOnclikeLeftButton:(ReserveView *)view {

}
-(void)ReserveViewDelegateOnclikeDismisView:(ReserveView *)view {
    [self.reserView removeFromSuperview];
}
- (IBAction)onRightButton:(UIButton *)sender {

}

@end
