//
//  ReserveViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"
#import "LGCalendar.h"
@interface ReserveViewController : BaseViewController
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)LGCalendar *lgCalendar;
@end
