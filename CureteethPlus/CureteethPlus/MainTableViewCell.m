//
//  MainTableViewCell.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ClinincModel *)model {
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/clinic/%@",model.clinicLogo]]];
    self.name.text = model.clinicName;
    self.content.text = model.description1;
    self.distabce.text = model.distance;
}
@end
