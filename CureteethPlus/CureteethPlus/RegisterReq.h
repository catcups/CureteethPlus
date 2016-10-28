//
//  RegisterReq.h
//  CureteethPlus
//
//  Created by Denny on 16/8/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface RegisterReq : DPostRequest
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *password;
@property (nonatomic,strong)NSString *code;
@end
