//
//  ScanView.m
//  最新扫描Demo
//
//  Created by 孙云 on 16/1/2.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "ScanView.h"
#define AUTH_ALERT_TAG (int)281821
#define  ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define  ScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface ScanView()
{
    AVCaptureSession * session;//输入输出的中间桥梁
    int line_tag;
    UIView *highlightView;
}
@end
@implementation ScanView
+(instancetype)createView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ScanView" owner:nil options:nil] firstObject];
}
-(void)awakeFromNib
{
    //三个角对应位置
    //上右
    self.topRightImage.transform = CGAffineTransformMakeRotation(M_PI_2);
    //下右
    self.bottomRight.transform = CGAffineTransformMakeRotation(M_PI);
    self.bottomLeftImage.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self instanceDevice];
    
    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startAnimaTing) name:@"startScan" object:nil];
}
/**
 *  打开相册
 */
- (IBAction)clickXC {
    if ([self.delegate respondsToSelector:@selector(clickXCToVC)]) {
        [self.delegate clickXCToVC];
    }
}
/**
 *
 *  配置相机属性
 */
- (void)instanceDevice{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    line_tag = 1872637;
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    if (input) {
        [session addInput:input];
    }
    if (output) {
        [session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        NSMutableArray *a = [[NSMutableArray alloc] init];
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            [a addObject:AVMetadataObjectTypeQRCode];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            [a addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            [a addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            [a addObject:AVMetadataObjectTypeCode128Code];
        }
        output.metadataObjectTypes=a;
    }
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.layer.bounds;
    [self.layer insertSublayer:layer atIndex:0];
    
    //[self setOverlayPickerView];
    
    [session addObserver:self forKeyPath:@"running" options:NSKeyValueObservingOptionNew context:nil];
    
    //开始捕获
    [session startRunning];
}
/**
 *
 *  监听扫码状态-修改扫描动画
 *
 */
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    if ([object isKindOfClass:[AVCaptureSession class]]) {
        BOOL isRunning = ((AVCaptureSession *)object).isRunning;
        if (isRunning) {
            [self addAnimation];
        }else{
            [self removeAnimation];
        }
    }
}

/**
 *
 *  获取扫码结果
 *
 */
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex :0];
        
        //输出扫描字符串
        NSString *data = metadataObject.stringValue;
        if ([self.delegate respondsToSelector:@selector(showMessage:)]) {
            [self.delegate showMessage:data];
        }
    }
}
/**
 *
 *  添加扫码动画
 */
- (void)addAnimation{
    UIView *line = [self viewWithTag:10002];
    line.hidden = NO;
    CGFloat height = 0;
    if (ScreenWidth == 320) {
        height = 220;
    }else if (ScreenWidth == 375)
    {
        height = 275;
    }
    else
    {
        height = 314;
    }
    NSLog(@"%f    %f",height,ScreenHeight);
    CABasicAnimation *animation = [ScanView moveYTime:2 fromY:[NSNumber numberWithFloat:0] toY:[NSNumber numberWithFloat:height] rep:OPEN_MAX];
    [line.layer addAnimation:animation forKey:@"LineAnimation"];
}

+ (CABasicAnimation *)moveYTime:(float)time fromY:(NSNumber *)fromY toY:(NSNumber *)toY rep:(int)rep
{
    CABasicAnimation *animationMove = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    [animationMove setFromValue:fromY];
    [animationMove setToValue:toY];
    animationMove.duration = time;
    animationMove.delegate = self;
    animationMove.repeatCount  = rep;
    animationMove.fillMode = kCAFillModeForwards;
    animationMove.removedOnCompletion = NO;
    animationMove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animationMove;
}


/**
 *  @author Whde
 *
 *  去除扫码动画
 */
- (void)removeAnimation{
    UIView *line = [self viewWithTag:1002];
    [line.layer removeAnimationForKey:@"LineAnimation"];
    line.hidden = YES;
}

/**
 *  @author Whde
 *
 *  从父视图中移出
 */
- (void)selfRemoveFromSuperview{
    [session stopRunning];
    [session removeObserver:self forKeyPath:@"running" context:nil];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}
-(void)returnThing
{
    [self selfRemoveFromSuperview];
}
/**
 *  通知方法，开始扫描
 */
-(void)startAnimaTing
{
    [session startRunning];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
