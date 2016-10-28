//
//  PresentView.h
//  CureteethPlus
//
//  Created by Denny on 16/7/27.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PresentView;
@protocol PresentViewDelegate <NSObject>

- (void)PresentViewDelegateClikeSure:(PresentView *)vc;
- (void)PresentViewDelegateClikeCancel:(PresentView *)vc;

@end
@interface PresentView : UIView
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titleLB;
@property (nonatomic,strong)UIImageView *contentImage;
@property (nonatomic,strong)UILabel *LB1;
@property (nonatomic,strong)UILabel *LB2;
@property (nonatomic,strong)UILabel *LB3;
@property (nonatomic,strong)UILabel *LB4;

@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIButton *leftButton;
@property (nonatomic,strong)UIButton *rightButton;

@property (nonatomic,strong)id<PresentViewDelegate>delegate;
@end
