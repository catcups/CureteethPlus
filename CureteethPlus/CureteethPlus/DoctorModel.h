//
//  DoctorModel.h
//  CureteethPlus
//
//  Created by Denny on 16/7/27.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorModel : NSObject
@property (nonatomic,strong)NSString *active;
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSString *photo;
@property (nonatomic,strong)NSString *check;
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSMutableArray *cstatus;
- (id)initWithDic:(NSDictionary *)dic;
@end
