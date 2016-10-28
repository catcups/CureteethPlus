//
//  ResultDoctorTableViewCell.h
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchDoctorModel.h"
@class ResultDoctorTableViewCell;
@protocol ResultDoctorTableViewCellDeleagte <NSObject>

- (void)ResultDoctorTableViewCellDeleagteClikeAsk:(ResultDoctorTableViewCell *)cell model:(SearchDoctorModel *)model;
- (void)ResultDoctorTableViewCellDeleagteClikeResever:(ResultDoctorTableViewCell *)cell model:(SearchDoctorModel *)model;

@end
@interface ResultDoctorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *ledtButton;
@property (weak, nonatomic) IBOutlet UIButton *roghtButton;
@property (nonatomic,strong)SearchDoctorModel *model;
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;
@property (weak, nonatomic) IBOutlet UILabel *pnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *distrubutionLabel;
@property (nonatomic,assign)id<ResultDoctorTableViewCellDeleagte>delegate;

@end
