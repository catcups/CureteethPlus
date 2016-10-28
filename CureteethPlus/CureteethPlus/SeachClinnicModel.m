//
//  SeachClinnicModel.m
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "SeachClinnicModel.h"

@implementation SeachClinnicModel
-(id)initWithDic:(NSDictionary *)dic {
    SeachClinnicModel *model = [[SeachClinnicModel alloc]init];
    model.clinicLogo = dic[@"clinicLogo"];
    model.clinicId = dic[@"clinic_id"];
    NSString *nStr = dic[@"description"];
    nStr = [nStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    nStr = [nStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    nStr = [nStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    nStr = [nStr stringByReplacingOccurrencesOfString:@"\p" withString:@""];
    
    model.description1 = nStr;
    model.distance = [NSString stringWithFormat:@"%@km",dic[@"distance"]];
    if (![dic[@"open_time"] isKindOfClass:[NSNull class]]) {
        model.openTime = dic[@"open_time"];
    }else{
        model.openTime = @"";
    }
    if (![dic[@"close_time"] isKindOfClass:[NSNull class]]) {
        model.closeTime = dic[@"close_time"];
    }else {
        model.closeTime = @"";
    }
    model.clinicName = dic[@"clinic_name"];
    return model;
}
@end
