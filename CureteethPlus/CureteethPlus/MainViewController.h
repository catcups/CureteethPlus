//
//  MainViewController.h
//  CureteethPlus
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "BaseViewController.h"
#import "MainTableViewCell.h"
#import "DennyScrollView.h"
#import "MainReq.h"
#import "ArticleModel.h"
#import "BannerModel.h"
#import "ClinincModel.h"
#import "IconModel.h"
#import "ArticleModel.h"
#import "MSPlaceHolderTextView.h"
#import "SearchResultView.h"
#import "SearchReq.h"
#import "SarchResultViewController.h"
#import "SearchPlaceHolderTextView.h"
@interface MainViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MSPlaceHolderTextViewDelegate,SearchResultViewDelegae,UITextViewDelegate>
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (assign,nonatomic) int count;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet SearchPlaceHolderTextView *searChTextfield;    // 首页搜索
@property (weak, nonatomic) IBOutlet UIView *midView;  // 10item
@property (weak, nonatomic) IBOutlet DennyScrollView *dennyScrollview;  // 轮播图
@property (weak, nonatomic) IBOutlet UIView *midView1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (nonatomic,strong)NSMutableArray *ArticleModelArray;
@property (nonatomic,strong)NSMutableArray *BannerModellArray;
@property (nonatomic,strong)NSMutableArray *ClinincModelArray;
@property (nonatomic,strong)NSMutableArray *IconModelArray;
@property (nonatomic,strong)UIButton *titleButton;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,strong)NSMutableArray *mid1TableViewDatasource;
@property (nonatomic,strong)SearchResultView *searchResultView;
@end
