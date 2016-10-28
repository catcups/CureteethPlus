//
//  MessageTableViewCell.h
//  CureTeeth
//
//  Created by Denny on 16/7/20.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
@interface MessageTableViewCell : UITableViewCell
@property (nonatomic,strong)MessageModel *model;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end
