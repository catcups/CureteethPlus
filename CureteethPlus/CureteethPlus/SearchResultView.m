//
//  SearchResultView.m
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "SearchResultView.h"

@implementation SearchResultView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(frame), 30)];
        self.resultLabel.text = @"没有搜索结果";
        [self addSubview:self.resultLabel];
        self.resultLabel.hidden = YES;
        self.resultLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesture)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)tapgesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissSearchView:)]) {
        [self.delegate dismissSearchView:self];
    }
}

@end

