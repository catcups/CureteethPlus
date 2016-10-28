//
//  MessageCell.m
//  WeCat
//
//  Created by  唐忠政 on 16/7/16.
//  Copyright © 2016年  唐忠政. All rights reserved.
//

#import "MessageCell.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface MessageCell()
@end

@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setMessage:(Message *)message  {
    _contentImageButton = [[UIButton alloc]init];
    [_contentImageButton setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    [_contentImageButton addTarget:self action:@selector(toReseverButton:) forControlEvents:UIControlEventTouchUpInside];
    self.timeLB = [[UILabel alloc]init];
    self.timeLB.text = message.chatTime;
    self.timeLB.font = [UIFont systemFontOfSize:13];
    _message = message;
    self.headImage = [[UIImageView alloc] init];
    self.headImage.layer.cornerRadius = 5;
    self.headImage.layer.masksToBounds = YES;
    self.bgView = [[UIImageView alloc] init];
    self.contentLB = [[UILabel alloc] init];
    self.contentLB.frame = CGRectZero;
    self.contentLB.backgroundColor = [UIColor clearColor];
    self.contentLB.numberOfLines = 0;
    self.contentLB.text = message.content;
    self.contentLB.textAlignment = NSTextAlignmentLeft;
    self.contentLB.font = [UIFont systemFontOfSize:_message.contentFontSize];
    /**
     *  self(reply)
     */

    if (message.isSelf) {
        self.headImage.frame = CGRectMake(kScreenW-20-50+10, 27, 50, 50);
        self.bgView.image = [UIImage imageNamed:@"chatto_bg_normal"];
        self.bgView.image = [self.bgView.image stretchableImageWithLeftCapWidth:31 topCapHeight:31];
        self.bgView.frame = CGRectMake(kScreenW-kHeadImageSize-kEdgeSize*2-_message.frame.size.width-35, kEdgeSize+20, _message.frame.size.width+35, _message.frame.size.height+25);
        //3) 设置messageLabel的frame
        self.timeLB.frame = CGRectMake(kScreenW-kHeadImageSize-kEdgeSize*2-_message.frame.size.width-35, kEdgeSize, kScreenW/2, 21);
        self.contentLB.frame = CGRectMake(kScreenW-kHeadImageSize-kEdgeSize*2-_message.frame.size.width-20, kEdgeSize*2+20, _message.frame.size.width, _message.frame.size.height);
    }else{
        self.contentLB.frame = CGRectMake(kHeadImageSize+kEdgeSize*2+20, kEdgeSize*2+20, _message.frame.size.width, _message.frame.size.height);
        CGFloat maiginRight = 0.;
        _contentImageButton.frame = CGRectMake(CGRectGetMaxX(self.contentLB.frame)+ 8, kEdgeSize+20+ 4, 30, 30);
        if ([message.type isEqualToString:@"1"] && !message.isSelf) {
            maiginRight = 36;
            _contentImageButton.hidden = NO;
        }else{
            _contentImageButton.hidden = YES;
        }
        self.headImage.frame = CGRectMake(10, 27, 50, 50);
        self.bgView.frame = CGRectMake(70, 41, message.frame.size.width+40, message.frame.size.height+35);
        self.bgView.image = [UIImage imageNamed:@"chatfrom_bg_normal"];
        self.bgView.image = [self.bgView.image stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        self.bgView.frame = CGRectMake(kHeadImageSize+kEdgeSize*2, kEdgeSize+20, _message.frame.size.width+35 + maiginRight, _message.frame.size.height+25);
        //6) 设置messageLabel的frame
        self.timeLB.frame = CGRectMake(kHeadImageSize+kEdgeSize*2, kEdgeSize, kScreenW/2, 21);
    }
    [self.contentView addSubview:self.timeLB];
    [self.contentView addSubview:self.headImage];
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.contentLB];
    if (!message.isSelf) {
        [self.contentView addSubview:_contentImageButton];
    }
    [self setNeedsLayout];
}
- (void)toReseverButton:(UIButton*)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(MessageCellDelegateOnclikeReseverButton:model:)]) {
        [self.delegate MessageCellDelegateOnclikeReseverButton:self model:_message];
    }
}
@end
