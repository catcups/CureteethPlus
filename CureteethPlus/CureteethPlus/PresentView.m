//
//  PresentView.m
//  CureteethPlus
//
//  Created by Denny on 16/7/27.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "PresentView.h"

@implementation PresentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    self.contentView = [[UIView alloc]init];
    self.contentView.layer.cornerRadius = 5;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    
    self.titleLB = [[UILabel alloc]init];
    self.titleLB.font = [UIFont systemFontOfSize:16];
    self.titleLB.textColor = [UIColor blackColor];
    self.titleLB.text = @"照片示例";
    [self.contentView addSubview:self.titleLB];
    
    self.contentImage = [[UIImageView alloc]init];
    [self.contentView addSubview:self.contentImage];
    
    self.LB1 = [[UILabel alloc]init];

    self.LB1.textColor = [UIColor lightGrayColor];
    self.LB1.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.LB1];
    self.LB2 = [[UILabel alloc]init];
    self.LB2.textColor = [UIColor lightGrayColor];
    self.LB2.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.LB2];
    self.LB3 = [[UILabel alloc]init];

    self.LB3.textColor = [UIColor lightGrayColor];
    self.LB3.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.LB3];
    self.LB4 = [[UILabel alloc]init];

    self.LB4.textColor = [UIColor lightGrayColor];
    self.LB4.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.LB4];
    
    self.leftButton =[[UIButton alloc]init];
    [self.leftButton setTitle:@"开始拍照" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];    [self.leftButton addTarget:self action:@selector(onLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.leftButton];
    
    self.rightButton =[[UIButton alloc]init];
    [self.rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(onRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.rightButton];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.lineView];
}

-(void)onLeftButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(PresentViewDelegateClikeSure:)]) {
        [self.delegate PresentViewDelegateClikeSure:self];
    }
}

-(void)onRightButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(PresentViewDelegateClikeCancel:)]) {
        [self.delegate PresentViewDelegateClikeCancel:self];
    }
}

-(void)layoutSubviews {
    self.contentView.frame = CGRectMake(26, 30, CGRectGetWidth(self.frame) - 52, 380);
    CGFloat marginLeft = 9;
    self.titleLB.frame = CGRectMake(marginLeft, 10, 100, 21);
    self.contentImage.frame = CGRectMake(marginLeft, CGRectGetMaxY(self.titleLB.frame) + 5, CGRectGetWidth(self.contentView.frame) - 2 * marginLeft, 180);
    self.LB1.frame = CGRectMake(marginLeft, CGRectGetMaxY(self.contentImage.frame) + 5, CGRectGetWidth(self.contentView.frame), 21);
    self.LB2.frame = CGRectMake(marginLeft, CGRectGetMaxY(self.LB1.frame) + 5, CGRectGetWidth(self.contentView.frame), 21);

    self.LB3.frame = CGRectMake(marginLeft, CGRectGetMaxY(self.LB2.frame) + 5, CGRectGetWidth(self.contentView.frame), 21);

    self.LB4.frame = CGRectMake(marginLeft, CGRectGetMaxY(self.LB3.frame) + 5, CGRectGetWidth(self.contentView.frame), 21);
    self.leftButton.frame = CGRectMake(0, CGRectGetMaxY(self.LB4.frame) + 5, (CGRectGetWidth(self.contentView.frame)-1)/2, 44);
    self.lineView.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)/2, self.leftButton.frame.origin.y, 1, 44);
    self.rightButton.frame = CGRectMake(CGRectGetMaxX(self.lineView.frame), self.leftButton.frame.origin.y, self.leftButton.frame.size.width, self.leftButton.frame.size.height);
}
@end
