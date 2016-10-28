//
//  ScanModel.h
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanModel : NSObject
@property (nonatomic,strong)NSString *orderTime;
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *targetDate;
@property (nonatomic,strong)NSString *timeslot;
@property (nonatomic,strong)NSString *orderStatus;
@property (nonatomic,strong)NSString *holdTime;
@property (nonatomic,strong)NSString *clinicName;
@property (nonatomic,strong)NSString *doctorName;
@property (nonatomic,strong)NSString *customerName;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *photo;

- (id)initWithDic:(NSDictionary *)dic;

@end
