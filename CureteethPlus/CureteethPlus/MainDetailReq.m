//
//  MainDetailReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MainDetailReq.h"
#import "DetailClinicModel.h"
#import "SearchDoctorModel.h"
@implementation MainDetailReq
- (NSString *)path {
    return @"appCustomer/clinic/index";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.clinicId forKey:@"clinic_id"];
    NSString *str = [NSString stringWithFormat:@"clinic_id=%@helloYya",self.clinicId];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}

-(id)processResponse:(id)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (object[@"data"][@"clinic"]) {
        DetailClinicModel *clinic = [[DetailClinicModel alloc]initWithDic:object[@"data"][@"clinic"]];
        clinic.imageArray = [NSMutableArray array];
        if (object[@"data"][@"photos"]) {
            for (NSDictionary *dicc in object[@"data"][@"photos"]) {
                if (dicc[@"photo_path"]) {
                     [clinic.imageArray addObject:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/clinic/%@",[dicc[@"photo_path"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                }
            }
        }
        [dic setObject:clinic forKey:@"clinicModel"];
    }
    if (object[@"data"][@"doctors"]) {
        NSMutableArray *doctorArray = [NSMutableArray array];
        for (NSDictionary *diccc in object[@"data"][@"doctors"]) {
           [doctorArray addObject:[[SearchDoctorModel alloc]initWithDic:diccc]];
        }
        [dic setObject:doctorArray forKey:@"doctorArray"];
    }
    return dic;
}
@end
