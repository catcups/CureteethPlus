//
//  ClassifyReq.h
//  CureteethPlus
//
//  Created by Denny on 16/7/21.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface ClassifyReq : DPostRequest
@property(nonatomic,strong)NSString *classify;
@property(nonatomic,strong)NSNumber *count;
@property(nonatomic,strong)NSNumber *start;
@end
