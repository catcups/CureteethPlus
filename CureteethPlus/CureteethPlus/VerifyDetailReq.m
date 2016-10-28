//
//  VerifyDetailReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/27.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "VerifyDetailReq.h"

@implementation VerifyDetailReq
- (NSString *)path {
    return @"appCustomer/clinic/verifyDetail";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.clinicId forKey:@"clinic_id"];
    NSString *str = [NSString stringWithFormat:@"clinic_id=%@helloYya",self.clinicId];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}
@end
