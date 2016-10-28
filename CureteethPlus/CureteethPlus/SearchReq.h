//
//  SearchReq.h
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface SearchReq : DPostRequest
@property (nonatomic,strong)NSString *searchText;
@property (nonatomic,strong)NSNumber *count;
@property (nonatomic,strong)NSNumber *start;

@end
