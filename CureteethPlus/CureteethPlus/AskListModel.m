//
//  AskListModel.m
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AskListModel.h"

@implementation AskListModel
-(id)initWithDic:(NSDictionary *)dic {
    AskListModel *model = [[AskListModel alloc]init];
    if (![dic[@"photo"] isKindOfClass:[NSNull class]]) {
        model.photo = dic[@"photo"];
    }
    if (![dic[@"name"] isKindOfClass:[NSNull class]]) {
        model.name = dic[@"name"];
    }
    model.time = [StringUtils timeChange:dic[@"time"]];
    model.content = dic[@"content"];
    model.askId = dic[@"id"];
    return model;
}
@end
