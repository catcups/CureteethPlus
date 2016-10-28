//
//  ScanModel.m
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ScanModel.h"

@implementation ScanModel
- (id)initWithDic:(NSDictionary *)dic {
    ScanModel *model = [[ScanModel alloc]init];
    model.orderTime = dic[@"orderTime"];
    model.doctorId = dic[@"doctor_id"];
    model.targetDate = dic[@"targetDate"];
    model.timeslot = dic[@"timeslot"];
    model.orderStatus = dic[@"orderStatus"];
    model.holdTime = dic[@"hold_time"];
    model.clinicName = dic [@"clinic_name"];
    model.doctorName = dic [@"doctor_name"];
    model.customerName = dic [@"customer_name"];
    model.mobile = dic [@"mobile"];
    model.photo = dic [@"photo"];
    return model;
}
@end
