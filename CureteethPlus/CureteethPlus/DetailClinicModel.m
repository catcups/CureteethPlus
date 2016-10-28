//
//  DetailClinicModel.m
//  CureteethPlus
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DetailClinicModel.h"

@implementation DetailClinicModel
-(id)initWithDic:(NSDictionary *)dic {
    DetailClinicModel *model = [[DetailClinicModel alloc]init];
    model.address = dic[@"address"];
    model.clinicCertificate = dic[@"clinicCertificate"];
    model.clinicCertificateNo = dic[@"clinicCertificateNo"];
    model.clinicLat = dic[@"clinicLat"];
    model.clinicLng = dic[@"clinicLng"];
    model.clinicLogo =dic[@"clinicLogo"];
    model.clinicId = dic[@"clinic_id"];
    model.closeTime = dic[@"close_time"];
    model.createTime = dic[@"create_time"];
    model.description1 = dic[@"description"];
    model.healthCommission = dic[@"healthCommission"];
    model.healthCommissionNo = dic[@"healthCommissionNo"];
    model.name = dic[@"name"];
    model.openTime = dic[@"open_time"];
    model.telephone = dic[@"telephone"];
    if ([dic[@"open_time"] isKindOfClass:[NSNull class]]) {
        model.openTime = @"";
    }
    if ([dic[@"close_time"] isKindOfClass:[NSNull class]]) {
        model.closeTime = @"";
    }
    model.time =[NSString stringWithFormat:@"%@ ~ %@",model.openTime,model.closeTime];
    return model;
}
@end
