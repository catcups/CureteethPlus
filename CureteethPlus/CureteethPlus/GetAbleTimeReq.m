//
//  GetAbleTimeReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/29.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "GetAbleTimeReq.h"

@implementation GetAbleTimeReq
- (NSString *)path {
    return @"appCustomer/appointment/getDoctorTimetableByMonth";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.clinicId forKey:@"clinic_id"];
    [dic setObject:self.doctorId forKey:@"doctor_id"];
    [dic setObject:self.year forKey:@"year"];
    [dic setObject:self.month forKey:@"month"];
    NSString  *str = [NSString stringWithFormat:@"clinic_id=%@&doctor_id=%@&month=%@&year=%@helloYya",self.clinicId,self.doctorId,self.month,self.year];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}
@end
