//
//  AskListReq.h
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface AskListReq : DPostRequest
@property(nonatomic,strong)NSString *customerId;
@property(nonatomic,strong)NSString *unAdv;
@property(nonatomic,strong)NSString *Advisory;
@property(nonatomic,strong)NSString *oldAdV;

@end
