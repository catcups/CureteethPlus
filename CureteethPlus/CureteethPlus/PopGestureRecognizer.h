//
//  PopGestureRecognizer.h
//  iCityPlus
//
//  Created by higgses on 14-4-30.
//  Copyright (c) 2014年 Chanly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopGestureRecognizer : NSObject


- (id)initWithWrap:(UINavigationController *)viewController;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)popViewControllerAnimated:(BOOL)animated;

/**
 *  是否开启手势返回功能
 *
 *  @param enable YES 开启 NO关闭
 */
- (void)enablePanGuesture:(BOOL)enable;

@property(nonatomic, retain)UIPanGestureRecognizer *recognizer;

@end
