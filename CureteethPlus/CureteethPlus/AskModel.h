//
//  AskModel.h
//  CureteethPlus
//
//  Created by Denny on 16/7/27.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoctorModel.h"
@interface AskModel : NSObject
@property (nonatomic,strong)DoctorModel *doctorModel;
@property (nonatomic,strong)NSString *clinicLogo;
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSString *clinicName;
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *doctorName;
@property (nonatomic,strong)NSMutableArray *doctorModelArray;
- (id)initWithDic:(NSDictionary *)dic;
@end
