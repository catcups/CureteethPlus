//
//  NodataView.m
//  CureTeeth
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "NodataView.h"

@implementation NodataView
- (id)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0,150 , CGRectGetWidth(frame), 20)];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.textColor = [UIColor blackColor];
        self.titleLab.font = [UIFont systemFontOfSize:15];
        self.titleLab.text = @"没有符合条件的搜索内容!";
        [self addSubview:self.titleLab];
    }
    return self;
}
@end
