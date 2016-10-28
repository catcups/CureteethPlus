//
//  ReseverReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/28.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ReseverReq.h"

@implementation ReseverReq
- (NSString *)path {
    return @"appCustomer/appointment/index";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    if (self.doctorId) {
        [dic setObject:self.doctorId forKey:@"doctor_id"];
    }
    if (self.clinicId) {
        [dic setObject:self.clinicId forKey:@"clinic_id"];
    }
    if (self.lng) {
        [dic setObject:self.lng forKey:@"lng"];
    }
    if (self.lat) {
        [dic setObject:self.lat forKey:@"lat"];
    }
    NSString *str;
    if (self.doctorId &&!self.clinicId) {
        str = [NSString stringWithFormat:@"doctor_id=%@helloYya",self.doctorId];
    }else if (self.clinicId && self.doctorId){
        str = [NSString stringWithFormat:@"clinic_id=%@&doctor_id=%@helloYya",self.clinicId,self.doctorId];
    }else if (self.clinicId && !self.doctorId){
        str = [NSString stringWithFormat:@"clinic_id=%@helloYya",self.clinicId];
    }else{
        str = [NSString stringWithFormat:@"lat=%@&lng=%@helloYya",self.lat,self.lng];
    }
    if (str.length != 0) {
        [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    }
    return dic;
}

-(id)processResponse:(id)object {
    if (object[@"data"][@"info"]) {
        if ([object[@"data"][@"info"] isKindOfClass:[NSArray class]]) {
            return object[@"data"][@"info"][0];
        }else{
            if (![object[@"data"][@"info"][@"doctors"] isKindOfClass:[NSArray class]]) {
                return object[@"data"][@"info"];
            }else{
                NSMutableDictionary *dic1 =object[@"data"][@"info"];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:dic1[@"clinicInfo"][@"clinicName"] forKey:@"clinicName"];
                [dic setObject:dic1[@"clinicInfo"][@"clinic_id"] forKey:@"clinic_id"];
                [dic setObject:dic1[@"clinicLogo"] forKey:@"clinicLogo"];
                [dic setObject:dic1[@"doctors"][0][@"doctorName"] forKey:@"doctorName"];
                [dic setObject:dic1[@"doctors"][0][@"doctor_id"] forKey:@"doctor_id"];
                return dic;

            }
                   }
    }else {
        return nil;
    }
}

@end
