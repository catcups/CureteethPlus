//
//  collectionItemGroup.h
//  radioGroup
//
//  Created by Vanessa on 2016/10/25.
//  Copyright © 2016年 Vanessa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QHCollectionItemGroup : UICollectionView
/**
 *  @frame: collectionView的frame
 *
 *  @layout: UICollectionViewFlowLayout的属性 这次放在外界设置了，比较方便
 *
 *  @image: 本地图片数组(NSArray<UIImage *> *) 或者网络url的字符串(NSArray<NSString *> *)
 *  @title: 每个item的标题
 *
 */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout withImage:(NSArray *)image andTitle:(NSArray *)title;
@end
