//
//  GuideViewController.m
//  KoneKTV
//
//  Created by higgses on 14-1-25.
//  Copyright (c) 2014年 Higgses Inc. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"
#import "CommonTool.h"
//#import "HomeController.h"

#define kFristLaunch @"kFristLaunch"

#define kGuideViewImgs_3_5   @[@"guid_4s_1",@"guid_4s_2",@"guid_4s_3"]
#define kGuideViewImgs_6_0   @[@"guid_6_1",@"guid_6_2",@"guid_6_3"]
#define kGuideViewImgs_6Plus @[@"guid_6plus_1",@"guid_6plus_2",@"guid_6plus_3"]


#define IS_SCREEN3_5    (SCREEN_HEIGHT == 480)
#define IS_SCREEN4_0    (SCREEN_HEIGHT == 1136/2)
#define IS_SCREEN4_3    (SCREEN_HEIGHT == 1334/2)
#define IS_SCREEN5_5    (SCREEN_HEIGHT == 2208/2)

#define kGoBtnNormalStatus @"wt_btn_n"
#define kGoBtnHeightStatus @"wt_btn_p"

#define kGuideViewImgs IS_SCREEN3_5 ? kGuideViewImgs_3_5 : kGuideViewImgs_4
#define kBackgroundColor [UIColor whiteColor]

#define kAPPDELEGATE [[UIApplication sharedApplication] delegate]
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
/*
 * Color Definition
 */
#define kColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kCRGBAndAlpha(rgbValue,i) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:(i)]

@interface GuideViewController ()<UIScrollViewDelegate>
{
	UIPageControl *pageControl;
}
@end

@implementation GuideViewController
@synthesize startScrollView;

+ (GuideViewController *)shareVC
{
	static GuideViewController *guideVC;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		guideVC = [[GuideViewController alloc] init];
		guideVC.view.backgroundColor = kBackgroundColor;
	});
	return guideVC;
}

+ (BOOL)launchShowGuideView
{
    
	BOOL flaunch = [[CommonTool readUserDefaultsByKey:kFristLaunch] boolValue];
//    flaunch = NO;
	if (!flaunch)
	{
		[CommonTool storeUserDefaults:@"1" ForKey:kFristLaunch];//记录launch
        
		kAPPDELEGATE.window.rootViewController = [self shareVC];
		[kAPPDELEGATE.window makeKeyAndVisible];
	}
	return flaunch;
}

+ (void)showGuideView
{
	[[GuideViewController shareVC].startScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
	if ([[self shareVC].delegate respondsToSelector:@selector(guideViewWillAppear)]) {
		[[self shareVC].delegate guideViewWillAppear];
	}
	[UIView transitionWithView:kAPPDELEGATE.window
					  duration:0.3
					   options:(UIViewAnimationOptionTransitionCrossDissolve |
								UIViewAnimationOptionAllowAnimatedContent)
					animations:^{
						kAPPDELEGATE.window.rootViewController = [self shareVC];
					}
					completion:nil];
}

+ (void)hideGuideView:(UIViewController *)rootVC
{
	rootVC = rootVC ? rootVC : [self shareVC].rootViewController;
	if ([[self shareVC].delegate respondsToSelector:@selector(guideViewWillDissAppear)]) {
		[[self shareVC].delegate guideViewWillDissAppear];
	}
}

- (void)hideGuideView
{
	[GuideViewController hideGuideView:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[self setSubViews];
	[self showPageConroller];
}

- (void)setSubViews
{
	startScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    startScrollView.delegate = self;
	[startScrollView setPagingEnabled:YES];//分页拖动显示
    [startScrollView setShowsHorizontalScrollIndicator:NO];
    [startScrollView setShowsVerticalScrollIndicator:NO];
	startScrollView.backgroundColor = kBackgroundColor;
	CGFloat left = 0;
	for (NSString *obj in [self getGuidImgs]) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left,0,
																			  SCREEN_WIDTH
																			   ,SCREEN_HEIGHT)];
        UIImage *tmpImg = [UIImage imageNamed:obj];
        
		[imageView setImage:tmpImg];
        imageView.userInteractionEnabled = NO;
		[startScrollView addSubview:imageView];
		left += imageView.frame.size.width;
		if ([[[self getGuidImgs] lastObject] isEqualToString:obj])
		{
			[self addGoMainViewBtnFor:startScrollView Point:(CGPoint)CGPointMake(imageView.frame.origin.x, 0)];
		}
	}
	[startScrollView setContentSize:CGSizeMake(SCREEN_WIDTH*[[self getGuidImgs] count],
											   SCREEN_HEIGHT)];
	[self.view addSubview:startScrollView];
}


- (void)addGoMainViewBtnFor:(UIView *)view Point:(CGPoint)point
{
	UIButton *justgo = [[UIButton alloc] initWithFrame:CGRectMake(point.x,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
//	[justgo setImage:[UIImage imageNamed:kGoBtnNormalStatus] forState:UIControlStateNormal];
//	[justgo setImage:[UIImage imageNamed:kGoBtnHeightStatus] forState:UIControlStateHighlighted];
//	[justgo setCenter:CGPointMake(point.x-SCREEN_WIDTH/2, SCREEN_HEIGHT-155)];
	justgo.userInteractionEnabled = YES;
	[justgo setBackgroundColor:[UIColor clearColor]];
	[justgo addTarget:self action:@selector(hideGuideView) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:justgo];
}


- (void)iniPageController
{
	pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-85, SCREEN_HEIGHT-20 , 80, 8)];
    [pageControl setUserInteractionEnabled:NO];
    [pageControl setCurrentPage:0];
    [pageControl setNeedsLayout];
    pageControl.hidesForSinglePage = YES;
	pageControl.numberOfPages = [[self getGuidImgs] count];
	pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
	pageControl.pageIndicatorTintColor = kColorFromRGB(0xadadad);
	pageControl.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-30);
    pageControl.hidden = YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    int page = floor((startScrollView.contentOffset.x - self.view.bounds.size.width / 2) / self.view.bounds.size.width) + 1;
    pageControl.currentPage = page;
}

- (void)showPageConroller
{
	if (!pageControl) {
		[self iniPageController];
	}
	[self.view addSubview:pageControl];
	[self.view bringSubviewToFront:pageControl];
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (NSArray *)getGuidImgs
{
    if(IS_SCREEN3_5)
        
        return kGuideViewImgs_3_5;
    
    if(IS_SCREEN4_0)
        
        return kGuideViewImgs_6_0;
    
    if(IS_SCREEN5_5)
    {
        return kGuideViewImgs_6Plus;
    }
    if(IS_SCREEN4_3)
    {
        return kGuideViewImgs_6_0;
    }
    return kGuideViewImgs_6_0;
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
