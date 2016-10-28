//
//  RegisterViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passworld;
@property (weak, nonatomic) IBOutlet UITextField *passwold1;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
