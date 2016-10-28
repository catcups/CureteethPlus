//
//  ChangePswReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ChangePswReq.h"

@implementation ChangePswReq
- (NSString *)path {
    return @"appCustomer/Personal/changePassword";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.doctorId forKey:@"customer_id"];
    [dic setObject:self.oldpass forKey:@"oldpass"];
    [dic setObject:self.newpass forKey:@"newpass"];
    [dic setObject:self.repass forKey:@"repass"];
    NSString *str = [NSString stringWithFormat:@"customer_id=%@&newpass=%@&oldpass=%@&repass=%@helloYya",self.doctorId,self.newpass,self.oldpass,self.repass];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}


@end
