//
//  MessageViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/18.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageChildTwoViewController.h"
#import "MessageChindOneViewController.h"

@interface MessageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)MessageChindOneViewController *chinldOne;
@property (nonatomic,strong)MessageChildTwoViewController *childTwo;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40,[UIScreen mainScreen].bounds.size.width/2, 1)];
    self.lineView.backgroundColor = KMainColor;
    [self.view addSubview:self.lineView];
    [self onleftButton:self.leftButton];
                                                           
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)onleftButton:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = CGRectMake(0, 40,[UIScreen mainScreen].bounds.size.width/2, 1);
    }];
    [self getChinldViewOne];
}
- (IBAction)onRightButton:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 40, [UIScreen mainScreen].bounds.size.width/2, 1);
    }];
    [self getChinldViewTwo];
}

-(void)getChinldViewOne {
    if (!_chinldOne) {
        _chinldOne = [[MessageChindOneViewController alloc]init];
        _chinldOne.view.frame = CGRectMake(0, 41, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.bounds)-  41);
        [self.view addSubview:_chinldOne.view];
        [self addChildViewController:_chinldOne];
    }
    if (_childTwo) {
        _childTwo.view.hidden = YES;
    }
    _chinldOne.view.hidden = NO;
}

-(void)getChinldViewTwo{
    if (!_childTwo) {
        _childTwo = [[MessageChildTwoViewController alloc]init];
        _childTwo.view.frame = CGRectMake(0, 41, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.bounds)-  41);
        [self.view addSubview:_childTwo.view];
        [self addChildViewController:_childTwo];
    };
    if (_chinldOne) {
        _chinldOne.view.hidden = YES;
    }
    _childTwo.view.hidden = NO;
}
@end
