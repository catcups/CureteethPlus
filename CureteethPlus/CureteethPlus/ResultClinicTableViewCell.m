//
//  ResultClinicTableViewCell.m
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ResultClinicTableViewCell.h"

@implementation ResultClinicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.inButton.layer.cornerRadius = 5;
    self.inButton.layer.borderColor = KMainColor.CGColor;
    self.inButton.layer.borderWidth = 0.5;
    // Initialization code
}
- (IBAction)onGetin:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ResultClinicTableViewCellDelegateClikeInClinic:model:)]) {
        [self.delegate ResultClinicTableViewCellDelegateClikeInClinic:self model:_model];
    }
}
-(void)setModel:(SeachClinnicModel *)model {
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/clinic/%@",model.clinicLogo]]];
    self.clinicnameLB.text  = model.clinicName;
    self.distabceLabel.text = model.distance;
    self.timeLB.text = [NSString stringWithFormat:@"%@ ~ %@",model.openTime,model.closeTime];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
