//
//  ForgetPasswordReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ForgetPasswordReq.h"

@implementation ForgetPasswordReq
- (NSString *)path {
    return @"appDoctor/login/forgotPass";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.mobile forKey:@"mobile"];
    [dic setObject:self.password forKey:@"password"];
    [dic setObject:self.repassword forKey:@"repassword"];
    [dic setObject:self.verify forKey:@"verify"];
    NSString *str = [NSString stringWithFormat:@"mobile=%@&password=%@&repassword=%@&verify=%@helloYya",self.mobile,self.password,self.repassword,self.verify];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    return dic;
}
@end
