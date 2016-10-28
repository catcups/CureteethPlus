//
//  ReserveView.h
//  CureteethPlus
//
//  Created by Denny on 16/7/28.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReserveView;
@protocol ReserveViewDelegate <NSObject>

-(void)ReserveViewDelegateOnclikeDismisView:(ReserveView *)view;
-(void)ReserveViewDelegateOnclikeLeftButton:(ReserveView *)view;
-(void)ReserveViewDelegateOnclikeSubmitButton:(ReserveView *)view;
-(void)ReserveViewDelegateOnclikePrivacy:(ReserveView *)view;

@end
@interface ReserveView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height2;
@property (weak, nonatomic) IBOutlet UIView *loginedView;

@property (weak, nonatomic) IBOutlet UIView *unLoginView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height1;
@property (weak, nonatomic) IBOutlet UILabel *clinicNameLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIImageView *clinicImageView;
@property (weak, nonatomic) IBOutlet UITextField *mobileTfd;
@property (weak, nonatomic) IBOutlet UITextField *nameTfd;
@property (weak, nonatomic) IBOutlet UITextField *messageTfd;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginTop;

@property (weak, nonatomic) IBOutlet UITextField *unMobileText;
@property (weak, nonatomic) IBOutlet UITextField *unNameText;
@property (weak, nonatomic) IBOutlet UITextField *unCodeText;
@property (weak, nonatomic) IBOutlet UITextField *unPassworldText;
@property (weak, nonatomic) IBOutlet UITextField *unMessageText;
@property (nonatomic,assign)BOOL haveRegister;
@property (weak, nonatomic) IBOutlet UIView *passwordText;
@property(nonatomic,strong)NSString *clinicId;
@property(nonatomic,strong)NSString *doctorId;
@property(nonatomic,strong)NSString *targetDate;
@property(nonatomic,strong)NSString *holdTime;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,assign)CGFloat topMagrin;
@property (nonatomic,strong)UIButton *codeButton;
@property (nonatomic,strong)NSTimer *getValidTimer;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewTop;
@property (nonatomic,assign)id<ReserveViewDelegate>delegate;
+(instancetype)createView;
@end
