//
//  GetCodeReq.h
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface GetCodeReq : DPostRequest
@property (nonatomic,strong)NSString *mobile;

@property (nonatomic,strong)NSString *type;

@end
