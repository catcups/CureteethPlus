//
//  GetAskReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/28.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "GetAskReq.h"

@implementation GetAskReq
-(NSString *)path {
    return @"appCustomer/advisory/applyAdvisory";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    if (self.customerId) {
        [dic setObject:self.customerId forKey:@"customer_id"];
    }
    if (self.mobile) {
        [dic setObject:self.mobile forKey:@"mobile"];
    }
    if (self.code) {
        [dic setObject:self.code forKey:@"code"];
    }
    if (self.passowrd) {
        [dic setObject:self.passowrd forKey:@"password"];
    }
    
    if (self.clinicId) {
        [dic setObject:self.clinicId forKey:@"clinic_id"];
    }
    if (self.doctorId){
        [dic setObject:self.doctorId forKey:@"doctor_id"];
    }
    if (self.content) {
        [dic setObject:self.content forKey:@"content"];
    }
    if (self.askMore) {
        [dic setObject:self.askMore forKey:@"askMore"];
    }
    self.content = [self.content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSString *str;
    if (self.customerId) {
        if(self.code){
            str = [NSString stringWithFormat:@"askMore=%@&clinic_id=%@&code=%@&content=%@&customer_id=%@&doctor_id=%@&mobile=%@&password%@helloYya",self.askMore,self.clinicId,self.code,self.content,self.customerId,self.doctorId,self.mobile,self.passowrd];
        }else {
            str = [NSString stringWithFormat:@"askMore=%@&clinic_id=%@&content=%@&customer_id=%@&doctor_id=%@&mobile=%@&password=%@helloYya",self.askMore,self.clinicId,self.content,self.customerId,self.doctorId,self.mobile,self.passowrd];
        }
    }else{
        if(self.code){
            str = [NSString stringWithFormat:@"askMore=%@&clinic_id=%@&code=%@&content=%@&doctor_id=%@&mobile=%@&password%@helloYya",self.askMore,self.clinicId,self.code,self.content,self.doctorId,self.mobile,self.passowrd];
        }else {
            str = [NSString stringWithFormat:@"askMore=%@&clinic_id=%@&content=%@&doctor_id=%@&mobile=%@&password=%@helloYya",self.askMore,self.clinicId,self.content,self.doctorId,self.mobile,self.passowrd];
        }
    }

    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}
@end
