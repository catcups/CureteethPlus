//
//  ChangePswReq.h
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface ChangePswReq : DPostRequest
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *oldpass;
@property (nonatomic,strong)NSString *newpass;
@property (nonatomic,strong)NSString *repass;

@end
