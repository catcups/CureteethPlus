//
//  MainDetailViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/7/24.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"
#import "DennyScrollView.h"
@interface MainDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet DennyScrollView *dennyScrollView;

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *leftTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *clinicLabel;
@property (weak, nonatomic) IBOutlet UIButton *localButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (nonatomic,strong)NSString *clinicId;
@end
