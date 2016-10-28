//
//  RegisterReq.m
//  CureteethPlus
//
//  Created by Denny on 16/8/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "RegisterReq.h"

@implementation RegisterReq
-(NSString *)path {
    return @"appCustomer/login/registerAction";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.code forKey:@"code"];
    [dic setObject:self.password forKey:@"password"];
    [dic setObject:self.mobile forKey:@"mobile"];
    NSString *str = [NSString stringWithFormat:@"code=%@&mobile=%@&password=%@helloYya",self.code,self.mobile,self.password];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    

    return dic;
}

-(id)processResponse:(id)object {
    return object;
}

@end
