//
//  ReplyReq.h
//  CureTeeth
//
//  Created by Denny on 16/7/26.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface ReplyReq : DPostRequest
@property (nonatomic,strong)NSString *advisoryId;
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSString *fromId;
@property (nonatomic,strong)NSString *toId;
@end
