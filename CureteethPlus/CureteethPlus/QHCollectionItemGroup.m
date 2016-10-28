//
//  collectionItemGroup.m
//  radioGroup
//
//  Created by Vanessa on 2016/10/25.
//  Copyright © 2016年 Vanessa. All rights reserved.
//

#import "QHCollectionItemGroup.h"
#import "UIImageView+WebCache.h"
@interface QHCollectionItemGroup ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UICollectionViewFlowLayout *Layout;
@end
@implementation QHCollectionItemGroup

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout withImage:(NSArray *)image andTitle:(NSArray *)title {
    static QHCollectionItemGroup *group = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    if ((group = [super initWithFrame:frame collectionViewLayout:layout])) {
        _Layout = (UICollectionViewFlowLayout *)layout;
        _imageArr = image;
        _titleArr = title;
        group.backgroundColor = [UIColor whiteColor];
        group.pagingEnabled = NO;
        group.scrollEnabled = NO;
        group.showsHorizontalScrollIndicator = NO;
        group.showsVerticalScrollIndicator = NO;
        group.bounces = NO;
        group.delegate = group;
        group.dataSource = group;
        [group registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    });
    return group;
//    return self;
}
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    CGRect cellFrame = cell.frame;
    cellFrame.size = _Layout.itemSize;
    cell.frame = cellFrame;
    UIImageView *imageV = nil;
    if ([NSStringFromClass([_imageArr[indexPath.row] class]) isEqualToString:@"UIImage"]) { // 如果是UIImage数组 即 本地图片
        imageV = [[UIImageView alloc] initWithImage:_imageArr[indexPath.row]];
    } else { // 如果是NSString 数组 即 urlStr
        imageV = [[UIImageView alloc] init];
        // 赋值在这里用SDWebImage加载图片
        [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yyaai.com/uploads/icons/%@", _imageArr[indexPath.row]]]];
    }
    imageV.frame = CGRectMake(cellFrame.size.width * 0.1, 0, cellFrame.size.width * 0.8, cellFrame.size.width * 0.8);
    imageV.layer.cornerRadius = imageV.frame.size.width * 0.5;
    imageV.layer.masksToBounds = YES;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.frame.size.height, cellFrame.size.width, cellFrame.size.width * 0.2)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = _titleArr[indexPath.row];
    label.font = [UIFont systemFontOfSize:12];
    for (UIImageView *image in cell.contentView.subviews) {
        [image removeFromSuperview];
    }
    for (UILabel *label in cell.contentView.subviews) {
        [label removeFromSuperview];
    }
    [cell.contentView addSubview:imageV];
    [cell.contentView addSubview:label];
    return cell;
}

@end
