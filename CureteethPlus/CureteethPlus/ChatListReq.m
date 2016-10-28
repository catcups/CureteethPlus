//
//  ChatListReq.m
//  CureTeeth
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ChatListReq.h"

@implementation ChatListReq
- (NSString *)path {
    return @"appCustomer/advisory/advisoryDetails";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.advisoryId forKey:@"advisory_id"];
    NSString *str = [NSString stringWithFormat:@"advisory_id=%@helloYya",self.advisoryId];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}

-(id)processResponse:(id)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *array = [NSMutableArray array];
    if (object[@"data"][@"info"]) {
        for (NSDictionary *dic in object[@"data"][@"info"]) {
            [array addObject:[[Message alloc] initWithModel:dic]];
        }
    }
    if (object[@"data"][@"reply"]) {
        for (NSDictionary *dic in object[@"data"][@"reply"]) {
            [array addObject:[[Message alloc] initWithReplyModel:dic andCustomerId:object[@"data"][@"info"][0][@"customer_id"]]];
        }
    }
    [dic setObject:[self changeIndexWithArray:array] forKey:@"dataSourceArray"];
    if (object[@"data"][@"info"][0][@"userphoto"] && ![object[@"data"][@"info"][0][@"userphoto"] isKindOfClass:[NSNull class]]) {
        [dic setObject:[NSURL URLWithString:object[@"data"][@"info"][0][@"userphoto"]] forKey:@"userPhoto"];
    }
    if (object[@"data"][@"info"][0][@"doctorsphoto"] && ![object[@"data"][@"info"][0][@"doctorsphoto"] isKindOfClass:[NSNull class]]) {
        [dic setObject:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/doctor/%@",object[@"data"][@"info"][0][@"doctorsphoto"]]] forKey:@"doctorsphoto"];
    }
    return dic;
}

-(NSArray *)changeIndexWithArray:(NSMutableArray *)array {
    NSInteger a = array.count;
    Message * tempMessage = [[Message alloc] init];
    for (int i = 0; i<a-1; i++) {
        for (int j =0; j<a-i-1; j++) {
            Message *message1 = array[j + 1];
            NSString *str1 = [NSString string];
            if (message1.isSelf) {
                str1 = message1.createTime;
            }else {
                str1 = message1.time;
            }
            Message *message2 = array[j];
            NSString *str2 = [NSString string];
            if (message2.isSelf) {
                str2 = message1.createTime;
            }else {
                str2 = message1.time;
            }
            if ([StringUtils compareDate:str1 withDate:str2] > 0) {
                tempMessage = array[j];
                [array exchangeObjectAtIndex:j withObjectAtIndex:(j + 1)];
                array[j] = array[j + 1];
                [array replaceObjectAtIndex:(j + 1) withObject:tempMessage];
            }
        }
    }
    return array;
}
@end
