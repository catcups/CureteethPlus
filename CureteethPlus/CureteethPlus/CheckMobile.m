//
//  CheckMobile.m
//  CureteethPlus
//
//  Created by Denny on 16/7/28.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "CheckMobile.h"

@implementation CheckMobile
- (NSString *)path {
    return @"appCustomer/advisory/checkMobile";
}
-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.mobile forKey:@"mobile"];
    [dic setObject:[StringUtils md5FromString:[NSString stringWithFormat:@"mobile=%@helloYya",self.mobile]] forKey:@"mdkey"];
    return dic;
}
@end
