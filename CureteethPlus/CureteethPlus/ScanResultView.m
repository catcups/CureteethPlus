//
//  ScanResultView.m
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ScanResultView.h"

@implementation ScanResultView
+ (ScanResultView *)creatView {
    return [[[NSBundle mainBundle]loadNibNamed:@"ScanResultView" owner:nil options:nil] lastObject];
}
-(void)awakeFromNib {
    self.submitButton.layer.cornerRadius = 5;
    self.submitButton.layer.masksToBounds = YES;
}
- (IBAction)onSubmitButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ScanResultViewDelegateOnsubmitButton:)]) {
        [self.delegate ScanResultViewDelegateOnsubmitButton:self];
    }
}

@end
