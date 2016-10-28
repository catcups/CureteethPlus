//
//  MainReq.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MainReq.h"
#import "ArticleModel.h"
#import "BannerModel.h"
#import "ClinincModel.h"
#import "IconModel.h"
@implementation MainReq
- (NSString *)path {
    return @"appCustomer/index/index";
}

-(NSMutableDictionary *)params {
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    if (self.lat) {
        [dic setObject:self.lat forKey:@"lat"];
    }
    if (self.lng) {
        [dic setObject:self.lng forKey:@"lng"];
    }
    if (self.count) {
        [dic setObject:self.count forKey:@"count"];
    }
    if (self.start) {
        [dic setObject:self.start forKey:@"start"];
    }
    NSString *str = [NSString stringWithFormat:@"count=%@&lat=%@&lng=%@&start=%@helloYya",self.count,self.lat,self.lng,self.start];
    [dic setObject:[StringUtils md5FromString:str] forKey:@"mdkey"];
    return dic;
}

-(id)processResponse:(id)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *articleArray = [NSMutableArray array];
    if (object[@"data"][@"article"]) {
        for (NSDictionary *dic in object[@"data"][@"article"]) {
            [articleArray addObject:[[ArticleModel alloc] initWithDic:dic]];
        }
    }
    [dic setObject:articleArray forKey:@"articleArray"];
    
    NSMutableArray *bannerArray = [NSMutableArray array];
    if (object[@"data"][@"banner"]) {
        for (NSDictionary *dic in object[@"data"][@"banner"]) {
            [bannerArray addObject:[[BannerModel alloc] initWithDic:dic]];
        }
    }
    [dic setObject:bannerArray forKey:@"bannerArray"];
    
    NSMutableArray *bannerImageArray = [NSMutableArray array]; //
    if (object[@"data"][@"banner"]) {
//        for (NSDictionary *dic in object[@"data"][@"banner"]) {
//            [bannerImageArray addObject:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/%@",dic[@"advpic"]]]];
//        }
        [bannerImageArray addObject:[NSURL URLWithString:@"http://www.yyaai.com/uploads/1463622289.jpg"]];
    }
    [dic setObject:bannerImageArray forKey:@"bannerImageArray"];
    
    NSMutableArray *clinincArray = [NSMutableArray array];
    if (object[@"data"][@"clinic"]) {
        for (NSDictionary *dic in object[@"data"][@"clinic"]) {
            [clinincArray addObject:[[ClinincModel alloc] initWithDic:dic]];
        }
    }
    [dic setObject:clinincArray forKey:@"clinincArray"];
    
    
    NSMutableArray *iconArray = [NSMutableArray array];
    if (object[@"data"][@"icon"]) {
        for (NSDictionary *dic in object[@"data"][@"icon"]) {
            [iconArray addObject:[[IconModel alloc] initWithDic:dic]];
        }
    }
    [dic setObject:iconArray forKey:@"iconArray"];
    return dic;
}
@end
