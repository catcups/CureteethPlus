//
//  MainReq.h
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface MainReq : DPostRequest
@property (nonatomic,strong)NSString *lng;
@property (nonatomic,strong)NSString *lat;
@property (nonatomic,strong)NSNumber *count;
@property(nonatomic,strong)NSNumber *start;
@end
