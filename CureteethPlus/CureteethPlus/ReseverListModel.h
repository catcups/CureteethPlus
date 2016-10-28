//
//  ReseverListModel.h
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReseverListModel : NSObject
@property (nonatomic,strong)NSString *holdTime;
@property (nonatomic,strong)NSString *photo;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *targetDate;
@property (nonatomic,strong)NSString *clinicName;


-(id)initWithDic:(NSDictionary *)dic;
@end
