//
//  DoctorModel.m
//  CureteethPlus
//
//  Created by Denny on 16/7/27.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DoctorModel.h"

@implementation DoctorModel
- (id)initWithDic:(NSDictionary *)dic {
    DoctorModel *model = [[DoctorModel alloc]init];
    if ([[dic allKeys]containsObject:@"active"]) {
        model.active = dic[@"active"];
    }
    if ([[dic allKeys]containsObject:@"check"]) {
        model.check = dic[@"check"];
    }
    if ([[dic allKeys]containsObject:@"clinic_id"]) {
        model.clinicId = dic[@"clinic_id"];
    }
    if ([[dic allKeys]containsObject:@"doctor"]) {
        model.doctorId = dic[@"doctor"];
    }
    if ([[dic allKeys]containsObject:@"cstatus"]) {
        model.cstatus = dic[@"cstatus"];
    }
    if ([[dic allKeys]containsObject:@"name"]) {
        model.name = dic[@"name"];
    }
    if ([[dic allKeys]containsObject:@"photo"]) {
        model.photo = dic[@"photo"];

    }
    return model;
}
@end
