//
//  AdviceReq.h
//  CureteethPlus
//
//  Created by Denny on 16/8/4.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface AdviceReq : DPostRequest
@property (nonatomic,strong)NSString *customerId;
@property (nonatomic,strong)NSString *question;
@property (nonatomic,strong)NSString *content;
@end
