//
//  ReseverLiatReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ReseverLiatReq.h"
#import "ReseverListModel.h"
@implementation ReseverLiatReq
- (NSString *)path {
    return @"appCustomer/Personal/appointmentList";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:[CommonTool readUserDefaultsByKey:KCustomerId] forKey:@"customer_id"];
    if (self.unApp) {
        [dic setObject:self.unApp forKey:@"unApp"];
        NSString *str = [NSString stringWithFormat:@"customer_id=%@&unApp=%@helloYya",[CommonTool readUserDefaultsByKey:KCustomerId],self.unApp];
        [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    }
    if (self.oldApp) {
        NSString *str = [NSString stringWithFormat:@"customer_id=%@&oldApp=%@helloYya",[CommonTool readUserDefaultsByKey:KCustomerId],self.oldApp];
        [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

        [dic setObject:self.oldApp forKey:@"oldApp"];
    }
    return dic;
}

-(id)processResponse:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    if (object[@"data"]) {
        for (NSDictionary *dic in object[@"data"]) {
            [array addObject:[[ReseverListModel alloc]initWithDic:dic]];
        }
    }
    return array;
}

@end
