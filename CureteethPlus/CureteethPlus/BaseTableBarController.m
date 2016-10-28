//
//  BaseTableBarController.m
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseTableBarController.h"
#import "BaseNavViewController.h"
#import "MainViewController.h"
#import "ReserveViewController.h"
#import "AskViewController.h"
#import "MoreViewController.h"

@implementation BaseTableBarController
- (void)viewDidLoad {
    self.tabBar.tintColor = KMainColor;
    BaseNavViewController *main = [[BaseNavViewController alloc]initWithRootViewController:[[MainViewController alloc] init]];
    BaseNavViewController *ask = [[BaseNavViewController alloc]initWithRootViewController:[[AskViewController alloc] init]];
    BaseNavViewController *resever = [[BaseNavViewController alloc]initWithRootViewController:[[ReserveViewController alloc] init]];
    BaseNavViewController *more = [[BaseNavViewController alloc]initWithRootViewController:[[MoreViewController alloc] init]];
    self.viewControllers = @[main,ask,resever,more];
    
}
@end
