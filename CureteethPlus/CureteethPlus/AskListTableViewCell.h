//
//  AskListTableViewCell.h
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AskListModel.h"
#import "ReseverListModel.h"
@interface AskListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic,strong)AskListModel *model;
@property (nonatomic,strong)ReseverListModel *reseverModel;
@end
