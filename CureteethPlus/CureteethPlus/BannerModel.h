//
//  BannerModel.h
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject
@property (nonatomic,strong)NSString *advpic;
@property (nonatomic,strong)NSString *createtime;


-(id)initWithDic:(NSDictionary *)dic;

@end
