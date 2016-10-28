//
//  MessageChindOneViewController.h
//  CureTeeth
//
//  Created by Denny on 16/7/20.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"
#import "MessageModel.h"
@interface MessageChindOneViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataSource;
@end
