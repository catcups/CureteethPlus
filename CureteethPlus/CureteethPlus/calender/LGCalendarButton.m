//
//  LGCalendarButton.m
//  LGCalender
//
//  Created by jamy on 15/6/30.
//  Copyright (c) 2015年 jamy. All rights reserved.
//

#import "LGCalendarButton.h"

@implementation LGCalendarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
////        self.tintColor = [UIColor blackColor];
//        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
//        self.tintColor = [UIColor blackColor];
//        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect: rect];
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    CGContextBeginPath(contextRef);
//    CGContextMoveToPoint(contextRef, 0, rect.size.height/2);
//    CGContextAddLineToPoint(contextRef,rect.size.width ,0);
//    CGContextAddLineToPoint(contextRef,rect.size.width,rect.size.height);
//    CGContextAddLineToPoint(contextRef,0, rect.size.height/2);
//    CGContextSetFillColorWithColor(contextRef, [UIColor redColor].CGColor);
//    CGContextFillPath(contextRef);
//    CGContextRef con = UIGraphicsGetCurrentContext();
//
//    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
//    
//    CGContextMoveToPoint(contextRef, 0, rect.size.height/2);
//    
//    CGContextAddLineToPoint(contextRef,rect.size.width ,0);
//    
//    CGContextAddLineToPoint(contextRef,rect.size.width,rect.size.height);
//    
//    CGContextFillPath(con);
    
    
//    CGColorSpaceRef sp2 = CGColorSpaceCreatePattern(NULL);
//    
//    CGContextSetFillColorSpace (con, sp2);
//    
//    CGColorSpaceRelease (sp2);
//    
//    CGPatternCallbacks callback = {0, &drawStripes, NULL };
//    
//    CGAffineTransform tr = CGAffineTransformIdentity;
//    
//    CGPatternRef patt = CGPatternCreate(NULL,CGRectMake(0,0,4,4), tr, 4, 4, kCGPatternTilingConstantSpacingMinimalDistortion, true, &callback);
//    
//    CGFloat alph = 1.0;
//    
//    CGContextSetFillPattern(con, patt, &alph);
//    
//    CGPatternRelease(patt);
//    
//    CGContextMoveToPoint(con, 80, 25);
//    
//    CGContextAddLineToPoint(con, 100, 0);
//    
//    CGContextAddLineToPoint(con, 120, 25);
//    
//    CGContextFillPath(con);
}

@end
