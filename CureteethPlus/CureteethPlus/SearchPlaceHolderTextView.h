//
//  SearchPlaceHolderTextView.h
//  CureteethPlus
//
//  Created by Denny on 16/8/9.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "MSPlaceHolderTextView.h"


@interface SearchPlaceHolderTextView : MSPlaceHolderTextView
@property(nonatomic,strong)UIImageView *searchImage;
- (id)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame;
@end
