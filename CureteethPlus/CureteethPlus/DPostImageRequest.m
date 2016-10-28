//
//  DPostImageRequest.m
//  CureteethPlus
//
//  Created by Denny on 16/7/28.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "DPostImageRequest.h"
#import <AFNetworking.h>

@implementation DPostImageRequest
-(NSURLSessionDataTask *)request:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.HTTPShouldSetCookies = NO;
    config.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyNever;
    AFHTTPSessionManager *manger =  [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl] sessionConfiguration:config];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    [manger.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    NSLog(@"入参%@",self.params);
    [manger POST:self.path parameters:self.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for(NSInteger i = 0; i < self.imageArray.count; i++){
            NSData * imageData = [self.imageArray objectAtIndex: i];
            // 上传的参数名
            NSString * Name = [NSString stringWithFormat:@"imageIOS%zi",i+1];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
            
            [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
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
        [SVProgressHUD dismiss];
    }];
    return nil;
}

@end
