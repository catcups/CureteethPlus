//
//  ClassifyReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/21.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ClassifyReq.h"
#import "SearchDoctorModel.h"

@implementation ClassifyReq
-(NSString *)path {
    return @"appCustomer/index/classify";
}
- (NSMutableDictionary *)params {
    NSMutableDictionary *dic = [super params];
    [dic setObject:self.classify forKey:@"classify"];
    [dic setObject:[CommonTool readUserDefaultsByKey:Klat] forKey:@"lat"];
    [dic setObject:[CommonTool readUserDefaultsByKey:Klng] forKey:@"lng"];
    [dic setObject:self.count forKey:@"count"];
    [dic setObject:self.start forKey:@"start"];
    NSString *str = [NSString stringWithFormat:@"classify=%@&count=%@&lat=%@&lng=%@&start=%@helloYya",self.classify,self.count,[CommonTool readUserDefaultsByKey:Klat],[CommonTool readUserDefaultsByKey:Klng],self.start];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}

-(id)processResponse:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    if (object[@"data"][@"doctor"]) {
        for (NSDictionary *dic in object[@"data"][@"doctor"]) {
            [array addObject:[[SearchDoctorModel alloc]initWithDic:dic]];
        }
    }
    return array;
}
@end
