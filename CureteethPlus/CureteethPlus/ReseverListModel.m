//
//  ReseverListModel.m
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ReseverListModel.h"

@implementation ReseverListModel
-(id)initWithDic:(NSDictionary *)dic {
    ReseverListModel *model = [[ReseverListModel alloc]init];
    model.holdTime = dic[@"hold_time"];
    model.name = dic[@"dname"];
    model.photo = dic[@"photo"];
    model.targetDate = dic[@"targetDate"];
    model.clinicName = dic[@"cname"];
    return model;
}
@end
