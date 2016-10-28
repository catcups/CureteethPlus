//
//  MidViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/7/21.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"
#import "IconModel.h"
@interface MidViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;

- (id)initWithModel:(IconModel *)model index:(NSInteger)index;
@end
