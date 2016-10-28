//
//  NBaseRequest.h
//  YunCardBusiness
//
//  Created by Denny on 15/12/14.
//  Copyright © 2015年 Denny. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DBaseRequest : NSObject
{
    NSMutableDictionary *_params;
}

@property(nonatomic, copy)NSString *path;
@property(nonatomic, retain, readonly)NSMutableDictionary *params;

- (id)processResponse:(id)object;
- (NSURLSessionDataTask *)request:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
