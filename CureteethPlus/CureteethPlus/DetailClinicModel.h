//
//  DetailClinicModel.h
//  CureteethPlus
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailClinicModel : NSObject
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *clinicCertificate;
@property (nonatomic,strong)NSString *clinicCertificateNo;
@property (nonatomic,strong)NSString *clinicLat;
@property (nonatomic,strong)NSString *clinicLng;
@property (nonatomic,strong)NSString *clinicLogo;
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSString *closeTime;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *description1;
@property (nonatomic,strong)NSString *healthCommission;
@property (nonatomic,strong)NSString *healthCommissionNo;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *openTime;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *telephone;
@property (nonatomic,strong)NSMutableArray *imageArray;
-(id)initWithDic:(NSDictionary *)dic;

@end
