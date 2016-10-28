//
//  GetAskReq.h
//  CureteethPlus
//
//  Created by Denny on 16/7/28.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostImageRequest.h"

@interface GetAskReq : DPostImageRequest
@property (nonatomic,strong)NSString *customerId;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *passowrd;
@property (nonatomic,strong)NSString *code;
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *askMore;

@end
