//
//  MainDetailReq.h
//  CureteethPlus
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface MainDetailReq : DPostRequest
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSNumber *start;
@property (nonatomic,strong)NSNumber *count;
@end
