//
//  ReseverSubmitReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/29.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ReseverSubmitReq.h"

@implementation ReseverSubmitReq
-(NSString *)path {
    return @"appCustomer/appointment/upAppointment";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
     if (self.clinicId) {
        [dic setObject:self.clinicId forKey:@"clinic_id"];
    }if (self.doctorId) {
        [dic setObject:self.doctorId forKey:@"doctor_id"];
    }if (self.targetDate) {
        [dic setObject:self.targetDate forKey:@"targetDate"];
    }if (self.holdTime) {
        [dic setObject:self.holdTime forKey:@"hold_time"];
    }if (self.message) {
        [dic setObject:self.message forKey:@"message"];
        self.message = [self.message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }if (self.password) {
        [dic setObject:self.password forKey:@"password"];
    }if (self.code) {
        [dic setObject:self.code forKey:@"code"];
    }if (self.name) {
        [dic setObject:self.name forKey:@"name"];
        self.name = [self.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }if (self.mobile) {
        [dic setObject:self.mobile forKey:@"mobile"];
    }if (self.customerId) {
        [dic setObject:self.customerId forKey:@"customer_id"];
    }

    NSString  *str;
    if ([CommonTool readUserDefaultsByKey:KisLogin]){
        if(self.message){
            str = [NSString stringWithFormat:@"clinic_id=%@&customer_id=%@&doctor_id=%@&hold_time=%@&message=%@&mobile=%@&name=%@&targetDate=%@helloYya",self.clinicId,self.customerId,self.doctorId,self.holdTime,self.message,self.mobile,self.name,self.targetDate];

        }else{
            str = [NSString stringWithFormat:@"clinic_id=%@&customer_id=%@&doctor_id=%@&hold_time=%@&mobile=%@&name=%@&targetDate=%@helloYya",self.clinicId,self.customerId,self.doctorId,self.holdTime,self.mobile,self.name,self.targetDate];
        }
    }else {
        if (self.code) {
            if (self.message) {
                 str = [NSString stringWithFormat:@"clinic_id=%@&code=%@&doctor_id=%@&hold_time=%@&message=%@&mobile=%@&name=%@&targetDate=%@helloYya",self.clinicId,self.code,self.doctorId,self.holdTime,self.message,self.mobile,self.name,self.targetDate];
            }else{
                str = [NSString stringWithFormat:@"clinic_id=%@&code=%@&doctor_id=%@&hold_time=%@&mobile=%@&name=%@&targetDate=%@helloYya",self.clinicId,self.code,self.doctorId,self.holdTime,self.mobile,self.name,self.targetDate];
            }
           
        }else {
            if (self.message) {
                str = [NSString stringWithFormat:@"clinic_id=%@&doctor_id=%@&hold_time=%@&message=%@&mobile=%@&name=%@&password=%@&targetDate=%@helloYya",self.clinicId,self.doctorId,self.holdTime,self.message,self.mobile,self.name,self.password,self.targetDate];
            }else{
                str = [NSString stringWithFormat:@"clinic_id=%@&doctor_id=%@&hold_time=%@&mobile=%@&name=%@&password=%@&targetDate=%@helloYya",self.clinicId,self.doctorId,self.holdTime,self.mobile,self.name,self.password,self.targetDate];
            }
        }
    }
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}
@end
