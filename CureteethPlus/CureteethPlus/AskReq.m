//
//  AskReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/27.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AskReq.h"
#import "AskModel.h"
@implementation AskReq
- (NSString *)path {
    return @"appCustomer/advisory/consult";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    if (self.clinicId) {
        [dic setObject:self.clinicId forKey:@"clinic_id"];
    }
    if (self.doctorId) {
        [dic setObject:self.doctorId forKey:@"doctor_id"];
    }
    if (self.lng) {
        [dic setObject:self.lng forKey:@"lng"];
    }
    if (self.lat) {
        [dic setObject:self.lat forKey:@"lat"];
    }
    NSString *str;
    if (self.doctorId && self.clinicId) {
        str = [NSString stringWithFormat:@"clinic_id=%@&doctor_id=%@helloYya",self.clinicId,self.doctorId];
    }else if (self.doctorId && !self.clinicId){
        str=[NSString stringWithFormat:@"doctor_id=%@helloYya",self.doctorId];
    }else if (!self.doctorId && self.clinicId){
        str=[NSString stringWithFormat:@"clinic_id=%@helloYya",self.clinicId];
    }else{
        str = [NSString stringWithFormat:@"lat=%@&lng=%@helloYya",self.lat,self.lng];
    }
    
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}

-(id)processResponse:(id)object {
    if (object[@"data"]) {
        return  [[AskModel alloc]initWithDic:object[@"data"]];
    }else {
        return nil;
    }
}
@end
