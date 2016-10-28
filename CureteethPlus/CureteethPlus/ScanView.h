//
//  ScanView.h
//  最新扫描Demo
//
//  Created by 孙云 on 16/1/2.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ScanViewDelegate <NSObject>

-(void)showMessage:(NSString *)message;
-(void)clickXCToVC;

@end
@interface ScanView : UIView<AVCaptureMetadataOutputObjectsDelegate>
//右上
@property (weak, nonatomic) IBOutlet UIImageView *topRightImage;
//左下
@property (weak, nonatomic) IBOutlet UIImageView *bottomLeftImage;
//右下
@property (weak, nonatomic) IBOutlet UIImageView *bottomRight;
//顶部视图
@property (weak, nonatomic) IBOutlet UIView *topView;
//底部视图
@property (weak, nonatomic) IBOutlet UIView *bottomView;
//中间视图
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property(nonatomic,weak)id<ScanViewDelegate>delegate;
//打开相册
- (IBAction)clickXC;
//加载nib
+(instancetype)createView;
-(void)returnThing;
@end
