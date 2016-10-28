//
//  SeachClinnicModel.h
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeachClinnicModel : NSObject
@property (nonatomic,strong)NSString *clinicLogo;
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSString *clinicName;
@property (nonatomic,strong)NSString *description1;
@property (nonatomic,strong)NSString *distance;
@property (nonatomic,strong)NSString *openTime;
@property (nonatomic,strong)NSString *closeTime;

-(id)initWithDic:(NSDictionary *)dic;
@end
