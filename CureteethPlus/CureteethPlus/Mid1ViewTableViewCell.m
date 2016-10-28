
//
//  Mid1ViewTableViewCell.m
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "Mid1ViewTableViewCell.h"

@implementation Mid1ViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageLabel.layer.cornerRadius = 5;
    self.imageLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
