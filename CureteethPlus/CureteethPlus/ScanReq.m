//
//  ScanReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ScanReq.h"

@implementation ScanReq
- (NSString *)path {
    return @"appDoctor/Personalcenter/Schedule_Management";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:@"D0000001" forKey:@"doctor_id"];
    [dic setObject:@"2016052353515453" forKey:@"orderId"];
    NSString *str = [NSString stringWithFormat:@"doctor_id=%@&orderId=%@helloYya",self.doctorId,self.orderId];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}


@end
