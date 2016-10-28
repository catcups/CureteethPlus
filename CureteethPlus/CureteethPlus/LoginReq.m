//
//  LoginReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "LoginReq.h"

@implementation LoginReq
- (NSString *)path {
    return @"appCustomer/Login/loginAction";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.password forKey:@"password"];
    [dic setObject:self.mobile forKey:@"mobile"];
    NSString *str = [NSString stringWithFormat:@"mobile=%@&password=%@helloYya",self.mobile,self.password];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}

-(id)processResponse:(id)object {
    if (object[@"data"]) {
        return object[@"data"];
    }
    return object;
}
@end
