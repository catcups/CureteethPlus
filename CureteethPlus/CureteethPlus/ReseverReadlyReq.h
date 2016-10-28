//
//  ReseverReadlyReq.h
//  CureteethPlus
//
//  Created by Denny on 16/7/29.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface ReseverReadlyReq : DPostRequest
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSString *year;
@property (nonatomic,strong)NSString *month;
@property (nonatomic,strong)NSString *day;

@end
