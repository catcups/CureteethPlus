//
//  ResultClinicTableViewCell.h
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeachClinnicModel.h"
@class ResultClinicTableViewCell;
@protocol ResultClinicTableViewCellDelegate <NSObject>

-(void)ResultClinicTableViewCellDelegateClikeInClinic:(ResultClinicTableViewCell *)cell model:(SeachClinnicModel *)model;

@end
@interface ResultClinicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *clinicnameLB;
@property (weak, nonatomic) IBOutlet UILabel *courceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distabceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *inButton;
@property (nonatomic,assign)id<ResultClinicTableViewCellDelegate>delegate;
@property (nonatomic,strong)SeachClinnicModel *model;
@end
