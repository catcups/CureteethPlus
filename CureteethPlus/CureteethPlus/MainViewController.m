//
//  MainViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MainViewController.h"
#import "NodataView.h"
#import "MidViewController.h"
#import "Mid1ViewController.h"
#import "MainDetailViewController.h"
#import "MapViewController.h"
#import "ScanViewController.h"
#import "MessageViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "QHCollectionItemGroup.h"
#import "QHScrollUpDownView.h"
//static CGFloat kdefaultlat = 
@interface MainViewController ()<BMKLocationServiceDelegate,UIAlertViewDelegate, UICollectionViewDelegate, BMKGeoCodeSearchDelegate>
@property (nonatomic, strong) IconModel *iconModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;
@property (nonatomic, assign) NSInteger index1;
@property (nonatomic, assign) NSInteger start;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL canshowSearch;
@end

@implementation MainViewController {
    BMKLocationService *_locService;
}
- (id)init {
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"首页", nil) image:[UIImage imageNamed:@"home"] selectedImage:[[UIImage imageNamed:@"tabbar_SynthesisSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}

- (void)configNavgation {
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    UIButton *leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(-12, 0, 44, 44)];
    [leftbutton setImage:[UIImage imageNamed:@"qrcode"] forState:UIControlStateNormal];
    [leftView addSubview:leftbutton];
    [leftbutton addTarget:self action:@selector(onLeftBarButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *rtghtButton = [[UIButton alloc]initWithFrame:CGRectMake(12, 0, 44, 44)];
    [rtghtButton setImage:[UIImage imageNamed:@"bell"] forState:UIControlStateNormal];
    [rightView addSubview:rtghtButton];
    [rtghtButton addTarget:self action:@selector(onRightBarButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavgation];
    self.start = 1 ;
    self.searChTextfield.idelegate = self;
    self.searChTextfield.placeholder = @"请输入诊所或牙医名称";
    [self startLoc];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadWithAddress:) name:@"NSNotificationOfreloadWithAddress" object:nil];
//    self.scrollview.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self getdataSourceWithClinicName];
//    }];
    self.scrollview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreDataFromNet];
    }];
}
- (void)reloadWithAddress:(NSNotification *)notification {
    [self.titleButton setTitle:[CommonTool readUserDefaultsByKey:KAddress] forState:UIControlStateNormal];
    [self getdataSourceWithClinicName];
}
- (void)getdataSourceWithClinicName{
    MainReq *req = [[MainReq alloc]init];
    req.lat = [CommonTool readUserDefaultsByKey:Klat];
    req.lng = [CommonTool readUserDefaultsByKey:Klng];
    req.start = [NSNumber numberWithInteger:0];
    req.count = [NSNumber numberWithInteger:10];
    WS(ws);
    [SVProgressHUD show];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        [ws loadMidView:responseObject[@"iconArray"]];
        
        ws.mid1TableViewDatasource = [NSMutableArray arrayWithArray:responseObject[@"articleArray"]];
        NSMutableArray *titles = [NSMutableArray array];
        for (ArticleModel *model in ws.mid1TableViewDatasource) {
            [titles addObject:model.title];
        };
        QHScrollUpDownView *scroller = [[QHScrollUpDownView alloc] initWithFrame:CGRectMake(70, 0, ws.midView1.frame.size.width - 70, 60) titles:titles];
        [self.midView1 addSubview:scroller];
        scroller.titleClick = ^(NSString *title) {
            Mid1ViewController *mid1VC = [Mid1ViewController new];
            for (ArticleModel *model in _mid1TableViewDatasource) {
                if ([model.title isEqualToString:title]) {
                    mid1VC.model = model;
                    break;
                }
            }
            [self.navigationController pushViewController:mid1VC animated:YES];
        };
        ws.ClinincModelArray = [NSMutableArray arrayWithArray:responseObject[@"clinincArray"]];
        [ws.dennyScrollview getDennyImageArray:responseObject[@"bannerImageArray"]];
        [ws.tableview reloadData];
        ws.tableview.frame = CGRectMake(0, 40 + 130 + 150 + 60, CGRectGetWidth(self.view.frame),110 * ws.ClinincModelArray.count);
        self.tableviewHeight.constant = self.ClinincModelArray.count * 110 + 49;
        self.scrollview.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),49 + 395 +110 * self.ClinincModelArray.count);
        NSLog(@"请求成功~~~");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)loadMoreDataFromNet {
    MainReq *req = [[MainReq alloc]init];
    req.lat = [CommonTool readUserDefaultsByKey:Klat];
    req.lng = [CommonTool readUserDefaultsByKey:Klng];
    req.start = [NSNumber numberWithInteger:self.start];
    req.count = [NSNumber numberWithInteger:10];
    WS(ws);
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        self.start ++;
        [ws.ClinincModelArray addObjectsFromArray:responseObject[@"clinincArray"]];
        [ws.tableview reloadData];
        ws.tableview.frame = CGRectMake(0, 395, CGRectGetWidth(self.view.frame),110 * ws.ClinincModelArray.count);
        self.tableviewHeight.constant = self.ClinincModelArray.count * 110+ 49;
        self.scrollview.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 49 + 395 +110 * self.ClinincModelArray.count);
        [self.scrollview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.scrollview.mj_footer endRefreshing];
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    self.searChTextfield.searchImage.hidden = NO;
    self.searChTextfield.alpha =  1;
    self.searChTextfield.text = @"";
    [self.searchResultView removeFromSuperview];
    self.searchResultView = nil;
}
-(void)textViewBeginEdit:(MSPlaceHolderTextView *)textView {
    if (!self.canshowSearch) {
        return;
    }
    self.searChTextfield.placeHolderLabel.alpha = 0.;
    self.searChTextfield.searchImage.hidden= YES;
    self.searchResultView = [[SearchResultView alloc]initWithFrame:CGRectMake(0,41 , CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 41)];
    self.searchResultView.delegate = self;
    [self.view addSubview:self.searchResultView];
}
-(void)dismissSearchView:(SearchResultView *)view {
    [self.view endEditing:YES];
    self.searChTextfield.text = @"";
    [self.searchResultView removeFromSuperview];
    self.searchResultView = nil;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
       //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        SearchReq *req = [[SearchReq alloc] init];
        req.start = [NSNumber numberWithInt:0];
        req.count = [NSNumber numberWithInt:20];
        req.searchText = textView.text;
        [req request:^(NSURLSessionDataTask *task, id responseObject) {
            [self handDataSource:responseObject];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            self.searchResultView.resultLabel.hidden = NO;
        }];
        return NO;
    }
    return YES;
}

-(void)handDataSource:(NSDictionary *)dic {
    NSMutableArray *doctorArray = dic[@"doctorArray"];
    NSMutableArray *clinicArray = dic[@"clinincArray"];
    if (doctorArray.count == 0 && clinicArray.count) {
        self.searchResultView.resultLabel.hidden = NO;
    }else{
        self.searChTextfield.text = @"";
        SarchResultViewController *search = [[SarchResultViewController alloc]init];
        search.dicDataSource = dic;
        search.hidesBottomBarWhenPushed = YES;
        [self.view endEditing:YES];
        [self.navigationController pushViewController:search animated:YES];
        self.searchResultView.resultLabel.hidden = YES;
    }
}

-(void)setTitleView {
    self.titleButton = [[UIButton alloc]initWithFrame:CGRectMake(50,0,[UIScreen mainScreen].bounds.size.width - 100, 44)];
    [self.titleButton setTitle:[CommonTool readUserDefaultsByKey:KAddress] forState:UIControlStateNormal];
    self.titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.titleButton setImage:[UIImage imageNamed:@"local"] forState:UIControlStateNormal];
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [self.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleButton addTarget:self action:@selector(tittleButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.titleButton;

}

- (void)loadMidView:(NSMutableArray *)array{
    IconModel *model = array[0];
    self.iconModel = model;
    self.index = 0;
    NSArray *titlrArray = @[model.icon1,model.icon2,model.icon3,model.icon4,model.icon5,model.icon6,model.icon7,model.icon8,model.icon9,model.icon10];
      NSArray *imageArray = @[model.icon1Img,model.icon2Img,model.icon3Img,model.icon4Img,model.icon5Img,model.icon6Img,model.icon7Img,model.icon8Img,model.icon9Img,model.icon10Img];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat height = (_midView.frame.size.height - 20) / 2 < (_midView.frame.size.width - 60) / 5 ? (_midView.frame.size.height - 20) / 2 : (_midView.frame.size.width - 60) / 5;
    layout.itemSize = CGSizeMake(height, height);
    layout.minimumLineSpacing = 0.0; // 竖
    layout.minimumInteritemSpacing = 10.0; // 横
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    QHCollectionItemGroup *collec = [[QHCollectionItemGroup alloc] initWithFrame:CGRectMake(0, 0, _midView.frame.size.width, _midView.frame.size.height) collectionViewLayout:layout withImage:imageArray andTitle:titlrArray];
    collec.delegate = self;
    [self.midView addSubview:collec];

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MidViewController *mid = [[MidViewController alloc]initWithModel:self.iconModel index:indexPath.row];
    mid.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mid animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ClinincModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClinincModel *model = self.ClinincModelArray[indexPath.row];
    MainTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MainTableViewCell" owner:nil options:nil] lastObject];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ClinincModel *model = self.ClinincModelArray[indexPath.row];
    MainDetailViewController *detail = [[MainDetailViewController alloc]init];
    detail.clinicId = model.clinicId;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)tittleButton:(UIButton *)sender {
    MapViewController *map = [[MapViewController alloc]initWithLng:[[CommonTool readUserDefaultsByKey:Klng] doubleValue] lat:[[CommonTool readUserDefaultsByKey:Klat] doubleValue]];
    map.hidesBottomBarWhenPushed = YES;
    map.title1 = [CommonTool readUserDefaultsByKey:KAddress];
    map.titleBlock = ^(NSString *title) {
        [self.titleButton setTitle:[CommonTool readUserDefaultsByKey:KAddress] forState:UIControlStateNormal];
        
    };
    [self.navigationController pushViewController:map animated:YES];
}

- (void)onRightBarButton {  // 推送消息
    if ([CommonTool readUserDefaultsByKey:KisLogin]) {
        MessageViewController *message = [[MessageViewController alloc]init];
        message.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:message animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请先登录!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
    }
}

- (void)onLeftBarButton {
    ScanViewController *scan = [[ScanViewController alloc] init];
    scan.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scan animated:YES];
}
- (void)dealloc {
    self.tableview.delegate = nil;
}
- (void)startLoc {
    // 实例化定位管理器 并申请定位功能
    _locationManager = [[CLLocationManager alloc] init];
    // 如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    }
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    BMKGeoCodeSearch *geo = [[BMKGeoCodeSearch alloc] init];
    geo.delegate = self;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;//设置反编码的点为当前位置
    BOOL flag = [geo reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
    if(flag){
        NSLog(@"反geo检索发送成功");
    }else{
        NSLog(@"反geo检索发送失败");
    }
//    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
//    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
//    [geoCoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
//        if (placemarks.count > 0) {
//            NSString *address;
//            CLPlacemark *placemark = placemarks[0];
//            NSString *street,*city,*sublocality,*state;
//            if (!placemark.addressDictionary[@"Street"]) {
//                street = @"";
//            }else {
//                street = placemark.addressDictionary[@"Street"];
//            }if (!placemark.addressDictionary[@"City"]) {
//                city = @"";
//            }else {
//                city = placemark.addressDictionary[@"City"];
//            }if (!placemark.addressDictionary[@"SubLocality"]) {
//                sublocality = @"";
//            }else {
//                sublocality = placemark.addressDictionary[@"SubLocality"];
//            }if (!placemark.addressDictionary[@"State"]) {
//                state = @"";
//            }else {
//                state = placemark.addressDictionary[@"State"];
//            }
//            if ([state isEqualToString:city]) { // 判断省与市的名字是否相同 相同的话去掉一个 例 北京市与上海市的省会与市的名字一样
//                address = [NSString stringWithFormat:@"%@%@%@",city,sublocality,street];
//            } else {
//                address = [NSString stringWithFormat:@"%@%@%@%@",state,city,sublocality,street];
//            }
            [CommonTool storeUserDefaults:[NSNumber numberWithDouble:userLocation.location.coordinate.latitude] ForKey:Klat];
            [CommonTool storeUserDefaults:[NSNumber numberWithDouble:userLocation.location.coordinate.longitude] ForKey:Klng];
            //找到了当前位置城市后就关闭服务
            [_locService stopUserLocationService];
            [self setTitleView];
            [self getdataSourceWithClinicName];
//        } else if (error == nil && placemarks.count == 0) {
//            NSLog(@"No location and error returned");
//        } else if (error) {
//            NSLog(@"Location error: %@", error);  // 定位错误
//        }
//    }];
}
// 根据经纬度 获取 地区信息
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"根据经纬度 获取 地区信息%@", result.address);
        [self.titleButton setTitle:result.address forState:UIControlStateNormal];
        [CommonTool storeUserDefaults:result.address ForKey:KAddress];
        [CommonTool storeUserDefaults:result.address ForKey:KCity];

    } else {
        NSLog(@"未找到结果");
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex!= alertView.cancelButtonIndex) {
        LoginViewController *log =[[LoginViewController alloc]init];
        log.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:log animated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated {
    self.canshowSearch = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    self.canshowSearch = NO;
}
@end
