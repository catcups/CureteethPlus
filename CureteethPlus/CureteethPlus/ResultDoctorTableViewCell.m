//
//  ResultDoctorTableViewCell.m
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ResultDoctorTableViewCell.h"

@implementation ResultDoctorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.layer .cornerRadius = self.ledtButton.layer.cornerRadius = self.roghtButton.layer.cornerRadius = 5;
    self.headImage.layer.masksToBounds = self.ledtButton.layer.masksToBounds = self.roghtButton.layer.masksToBounds = YES;
    self.ledtButton.layer.borderWidth = self.roghtButton.layer.borderWidth  = 0.5;
    self.ledtButton.layer.borderColor = self.roghtButton.layer.borderColor = KMainColor.CGColor;
    
}
- (IBAction)onleftButton:(id)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(ResultDoctorTableViewCellDeleagteClikeAsk: model:)]) {
        [self.delegate ResultDoctorTableViewCellDeleagteClikeAsk:self model:_model];
    }
}
- (IBAction)onRightButton:(id)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(ResultDoctorTableViewCellDeleagteClikeResever:model:)]) {
        [self.delegate ResultDoctorTableViewCellDeleagteClikeResever:self model:_model];
    }
}
-(void)setModel:(SearchDoctorModel *)model {
    _model = model;
    self.distrubutionLabel.text = model.aboutMe;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/doctor/%@",model.photo]]];
    self.doctorLabel.text = model.name;
    self.pnoLabel.text = model.practitionerNo;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
