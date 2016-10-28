//
//  ClinicTableViewCell.h
//  CureteethPlus
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClinicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *linicName;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *clinincImage;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *subMitButton;

@end
