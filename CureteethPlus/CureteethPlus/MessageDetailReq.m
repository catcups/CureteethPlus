//
//  MessageDetailReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/21.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MessageDetailReq.h"

@implementation MessageDetailReq
- (NSString *)path {
    return @"appDoctor/Message/messageDetails";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    if (self.meassageId) {
        [dic setObject:self.meassageId forKey:@"id"];
        NSString *str = [NSString stringWithFormat:@"id=%@helloYya",self.meassageId];
        [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    }
    return dic;
}

- (id)processResponse:(id)object {
    return object;
}
@end
