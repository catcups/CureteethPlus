//
//  LoginSuccessTableViewCell.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "LoginSuccessTableViewCell.h"

@implementation LoginSuccessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.layer.cornerRadius = 30;
    self.headImage.layer.masksToBounds = YES;
    self.userNameLabel.text = [CommonTool readUserDefaultsByKey:KName];
    [self.mobileButton setTitle:[CommonTool readUserDefaultsByKey:KPhoneNumber] forState:UIControlStateNormal];
    [self.headImage setImage:[UIImage imageNamed:[CommonTool readUserDefaultsByKey:Kphoto]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)makeCall:(UIButton *)sender {
    if (sender.titleLabel.text) {
        [StringUtils makeCall:sender.titleLabel.text];
    }
}

@end
