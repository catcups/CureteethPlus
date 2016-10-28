//
//  QHScrollUpDownView.h
//  QHScrollerViewUpDown
//
//  Created by QH on 2016/10/26.
//  Copyright © 2016年 QH. All rights reserved.
//
// 上下轮播广告Demo
#import <UIKit/UIKit.h>

// 自动滚动时间
#define interval 2

@interface QHScrollUpDownView : UIView
// 点击block回调
@property (nonatomic, copy) void(^titleClick)(NSString *title);
// 传入frame和装有网址的数组
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end
