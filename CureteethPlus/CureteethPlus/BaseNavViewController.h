//
//  BaseNavViewController.h
//  CureTeeth
//
//  Created by Denny on 16/7/14.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KENABLE_POPGESTURE YES
#import "PopGestureRecognizer.h"
@interface BaseNavViewController : UINavigationController
@property(nonatomic, retain)PopGestureRecognizer *popGesture;
- (void)enableGesturePop:(BOOL)enable;
@end
