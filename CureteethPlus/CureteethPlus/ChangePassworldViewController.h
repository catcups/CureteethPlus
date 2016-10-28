//
//  ChangePassworldViewController.h
//  CureTeeth
//
//  Created by Denny on 16/7/15.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePassworldViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextField *rePassword;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@end
