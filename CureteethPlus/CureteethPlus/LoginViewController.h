//
//  LoginViewController.h
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"
@class LoginViewController;
@protocol TmpRootViewControllerDelegate <NSObject>
- (void)LoginViewControllerDelegate;

@end

@interface LoginViewController : BaseViewController
@property (nonatomic,assign)id<TmpRootViewControllerDelegate>iDelegate;

@end
