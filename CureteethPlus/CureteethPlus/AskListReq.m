//
//  AskListReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AskListReq.h"
#import "AskListModel.h"
@implementation AskListReq
- (NSString *)path {
    return @"appCustomer/Personal/advisoryList";
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:[CommonTool readUserDefaultsByKey:KCustomerId] forKey:@"customer_id"];
    if (self.unAdv) {
        [dic setObject:self.unAdv forKey:@"unAdv"];
        NSString *str = [NSString stringWithFormat:@"customer_id=%@&unAdv=%@helloYya",[CommonTool readUserDefaultsByKey:KCustomerId],self.unAdv];
        [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

    }
    if (self.Advisory) {
        NSString *str = [NSString stringWithFormat:@"customer_id=%@&newAdvisory=%@helloYya",[CommonTool readUserDefaultsByKey:KCustomerId],self.Advisory];
        [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];

        [dic setObject:self.Advisory forKey:@"newAdvisory"];
    }
    if (self.oldAdV) {
        [dic setObject:self.oldAdV forKey:@"oldAdV"];
        NSString *str = [NSString stringWithFormat:@"customer_id=%@&oldAdV=%@helloYya",[CommonTool readUserDefaultsByKey:KCustomerId],self.oldAdV];
        [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    }
    return dic;
}

-(id)processResponse:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    if (object[@"data"]) {
        for (NSDictionary *dic in object[@"data"]) {
            [array addObject:[[AskListModel alloc] initWithDic:dic]];
        }
    }
    return array;
}
@end
