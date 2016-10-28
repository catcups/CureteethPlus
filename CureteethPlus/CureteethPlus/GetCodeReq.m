//
//  GetCodeReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "GetCodeReq.h"

@implementation GetCodeReq
- (NSString *)path {
    return @"appDoctor/index/getSmscode";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.type forKey:@"type"];
    [dic setObject:self.mobile forKey:@"mobile"];
    NSString *str = [NSString stringWithFormat:@"mobile=%@&type=%@helloYya",self.mobile,self.type];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}

@end
