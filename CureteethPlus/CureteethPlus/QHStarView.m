//
//  QHStarView.m
//  CureteethPlus
//
//  Created by QH on 2016/10/28.
//  Copyright © 2016年 QH. All rights reserved.
//

#import "QHStarView.h"

@implementation QHStarView
@synthesize starSize = _starSize;
@synthesize maxStar = _maxStar;
@synthesize showStar = _showStar;
@synthesize emptyColor = _emptyColor;
@synthesize fullColor = _fullColor;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        //默认的星星的大小是 13.0f
        self.starSize = 13.0f;
        //未点亮时的颜色是 灰色的
        self.emptyColor = [UIColor colorWithRed:167.0f / 255.0f green:167.0f / 255.0f blue:167.0f / 255.0f alpha:1.0f];
        //点亮时的颜色是 亮黄色的
        self.fullColor = [UIColor colorWithRed:255.0f / 255.0f green:121.0f / 255.0f blue:22.0f / 255.0f alpha:1.0f];
        //默认的长度设置为100
        self.maxStar = 100;
    }
    
    return self;
}
//重绘视图
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSString* stars = @"★★★★★";
    
    rect = self.bounds;
    UIFont *font = [UIFont boldSystemFontOfSize:_starSize];
    CGSize starSize = [stars sizeWithFont:font];
    rect.size = starSize;
    [_emptyColor set];
    [stars drawInRect:rect withFont:font];
    
    CGRect clip = rect;
    clip.size.width = clip.size.width * _showStar / _maxStar;
    CGContextClipToRect(context,clip);
    [_fullColor set];
    [stars drawInRect:rect withFont:font];
}

#if 0
// 如何使用
//评论是4.2分的
DisplayStarView *sv = [[DisplayStarView alloc]initWithFrame:CGRectMake(90, 90, 200, 40)];
[self.view addSubview:sv];
sv.showStar = 4.2*20;
[sv release];

//评论是2.5分的
DisplayStarView *sv1 = [[DisplayStarView alloc]initWithFrame:CGRectMake(90, 90+40, 200, 40)];
[self.view addSubview:sv1];
sv1.showStar = 2.5 * 20;
[sv1 release];

//评论是4.8分的
DisplayStarView *sv2 = [[DisplayStarView alloc]initWithFrame:CGRectMake(90, 90+40+40, 200, 40)];
[self.view addSubview:sv2];
sv2.showStar = 4.8 * 20;
[sv2 release];
#endif

@end
