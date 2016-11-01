//
//  Mid1ViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/23.
//  Copyright © 2016年 Denny. All rights reserved.
//
// 广告轮播点击跳转之后的页面
#import "Mid1ViewController.h"

@interface Mid1ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation Mid1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"医牙医牙哦";
    self.titleLabel.text = self.model.title;
    self.timeLabel.text = self.model.createTime;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    NSString *jsString = [NSString stringWithFormat:@"<html> \n""<head> \n""<style type=\"text/css\"> \n""body {font-size: %f; font-family: \"%@\"; color: %@;}\n""</style> \n""</head> \n""<body>%@</body> \n""</html>", 30., @"宋体",[UIColor blackColor] , self.model.content];
    [self.webView loadHTMLString:jsString baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
