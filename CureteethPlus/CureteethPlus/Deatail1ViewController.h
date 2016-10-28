//
//  Deatail1ViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"
#import "DetailClinicModel.h"
@interface Deatail1ViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)DetailClinicModel *model;
@end
