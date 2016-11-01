//
//  MidViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/21.
//  Copyright © 2016年 Denny. All rights reserved.
//
// 十个item图标点击跳转的页面
#import "MidViewController.h"
#import "ResultDoctorTableViewCell.h"
#import "SearchDoctorModel.h"
#import "ClassifyReq.h"
#import "SearchDoctorModel.h"
#import "ReserveViewController.h"
#import "AskViewController.h"
#import "NodataView.h"
@interface MidViewController ()<ResultDoctorTableViewCellDeleagte>
@property (nonatomic,strong)NodataView *nodataView;
@end

@implementation MidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.tableFooterView = [[UIView alloc]init];
}

-(NodataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[NodataView alloc]initWithFrame:self.tableView.frame];
        [self.view addSubview:_nodataView];
    }
    return _nodataView;
}
-(id)initWithModel:(IconModel *)model index:(NSInteger)index {  // 10个item图标点击事件
    NSArray *array = @[model.icon1,model.icon2,model.icon3,model.icon4,model.icon5,model.icon6,model.icon7,model.icon8,model.icon9,model.icon10];
    self.title = array[index];
    ClassifyReq *req = [[ClassifyReq alloc]init];
    req.start = [NSNumber numberWithInteger:0];
    req.count = [NSNumber numberWithInteger:20];
    req.classify = [NSString stringWithFormat:@"%zi",index + 1];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        self.dataSource = [NSMutableArray arrayWithArray:responseObject];
        if (self.dataSource.count == 0) {
            self.nodataView.hidden = NO;
        }else {
            [self.tableView reloadData];
            self.nodataView.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.nodataView.hidden = YES;
    }];
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchDoctorModel *model =self.dataSource[indexPath.row];
    ResultDoctorTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ResultDoctorTableViewCell" owner:nil options:nil] lastObject];
    cell.model = model;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)ResultDoctorTableViewCellDeleagteClikeAsk:(ResultDoctorTableViewCell *)cell model:(SearchDoctorModel *)model {
    AskViewController *ask = [[AskViewController alloc]init];
    ask.doctorId1 = model.doctorId;
    ask.clinicId1 = model.clinicId;
    ask.changeAskMoreLB = YES;
    [self.navigationController pushViewController:ask animated:YES];
}

-(void)ResultDoctorTableViewCellDeleagteClikeResever:(ResultDoctorTableViewCell *)cell model:(SearchDoctorModel *)model {
    ReserveViewController *resever = [[ReserveViewController alloc]init];
    resever.clinicId = model.clinicId;
    resever.doctorId = model.doctorId;
    [self.navigationController pushViewController:resever animated:YES];
}
@end
