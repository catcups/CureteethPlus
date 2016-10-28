//
//  ScanResultView.h
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScanResultView;
@protocol ScanResultViewDelegate <NSObject>

- (void)ScanResultViewDelegateOnsubmitButton:(ScanResultView *)view;

@end
@interface ScanResultView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property(nonatomic,assign)id<ScanResultViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
+ (ScanResultView *)creatView;
@end
