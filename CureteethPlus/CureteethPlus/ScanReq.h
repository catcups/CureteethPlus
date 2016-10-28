//
//  ScanReq.h
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface ScanReq : DPostRequest
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *orderId;
@end
