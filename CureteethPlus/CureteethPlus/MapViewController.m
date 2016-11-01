//
//  MapViewController.m
//  CureteethPlus
//
//  Created by Denny on 16/7/26.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapKit/BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "SearchPlaceHolderTextView.h"
@interface MapViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate,UITextViewDelegate,MSPlaceHolderTextViewDelegate,BMKPoiSearchDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BMKMapView *_mapView;
    BMKGeoCodeSearch *_geocodesearch;
    SearchPlaceHolderTextView *searchtextView;
    BMKPoiSearch* _poiSearch;
    NSMutableArray *searchDataSourceArray;
    BMKPointAnnotation *_annotation;
}
@end

@implementation MapViewController
- (id)initWithLng:(double)lng lat:(double)lat {
    if (self = [super init]) {
        self.lat = lat;
        self.lng = lng;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.title1;
    
    BaseNavViewController *navi = (BaseNavViewController *)self.navigationController;
    [navi enableGesturePop:NO];  // 当打开到地图界面 停止导航的pop手势
    
    _poiSearch=[[BMKPoiSearch alloc]init];
    _poiSearch.delegate = self;

    // Do any additional setup after loading the view from its nib.
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
    _mapView.zoomLevel = 15;
    _mapView.mapType = BMKMapTypeStandard;//设置地图为标准类型
    _mapView.showMapScaleBar = YES; // 比例尺
    
    //打开实时路况图层
//    [_mapView setTrafficEnabled:YES];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};//初始化
    if (self.lng!= 0 && self.lat!= 0) {
        //如果还没有给pt赋值,那就将当前的经纬度赋值给pt
        pt = (CLLocationCoordinate2D){self.lat,self.lng};
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
    reverseGeocodeSearchOption.reverseGeoPoint = pt;//设置反编码的点为pt
    _mapView.centerCoordinate = reverseGeocodeSearchOption.reverseGeoPoint;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
    if(flag){
        NSLog(@"反geo检索发送成功");
    }else{
        NSLog(@"反geo检索发送失败");
    }
    [self.view addSubview: _mapView];
    searchtextView = [[SearchPlaceHolderTextView alloc] initWithFrame:CGRectMake(0, 0, ScrMain_Width, 40) imageFrame:CGRectMake(0.18 * [UIScreen mainScreen].bounds.size.width, 7, 25, 25)];
    searchtextView.placeholder = @"请输入您所需要查询的地址";
    searchtextView.idelegate = self;
    searchtextView.font = [UIFont systemFontOfSize:13];
    searchtextView.searchImage.frame = CGRectMake(0.17 * [UIScreen mainScreen].bounds.size.width, 7, 25, 25);
    searchtextView.delegate = self;
    [self.view addSubview:searchtextView];
}
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    
    _mapView.centerCoordinate = userLocation.location.coordinate;
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}
/**
 *长按地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回长按事件坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate {
    // 点击屏幕 添加标注
    // 拿到点击的经纬度 然后添加标注
    CLLocationCoordinate2D coor;
    coor.latitude = coordinate.latitude;
    coor.longitude = coordinate.longitude;
    _annotation.coordinate = coor;
    [_mapView addAnnotation:_annotation];
    // 反geo检索信息类
    BMKReverseGeoCodeOption *reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoCodeOption.reverseGeoPoint = coor;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeoCodeOption];
    if (flag) {
        NSLog(@"反地理编码成功");
    } else {
        NSLog(@"反地理编码失败");
    }
}
-(MapSearchResultView *)searchResultView {
    if (!_searchResultView) {
        _searchResultView = [[MapSearchResultView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 40 - 282)];
        _searchResultView.seacrhTableView.delegate = self;
        _searchResultView.seacrhTableView.dataSource = self;
    }
    return _searchResultView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self;//设置代理为self

}

// Override    //根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
        NSString *AnnotationViewID = @"annotationViewID";
    //根据指定标识查找一个可被复用的标注View，一般在delegate中使用，用此函数来代替新申请一个View
    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    annotationView.canShowCallout = YES;
    return annotationView;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _poiSearch.delegate = nil;
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil;// 不使用时,置为nil
}


// 根据经纬度 获取 地区信息
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"根据经纬度 获取 地区信息%@", result.address);
        _title1 = result.address;
        if (![self.title isEqualToString:_title1]) {
            self.title = result.address;
            [CommonTool storeUserDefaults:result.address ForKey:KAddress];
            [CommonTool storeUserDefaults:[NSNumber numberWithDouble:result.location.latitude] ForKey:Klat];
            [CommonTool storeUserDefaults:[NSNumber numberWithDouble:result.location.longitude] ForKey:Klng];
            if (self.titleBlock != nil) {
                self.titleBlock(result.address);
            }
        }
    } else {
        NSLog(@"未找到结果");
    }
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
    }
}

-(void)textViewBeginEdit:(MSPlaceHolderTextView *)textView {
    searchtextView.searchImage.hidden = YES;
    searchtextView.placeHolderLabel.alpha = 0;
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        searchtextView.searchImage.hidden = NO;
        searchtextView.placeHolderLabel.alpha = 1;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        [self textViewDidChange:searchtextView];
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(MSPlaceHolderTextView *)textView{
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= [CommonTool readUserDefaultsByKey:KCity];
    citySearchOption.keyword = textView.text;
    BOOL flag = [_poiSearch poiSearchInCity:citySearchOption];
    if(flag){
        NSLog(@"城市内检索发送成功");
    }else{
        NSLog(@"城市内检索发送失败");
    }
}

#pragma mark - Poi关键字搜索
-(void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    if(poiResult.poiInfoList.count == 0){
        self.searchResultView.titleLabel.hidden = NO;
        self.searchResultView.seacrhTableView.hidden = YES;
    }else{
        self.searchResultView.titleLabel.hidden = YES;
        self.searchResultView.seacrhTableView.hidden = NO;
        searchDataSourceArray = [NSMutableArray arrayWithArray:poiResult.poiInfoList];
        [self.searchResultView.seacrhTableView reloadData];
        [self.view addSubview:self.searchResultView];
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  searchDataSourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMKPoiInfo *model = searchDataSourceArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"
                ];
    }
    NSString *addressString = [NSString stringWithFormat:@"%@ %@",model.name,model.address];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:addressString];
    NSRange nameRange = [addressString rangeOfString:[NSString stringWithFormat:@"%@:",model.name]];
    [attributedText addAttribute:NSForegroundColorAttributeName
                           value:[UIColor blackColor]
                           range:nameRange];
    NSRange addressRange = [addressString rangeOfString:[NSString stringWithFormat:@"%@:",model.address]];
    [attributedText addAttribute:NSForegroundColorAttributeName
                           value:[UIColor lightGrayColor]
                           range:addressRange];
    cell.textLabel.attributedText = attributedText;
    [cell.imageView setImage:[UIImage imageNamed:@"search"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BMKPoiInfo *model = searchDataSourceArray[indexPath.row];
    [CommonTool storeUserDefaults:[NSString stringWithFormat:@"%@",model.address] ForKey:KAddress];
    [CommonTool storeUserDefaults:[NSNumber numberWithDouble:model.pt.latitude] ForKey:Klat];
    [CommonTool storeUserDefaults:[NSNumber numberWithDouble:model.pt.longitude] ForKey:Klng];
    self.title = model.address;
    self.searchResultView.seacrhTableView.hidden = YES;
    // 拿到点击的经纬度 然后添加标注
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    BMKPointAnnotation *annot = [[BMKPointAnnotation alloc] init];
    annot.coordinate = model.pt;
    annot.title = model.address;
    _annotation = annot;
    [_mapView addAnnotation:_annotation];
    _mapView.centerCoordinate = annot.coordinate;
    searchtextView.text = @"";
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NSNotificationOfreloadWithAddress" object:nil];
}

//实现BMKGeoCodeSearch的Deleage处理回调结果
//接收正向编码结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

@end
