//
//  ArticleModel.h
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"

@interface ArticleModel : DPostRequest
@property (nonatomic,strong)NSString *articleId;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *title;

-(id)initWithDic:(NSDictionary *)dic;
@end
