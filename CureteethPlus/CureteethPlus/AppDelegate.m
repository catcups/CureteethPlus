//
//  AppDelegate.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BaseNavViewController.h"
#import "BaseTableBarController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
@interface AppDelegate ()<TmpRootViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"WrQEn8iXcGOpsqLOZtnkTHPNAkIIxzCZ"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self setRoot];
    return YES;
}
- (void)tolog {
    [CommonTool storeUserDefaults:nil ForKey:KCustomerId];
    LoginViewController *one = [[LoginViewController alloc]init];
    one.iDelegate = self;
    BaseNavViewController *nav=  [[BaseNavViewController alloc]initWithRootViewController:one];
    [self setWindowRootViewController:nav WithDuration:0.3];;
}
- (void)setRoot {
    [self setWindowRootViewController:[[BaseTableBarController alloc]init] WithDuration:0.5];
}
-(void)LoginViewControllerDelegate {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"mainreloadview" object:nil];
    [self getroot];

}

- (void)getroot {
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[BaseTableBarController alloc]init]];
     [self setWindowRootViewController:[[BaseTableBarController alloc]init] WithDuration:0.5];
}
- (void)setWindowRootViewController:(UIViewController *)viewController WithDuration:(CGFloat)duration {
    self.window.rootViewController = viewController;
    [UIView transitionWithView:self.window
                      duration:duration
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.window.rootViewController = viewController;
                    }
                    completion:nil];
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
