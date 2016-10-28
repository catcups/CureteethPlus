//
//  ReseverSubmitReq.h
//  CureteethPlus
//
//  Created by Denny on 16/7/29.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface ReseverSubmitReq : DPostRequest
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSString *customerId;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *password;
@property (nonatomic,strong)NSString *targetDate;
@property (nonatomic,strong)NSString *holdTime;
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *code;

@end
