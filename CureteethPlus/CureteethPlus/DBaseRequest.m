//
//  NBaseRequest.m
//  YunCardBusiness
//
//  Created by Denny on 15/12/14.
//  Copyright © 2015年 Denny. All rights reserved.
//

#import "DBaseRequest.h"

@implementation DBaseRequest

- (void)dealloc {
    [_params removeAllObjects];
    _params = nil;
}

- (NSMutableDictionary*)params {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    return dic;
}

- (id)processResponse:(id)object {
    return object;
}

- (NSURLSessionDataTask *)request:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return nil;
}
@end
