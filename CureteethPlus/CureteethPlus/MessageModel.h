//
//  MessageModel.h
//  CureTeeth
//
//  Created by Denny on 16/7/20.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *look;
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *messageId;

- (id)initWithDic:(NSDictionary *)dic;

@end
