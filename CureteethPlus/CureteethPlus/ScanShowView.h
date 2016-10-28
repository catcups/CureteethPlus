//
//  ScanShowView.h
//  最新扫描Demo
//
//  Created by 孙云 on 16/1/4.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanShowViewDelegate <NSObject>

-(void)cancelThing:(NSString *)title;
-(void)okThing:(NSString *)title context:(NSString *)result;

@end
@interface ScanShowView : UIView
//扫描结果
@property (weak, nonatomic) IBOutlet UILabel *scanResult;
//详情结果
@property (weak, nonatomic) IBOutlet UITextView *resultText;
//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
//确定按钮
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property(nonatomic,copy)NSString *dataStr;
@property(nonatomic,weak)id<ScanShowViewDelegate>delegate;
//点击取消事件
- (IBAction)clickCancel;
//点击ok事件
- (IBAction)clickOk;
+(instancetype)createView;
//接收数据
-(void)reMessage:(NSString *)message;
@end
