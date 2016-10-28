//
//  Message.h
//  WeCat
//
//  Created by  唐忠政 on 16/7/16.
//  Copyright © 2016年  唐忠政. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Message : NSObject

@property(nonatomic,strong)NSMutableDictionary *dic;

@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *cname;
@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString *dname;
@property(nonatomic,copy)NSURL *userPhoto;
@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *photo1;

@property(nonatomic,copy)NSString *photo2;

@property(nonatomic,copy)NSString *photo3;
@property(nonatomic,assign)BOOL info;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,strong)NSString *doctorId;
@property(nonatomic,strong)NSString *customerId;
@property (nonatomic,strong)NSURL *doctorsphoto;
@property(nonatomic,copy)NSString *messageId;

@property(nonatomic,copy)NSString *chatTime;

/**
 *  reply
 */

@property(nonatomic,copy)NSString *advisoryId;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *fromId;
@property(nonatomic,copy)NSString *replyId;
@property(nonatomic,copy)NSString *look;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *toId;
@property(nonatomic,assign)BOOL isSelf;


@property(nonatomic,assign,readonly)CGRect frame;

@property(nonatomic,assign,readonly)CGFloat contentFontSize;
- (id)initWithModel:(NSDictionary *)dic;
- (id)initWithReplyModel:(NSDictionary *)dic andCustomerId:(NSString *)customerId;

@end
