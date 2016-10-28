//
//  BannerModel.m
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel
-(id)initWithDic:(NSDictionary *)dic {
    BannerModel *model = [[BannerModel alloc]init];
    model.advpic = dic[@"advpic"];
    model.createtime = dic[@"createtime"];
    return model;
}
@end
