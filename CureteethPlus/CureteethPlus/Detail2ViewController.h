//
//  Detail2ViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"

@interface Detail2ViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSString *clinicId;
@end
