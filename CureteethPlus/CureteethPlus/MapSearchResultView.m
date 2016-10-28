//
//  MapSearchResultView.m
//  CureteethPlus
//
//  Created by Denny on 16/9/2.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MapSearchResultView.h"

@implementation MapSearchResultView
-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit {
    self.seacrhTableView = [[UITableView alloc]init];
    [self addSubview:self.seacrhTableView];
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"没有搜索结果";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
}
-(void)layoutSubviews {
    self.seacrhTableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.titleLabel.frame = CGRectMake(0, 100, ScrMain_Width, 40);
}
@end
