//
//  ChatListReq.h
//  CureTeeth
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"
#import "Message.h"
@interface ChatListReq : DPostRequest
@property (nonatomic,strong)NSString *advisoryId;
@property (nonatomic,strong)NSString *doctorId;

@end
