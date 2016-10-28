//
//  AskModel.m
//  CureteethPlus
//
//  Created by Denny on 16/7/27.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AskModel.h"

@implementation AskModel
- (id)initWithDic:(NSDictionary *)dic {
    AskModel *model = [[AskModel alloc]init];
    model.clinicId = dic[@"clinic_id"];
    model.clinicLogo = dic[@"clinicLogo"];
    model.clinicName = dic[@"clinic_name"];
    model.doctorId = dic[@"doctor_id"];
    model.doctorName = dic[@"doctor_name"];
    if (model.doctorName == nil) {
         model.doctorName = dic[@"name"];
    }
    model.doctorModelArray = [NSMutableArray array];
    if([dic[@"doctors"] isKindOfClass:[NSArray class]]){
        if (dic[@"doctors"]) {
            for (NSDictionary *dicc in dic[@"doctors"]) {
                [model.doctorModelArray addObject:[[DoctorModel alloc] initWithDic:dicc]];
            }
        }
    }else{
    [model.doctorModelArray addObject:[[DoctorModel alloc] initWithDic:dic[@"doctors"]]];
    }
 
    if (!model.doctorName && model.doctorModelArray.count != 0) {
        DoctorModel *docotor=model.doctorModelArray[0];
        model.doctorName= docotor.name;
    }
    if (!model.doctorId && model.doctorModelArray.count != 0) {
        DoctorModel *docotor=model.doctorModelArray[0];
        model.doctorId= docotor.doctorId;
    }
        return model;
}
@end
