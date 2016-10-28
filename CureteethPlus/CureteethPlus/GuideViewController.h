//
//  GuideViewController.h
//  KoneKTV
//
//  Created by higgses on 14-1-25.
//  Copyright (c) 2014年 Higgses Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideViewControllerDelegate <NSObject>

@optional
- (void)guideViewWillAppear;
- (void)guideViewWillDissAppear;

@end

@interface GuideViewController : UIViewController

@property(nonatomic, assign)id<GuideViewControllerDelegate> delegate;
@property(nonatomic, retain)UIViewController *rootViewController;
@property(nonatomic, retain)UIScrollView *startScrollView;

+ (GuideViewController *)shareVC;

+ (void)showGuideView;
+ (void)hideGuideView:(UIViewController *)rootVC;

+ (BOOL)launchShowGuideView;

@end
