//
//  AskListModel.h
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AskListModel : NSObject
@property (nonatomic,strong)NSString *photo;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *askId;

-(id)initWithDic:(NSDictionary *)dic;
@end
