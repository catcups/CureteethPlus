//
//  ResultClinicViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"

@interface ResultClinicViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
- (id)initWithDataSource:(NSMutableArray *)array;
@end
