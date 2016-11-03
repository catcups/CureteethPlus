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
@interface MainViewController ()<BMKLocationServiceDelegate,UIAlertViewDelegate, UICollectionViewDelegate, BMKGeoCodeSearchDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) IconModel *iconModel;
@property (nonatomic, assign) NSInteger index1;
@property (nonatomic, assign) NSInteger start;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL canshowSearch;
@end

@implementation MainViewController {
    BMKLocationService *_locService;
    CGFloat offSetY;
}
- (void)viewDidAppear:(BOOL)animated {
    _searChTextfield.frame = CGRectMake(ScrMain_Width - 60, 5, 60, 30);
}
- (SearchPlaceHolderTextView *)searChTextfield {
    if (!_searChTextfield) {
        _searChTextfield = [[SearchPlaceHolderTextView alloc] initWithFrame:CGRectMake(0, 0, ScrMain_Width, 40) imageFrame:CGRectMake(5, 5, 20, 20)];
        _searChTextfield.delegate = self;
        _searChTextfield.idelegate = self;
        [_searChTextfield setPlaceholder:@"请输入诊所或牙医名称"];
        _searChTextfield.layer.cornerRadius = 10;
        _searChTextfield.alpha = 0.8;
        _searChTextfield.font = [UIFont systemFontOfSize:14];
        _searChTextfield.returnKeyType = UIReturnKeySearch;
    }
    return _searChTextfield;
}
- (id)init {
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"首页", nil) image:[UIImage imageNamed:@"home"] selectedImage:[[UIImage imageNamed:@"tabbar_SynthesisSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    offSetY = _scrollview.contentOffset.y;
    if (offSetY < 50) {
        [UIView animateWithDuration:0.25 animations:^{
            _searChTextfield.frame = CGRectMake(ScrMain_Width - 60, 5, 60, 30);
            [_searChTextfield setPlaceholder:@"搜索"];
            _searChTextfield.alpha = 0.8;
            _searChTextfield.searchImage.frame = CGRectMake(5, 5, 20, 20);
            _searChTextfield.layer.cornerRadius = 10;
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            _searChTextfield.frame = CGRectMake(0, 0, ScrMain_Width, 40);
            [_searChTextfield setPlaceholder:@"请输入诊所或牙医名称"];
            _searChTextfield.alpha = 1;
            _searChTextfield.searchImage.frame = CGRectMake(5, 5, 25, 25);
            _searChTextfield.layer.cornerRadius = 0;
        }];
    }
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
    [self.view addSubview:self.searChTextfield];
    [self startLoc];
    [self getItem];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadWithAddress:) name:@"NSNotificationOfreloadWithAddress" object:nil];
    self.scrollview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreDataFromNet];
    }];
}
// 设置十个item.轮播广告数据与轮播图url
- (void)getItem {
    MainReq *req = [[MainReq alloc]init];
    req.lat = @"31";
    req.lng = @"121";
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
        // 广告轮播
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
        [ws.dennyScrollview getDennyImageArray:responseObject[@"bannerImageArray"]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
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
        ws.ClinincModelArray = [NSMutableArray arrayWithArray:responseObject[@"clinincArray"]];
        [ws.tableview reloadData];
        ws.tableview.frame = CGRectMake(0, CGRectGetMaxY(_midView1.frame), CGRectGetWidth(self.view.frame), 110 * ws.ClinincModelArray.count);
        self.scrollview.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(_midView1.frame) +110 * self.ClinincModelArray.count + 49);
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
        ws.tableview.frame = CGRectMake(0, CGRectGetMaxY(_midView1.frame), CGRectGetWidth(self.view.frame), 110 * ws.ClinincModelArray.count);
        self.scrollview.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(_midView1.frame) +110 * self.ClinincModelArray.count + 49);
        [self.scrollview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.scrollview.mj_footer endRefreshing];
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    self.searChTextfield.searchImage.hidden = NO;
    self.searChTextfield.text = @"";
    [self.searchResultView removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        _searChTextfield.frame = CGRectMake(ScrMain_Width - 60, 5, 60, 30);
        _searChTextfield.searchImage.frame = CGRectMake(5, 5, 20, 20);
        _searChTextfield.layer.cornerRadius = 10;
        self.searChTextfield.alpha = 0.8;
    }];
    self.searchResultView = nil;
}
-(void)textViewBeginEdit:(MSPlaceHolderTextView *)textView {
    if (!self.canshowSearch) {
        return;
    }
    [UIView animateWithDuration:0 animations:^{
        _searChTextfield.frame = CGRectMake(0, 0, ScrMain_Width, 40);
        _searChTextfield.searchImage.frame = CGRectMake(5, 5, 25, 25);
        _searChTextfield.layer.cornerRadius = 0;
        _searChTextfield.alpha = 1;
    }];
//    self.searChTextfield.placeHolderLabel.alpha = 0.;
    self.searChTextfield.searchImage.hidden= YES;
    self.searchResultView = [[SearchResultView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 40)];
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
// 设置标题
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
// 加载十个item
- (void)loadMidView:(NSMutableArray *)array{
    IconModel *model = array[0];
    self.iconModel = model;
    self.index = 0;
    NSArray *titlrArray = @[model.icon1,model.icon2,model.icon3,model.icon4,model.icon5,model.icon6,model.icon7,model.icon8,model.icon9,model.icon10];
      NSArray *imageArray = @[model.icon1Img,model.icon2Img,model.icon3Img,model.icon4Img,model.icon5Img,model.icon6Img,model.icon7Img,model.icon8Img,model.icon9Img,model.icon10Img];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    CGFloat height = (_midView.frame.size.height - 20) / 2 < (_midView.frame.size.width - 60) / 5 ? (_midView.frame.size.height - 20) / 2 : (_midView.frame.size.width - 60) / 5;
    CGFloat height = (_midView.frame.size.height - 30) / 2 < (_midView.frame.size.width - 100) / 5 ? (_midView.frame.size.height - 30) / 2 : (_midView.frame.size.width - 100) / 5;
    layout.itemSize = CGSizeMake(height, height);
    layout.minimumLineSpacing = 10.0; // 竖
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
#if 1
    // 实例化定位管理器 并申请定位功能
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        NSLog(@"requestWhenInUseAuthorization");
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
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
            [CommonTool storeUserDefaults:[NSNumber numberWithDouble:userLocation.location.coordinate.latitude] ForKey:Klat];
            [CommonTool storeUserDefaults:[NSNumber numberWithDouble:userLocation.location.coordinate.longitude] ForKey:Klng];
            //找到了当前位置城市后就关闭服务
            [_locService stopUserLocationService];
            [self setTitleView];
            [self getdataSourceWithClinicName];
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
