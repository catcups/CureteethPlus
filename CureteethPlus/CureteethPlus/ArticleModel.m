//
//  ArticleModel.m
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
-(id)initWithDic:(NSDictionary *)dic {
    ArticleModel *model = [[ArticleModel alloc]init];
    model.title = dic[@"title"];
    model.createTime = [StringUtils timeChange:dic[@"create_time"]];
    model.content = dic[@"content"];
    return model;
}
@end
