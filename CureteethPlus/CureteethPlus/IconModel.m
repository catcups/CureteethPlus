//
//  IconModel.m
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "IconModel.h"

@implementation IconModel
-(id)initWithDic:(NSDictionary *)dic {
    IconModel *model = [[IconModel alloc]init];
    model.icon1 = dic[@"icon1"];
    model.icon1Img = dic[@"icon1_img"];
    model.icon2 = dic[@"icon2"];
    model.icon2Img = dic[@"icon2_img"];
    model.icon3 = dic[@"icon3"];
    model.icon3Img = dic[@"icon3_img"];
    model.icon4 = dic[@"icon4"];
    model.icon4Img = dic[@"icon4_img"];
    model.icon5 = dic[@"icon5"];
    model.icon5Img = dic[@"icon5_img"];
    model.icon6 = dic[@"icon6"];
    model.icon6Img = dic[@"icon6_img"];
    model.icon7 = dic[@"icon7"];
    model.icon7Img = dic[@"icon7_img"];
    model.icon8 = dic[@"icon8"];
    model.icon8Img = dic[@"icon8_img"];
    model.icon9 = dic[@"icon9"];
    model.icon9Img = dic[@"icon9_img"];
    model.icon10 = dic[@"icon10"];
    model.icon10Img = dic[@"icon10_img"];
    return model;
}
@end
