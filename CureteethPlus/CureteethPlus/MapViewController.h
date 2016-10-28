//
//  MapViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/7/26.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"
#import "MapSearchResultView.h"

@interface MapViewController : BaseViewController
- (id)initWithLng:(double)lng lat:(double)lat;
@property (nonatomic,assign)double lng;
@property (nonatomic,assign)double lat;
@property (nonatomic,strong)NSString *title1;
@property (nonatomic,strong)MapSearchResultView *searchResultView;
@property (nonatomic, copy) void (^titleBlock)(NSString *title); // 当map页面的title更换时调用

@end
