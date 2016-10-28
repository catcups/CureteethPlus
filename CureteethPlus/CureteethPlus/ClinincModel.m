//
//  ClinincModel.m
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ClinincModel.h"

@implementation ClinincModel
-(id)initWithDic:(NSDictionary *)dic {
    ClinincModel *model = [[ClinincModel alloc]init];
    model.clinicLogo = dic[@"clinicLogo"];
    model.clinicId = dic[@"clinic_id"];
    NSString *nStr = dic[@"description"];
    nStr = [nStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    nStr = [nStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    nStr = [nStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    nStr = [nStr stringByReplacingOccurrencesOfString:@"\p" withString:@""];

    model.description1 = nStr;
    model.distance = [NSString stringWithFormat:@"%@km",dic[@"distance"]];
    model.isOpen = dic[@"is_open"];
    model.clinicName = dic[@"clinic_name"];
    return model;
}
@end
