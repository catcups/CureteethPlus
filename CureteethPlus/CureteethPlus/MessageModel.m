//
//  MessageModel.m
//  CureTeeth
//
//  Created by Denny on 16/7/20.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
- (id)initWithDic:(NSDictionary *)dic {
    MessageModel *model = [[MessageModel alloc]init];
    model.doctorId = dic[@"doctor_id"];
    model.messageId = dic[@"id"];
    model.message = dic[@"message"];
    model.look = dic[@"look"];
    model.time = dic[@"time"];
    model.type = dic[@"type"];
    model.title = dic[@"title"];
    return model;
}
@end
