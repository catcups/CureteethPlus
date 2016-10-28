//
//  MainTableViewCell.h
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClinincModel.h"
@interface MainTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *distabce;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (nonatomic,strong)ClinincModel *model;
@end
