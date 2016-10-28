//
//  UIImage+Extension.h
//  B
//
//  Created by QH on 16/5/6.
//  Copyright © 2016年 QH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
// 根据颜色生成一张尺寸为10*10的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 * 圆形图片
 */
- (UIImage *)circleImage;


@end
