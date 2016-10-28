//
//  MessageResultViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/20.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MessageResultViewController.h"
#import "MessageDetailReq.h"
@interface MessageResultViewController ()

@end

@implementation MessageResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知详情";
    // Do any additional setup after loading the view from its nib.
    MessageDetailReq *req = [[MessageDetailReq alloc] init];
    req.meassageId = self.messageId;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [self initInterfacreWithData:(NSDictionary *)responseObject[@"data"][@"message"][0]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

-(void)initInterfacreWithData:(NSDictionary *)dic {
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15];
    label.text = dic[@"message"];
    label.numberOfLines = 0;
    CGSize labelSize = [label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.view.bounds)/2)];
    label.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, labelSize.height);
    [self.view addSubview:label];
    UILabel *timeLB = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 200, CGRectGetMaxY(label.frame) + 20, 180, 20)];
    timeLB.text = dic[@"time"];
    timeLB.textAlignment = NSTextAlignmentRight;
    timeLB.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:timeLB];
}

@end
