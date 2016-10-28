//
//  LoginReq.h
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface LoginReq : DPostRequest
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *password;
@end
