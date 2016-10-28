//
//  DoctorDtailViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/9/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchDoctorModel.h"
@interface DoctorDtailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *askButton;
@property (weak, nonatomic) IBOutlet UIButton *reseverButton;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (nonatomic,strong)SearchDoctorModel *model;
@end
