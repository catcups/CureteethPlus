//
//  SearchDoctorModel.m
//  
//
//  Created by Denny on 16/7/18.
//
//

#import "SearchDoctorModel.h"

@implementation SearchDoctorModel
-(id)initWithDic:(NSDictionary *)dic {
    SearchDoctorModel *model = [[SearchDoctorModel alloc]init];
    if (![dic[@"aboutMe"] isKindOfClass:[NSNull class]]) {
        model.aboutMe = dic[@"aboutMe"];
    }
    if (![dic[@"clinic_id"] isKindOfClass:[NSNull class]]) {
        model.clinicId = dic[@"clinic_id"];
    }
    if (![dic[@"clinic_name"] isKindOfClass:[NSNull class]]) {
        model.clinicName = dic[@"clinic_name"];
    }
    if (![dic[@"doctor_id"] isKindOfClass:[NSNull class]]) {
        model.doctorId = dic[@"doctor_id"];
    }
    if (![dic[@"name"] isKindOfClass:[NSNull class]]) {
        model.name = dic[@"name"];
    }
    if (![dic[@"photo"] isKindOfClass:[NSNull class]]) {
        model.photo = dic[@"photo"];
    }
    if (![dic[@"practitionerNo"] isKindOfClass:[NSNull class]]) {
        model.practitionerNo = dic[@"practitionerNo"];
    }
    return model;
}

@end
