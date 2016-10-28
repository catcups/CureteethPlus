//
//  MoreViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginSuccessTableViewCell.h"
#import "ChangePassworldViewController.h"
#import "AskListViewController.h"
#import "ReseverListViewController.h"
#import "AdviceViewController.h"
@interface MoreViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSArray *imageArray;
@property (weak, nonatomic) IBOutlet UIButton *logOutButton;
@property(nonatomic,strong)NSArray *titleArray;
@end
