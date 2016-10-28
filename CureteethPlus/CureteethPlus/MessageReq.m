//
//  MessageReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/20.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MessageReq.h"
#import "MessageModel.h"
@implementation MessageReq
-(NSString *)path {
    return @"appCustomer/Personal/messageType";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:[CommonTool readUserDefaultsByKey:KCustomerId] forKey:@"customer_id"];
    [dic setObject:self.type forKey:@"type"];
    NSString *str = [NSString stringWithFormat:@"customer_id=%@&type=%@helloYya",[CommonTool readUserDefaultsByKey:KCustomerId],self.type];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}

-(id)processResponse:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    if (object[@"data"]) {
        for (NSDictionary *dic in object[@"data"]) {
            [array addObject:[[MessageModel alloc] initWithDic:dic]];
        }
    }
        return array;
}
@end
