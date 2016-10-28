//
//  AppDelegate.h
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapKit/BaiduMapAPI_Base/BMKMapManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;
-(void)tolog;
-(void)setRoot;
@end

