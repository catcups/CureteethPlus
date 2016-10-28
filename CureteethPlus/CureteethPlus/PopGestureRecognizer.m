//
//  PopGestureRecognizer.m
//  iCityPlus
//
//  Created by higgses on 14-4-30.
//  Copyright (c) 2014年 Chanly Inc. All rights reserved.
//

#import "PopGestureRecognizer.h"

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

@interface PopGestureRecognizer()

@property (nonatomic,assign) BOOL isMoving;
@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;

@end

@implementation PopGestureRecognizer
{
	UINavigationController *popNavigation;
	
	CGPoint startTouchPoint;
	BOOL isBackMoving;
	UIView *blackMask;
	UIImageView *lastScreenShotView;
	CGPoint startTouch;    
}

- (id)initWithWrap:(UINavigationController *)viewController
{
	self = [super init];
	if (self) {
		popNavigation = viewController;
		
		_screenShotsList = [[NSMutableArray alloc] init];
		UIImageView *shadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftside_shadow_bg"]];
		shadowImageView.frame = CGRectMake(-10, 0, 10, popNavigation.view.frame.size.height);
		[popNavigation.view addSubview:shadowImageView];
        _recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                            action:@selector(paningGestureReceive:)];
		[_recognizer delaysTouchesBegan];
        [_recognizer setEnabled:NO];
		[popNavigation.view addGestureRecognizer:_recognizer];
	}
	return self;
}


- (void)enablePanGuesture:(BOOL)enable
{
    _recognizer.enabled = enable;
}

// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.screenShotsList addObject:[self capture]];
    [_recognizer setEnabled:YES];
}

// override the pop method
- (void)popViewControllerAnimated:(BOOL)animated
{
    [self.screenShotsList removeLastObject];
    if (![self.screenShotsList count])
    {
        _recognizer.enabled = NO;
    }
}

#pragma mark - Utility Methods -

// get the current view screen shot
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(popNavigation.view.bounds.size, popNavigation.view.opaque, 0.0);
    [popNavigation.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - Gesture Recognizer -
- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
//    [MaskWindow hide];
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (popNavigation.viewControllers.count <= 1) return;
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.

    if (recoginzer.state == UIGestureRecognizerStateBegan && touchPoint.x <50) {
            startTouch = touchPoint;
            _isMoving = YES;
        if (!self.backgroundView)
        {
            CGRect frame = popNavigation.view.frame;
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        [popNavigation.view.superview insertSubview:self.backgroundView belowSubview:popNavigation.view];
        
        self.backgroundView.hidden = NO;
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 100 && startTouch.x != 0)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:[UIScreen mainScreen].bounds.size.width];
            } completion:^(BOOL finished) {
                
                [popNavigation popViewControllerAnimated:NO];
                CGRect frame = popNavigation.view.frame;
                frame.origin.x = 0;
                popNavigation.view.frame = frame;
                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        startTouch.x = 0;
        return;
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    // it keeps move with touch
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x
{
    x = x>[UIScreen mainScreen].bounds.size.width?[UIScreen mainScreen].bounds.size.width:x;
    x = x<0?0:x;
    
    CGRect frame = popNavigation.view.frame;
    frame.origin.x = x;
    popNavigation.view.frame = frame;
    NSInteger index = [UIScreen mainScreen].bounds.size.width * 20;
    float scale = (x/index)+0.95;
    float alpha = 0.4 - (x/800);
    
    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
    
}

@end
