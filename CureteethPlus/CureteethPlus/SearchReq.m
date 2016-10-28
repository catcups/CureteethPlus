//
//  SearchReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "SearchReq.h"
#import "SeachClinnicModel.h"
#import "SearchDoctorModel.h"
@implementation SearchReq
- (NSString *)path {
    return @"appCustomer/index/search";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.searchText forKey:@"keyword"];
    if (self.count) {
        [dic setObject:self.count forKey:@"count"];
    }
    if (self.start) {
        [dic setObject:self.start forKey:@"start"];
    }
    [dic setObject:[CommonTool readUserDefaultsByKey:Klat] forKey:@"lat"];
    [dic setObject:[CommonTool readUserDefaultsByKey:Klng] forKey:@"lng"];
    NSString *tmpStr = [self.searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSString stringWithFormat:@"count=%@&keyword=%@&lat=%@&lng=%@&start=%@helloYya",self.count, tmpStr,[CommonTool readUserDefaultsByKey:Klat],[CommonTool readUserDefaultsByKey:Klng],self.start];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}

- (id)processResponse:(id)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *clinincArray = [NSMutableArray array];
    NSMutableArray *doctorArray = [NSMutableArray array];
    if (object[@"data"][@"doctor"]) {
        for (NSDictionary *dicc in object[@"data"][@"doctor"]) {
            [doctorArray addObject:[[SearchDoctorModel alloc] initWithDic:dicc]];
        }
    }
    [dic setObject:doctorArray forKey:@"doctorArray"];
    if (object[@"data"][@"list"][@"clinic"]) {
        for (NSDictionary *dicc in object[@"data"][@"list"][@"clinic"]) {
            [clinincArray addObject:[[SeachClinnicModel alloc] initWithDic:dicc]];
        }
    }
    [dic setObject:clinincArray forKey:@"clinincArray"];
    return dic;
}
@end
