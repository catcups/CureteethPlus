//
//  AskReq.h
//  CureteethPlus
//
//  Created by Denny on 16/7/27.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface AskReq : DPostRequest
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *lng;
@property (nonatomic,strong)NSString *lat;

@end
