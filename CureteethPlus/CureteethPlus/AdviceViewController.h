//
//  AdviceViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"
#import "UIPlaceholderTextView.h"
@interface AdviceViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextField *titleTextfiled;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *contentTextfield;


@end
