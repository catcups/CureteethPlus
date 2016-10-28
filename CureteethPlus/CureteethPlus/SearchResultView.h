//
//  SearchResultView.h
//  CureteethPlus
//
//  Created by Denny on 16/7/17.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResultView;
@protocol SearchResultViewDelegae <NSObject>

-(void)dismissSearchView:(SearchResultView *)view;

@end
@interface SearchResultView : UIView
@property(nonatomic,assign)id<SearchResultViewDelegae>delegate;
@property (nonatomic,strong)UILabel *resultLabel;
@end
