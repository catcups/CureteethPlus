//
//  AskListTableViewCell.m
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "AskListTableViewCell.h"

@implementation AskListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.layer.cornerRadius = 5;
    self.headImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (void)setModel:(AskListModel *)model {
    self.nameLabel.text = model.name;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/doctor/%@",model.photo]]];
    self.timeLabel.text = model.time;
    self.contentLabel.text = model.content;
}
-(void)setReseverModel:(ReseverListModel *)reseverModel {
    self.nameLabel.text = reseverModel.name;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/doctor/%@",reseverModel.photo]]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",reseverModel.targetDate,reseverModel.holdTime];
    self.contentLabel.text = reseverModel.clinicName;
}
@end
