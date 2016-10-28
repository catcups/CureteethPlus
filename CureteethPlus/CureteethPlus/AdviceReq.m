
//
//  AdviceReq.m
//  CureteethPlus
//
//  Created by Denny on 16/8/4.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AdviceReq.h"

@implementation AdviceReq
- (NSString *)path {
    return @"appCustomer/personal/suggestions";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    if (self.customerId) {
        [dic setObject:self.customerId forKey:@"customer_id"];
    }
    if (self.question) {
        [dic setObject:self.question forKey:@"question"];
    }
    
    if (self.content) {
        [dic setObject:self.content forKey:@"content"];
    }
    NSString *str = [NSString stringWithFormat:@"content=%@&customer_id=%@&question=%@helloYya",self.content,self.customerId,self.question];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}
@end
