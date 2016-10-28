//
//  DPostRequest.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostRequest.h"
#import <AFNetworking.h>
@implementation DPostRequest
-(NSURLSessionDataTask *)request:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.HTTPShouldSetCookies = NO;
    config.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyNever;
    AFHTTPSessionManager *manger =  [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl] sessionConfiguration:config];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    [manger.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    NSLog(@"%@入参%@",self.path,self.params);
    [manger POST:self.path parameters:self.params progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if ([responseObject[@"code"] integerValue] != 0) {
                [SVProgressHUD showErrorWithStatus:responseObject[@"msg"] ];
            }else {
                success(task,[self processResponse:responseObject]);
                NSLog(@"返回结果:\n%@",responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
    return nil;
}
@end
