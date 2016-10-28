//
//  SearchPlaceHolderTextView.m
//  CureteethPlus
//
//  Created by Denny on 16/8/9.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "SearchPlaceHolderTextView.h"

@implementation SearchPlaceHolderTextView

- (id)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame {
    if (self = [super initWithFrame:frame]) {
        self.searchImage = [[UIImageView alloc]initWithFrame:imageFrame];
        [self.searchImage setImage:[UIImage imageNamed:@"search"]];
        [self addSubview:self.searchImage];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.searchImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.215 * [UIScreen mainScreen].bounds.size.width, 7, 25, 25)];
        [self.searchImage setImage:[UIImage imageNamed:@"search"]];
        [self addSubview:self.searchImage];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self= [super initWithCoder:aDecoder]) {
        self.searchImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.215 * [UIScreen mainScreen].bounds.size.width, 7, 25, 25)];
        [self.searchImage setImage:[UIImage imageNamed:@"search"]];
        [self addSubview:self.searchImage];
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.placeHolderLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)textChanged:(NSNotification *)notification {
    if([[self placeholder] length] == 0)
    {
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        if([[self text] length] == 0)
        {
            self.searchImage.hidden = NO;
            [self.placeHolderLabel setAlpha:1];
        }
        else
        {
            self.searchImage.hidden = YES;
            [self.placeHolderLabel setAlpha:0];
        }
    }];

}
@end
