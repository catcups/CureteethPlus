//
//  QHScrollUpDownView.m
//  QHScrollerViewUpDown
//
//  Created by QH on 2016/10/26.
//  Copyright © 2016年 QH. All rights reserved.
//

#import "QHScrollUpDownView.h"
#import "UIImage+Extension.h"

@interface QHScrollUpDownView ()<UIScrollViewDelegate>

// 最下面的scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
// 标题数组
@property (nonatomic, strong) NSMutableArray *titles;

// 定时器 当用户拖拽的时候 不需要自动滑动 所以设置为属性
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation QHScrollUpDownView {
    CGRect nowFrame;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    if (titles.count == 0) {
        return nil;
    }
    NSLog(@"ScrollView封装的初始化");
    static QHScrollUpDownView *scroll = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((scroll = [super initWithFrame:frame])) {
            nowFrame = frame;
            scroll.titles = titles.mutableCopy;
            if (scroll.titles.count % 2 == 1 && titles.count > 2) {
                [scroll.titles removeAllObjects];
                [scroll.titles addObject:titles[titles.count - 2]];
                [scroll.titles addObject:titles.lastObject];
                for (NSString *str in titles) {
                    [scroll.titles addObject:str];
                }
                [scroll.titles addObject:titles.firstObject];
                [scroll.titles addObject:titles[1]];
                [scroll.titles addObject:titles[2]];
            } // 后期可➕判断
            [scroll createScrollView];
            [scroll initTitles];
            // 超过两个标题才创建timer
            if (scroll.titles.count > 2) {
                [scroll createTimer];
            }
        }
    });
    return scroll;
}

- (void)createScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 0, nowFrame.size.width, nowFrame.size.height)];
    self.scrollView.contentSize = CGSizeMake(0, (nowFrame.size.height * self.titles.count / 2));
    self.scrollView.backgroundColor = [UIColor clearColor];
    //    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollEnabled = NO; // 禁止用户拖动scrollView
    

    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
}

- (void)initTitles
{
    NSInteger tit = 0;
    // 如果只有一两个title不用循环播放 直接创建一个View;
    if (self.titles.count <= 2) {
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, nowFrame.size.width, nowFrame.size.height)];
        for (NSString *str in self.titles) {
            [titleView addSubview:[self createButtonWith:tit andTitle:str]];
            tit++;
        }
        [self.scrollView addSubview:titleView];
        return;
    }
    
    // 点击事件
        // 在上下两边各添加一个View
        self.scrollView.contentSize = CGSizeMake(0, nowFrame.size.height * self.titles.count / 2);
        // 整页滚动
        self.scrollView.pagingEnabled = YES;
        // 一上来就显示第一个
        self.scrollView.contentOffset = CGPointMake(0, nowFrame.size.height);
        for (int i = 0; i <  self.titles.count / 2; i++) {
            NSLog(@"for循环");
            UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, i * nowFrame.size.height, nowFrame.size.width, nowFrame.size.height)];
            
            
            for (int j = 0; j < 2; j++) {
                [titleView addSubview:[self createButtonWith:tit andTitle:_titles[tit]]];
                tit++;
            }
            [self.scrollView addSubview:titleView];
        }
}
// 创建UIButton并给予tag值
- (UIButton *)createButtonWith:(NSInteger)tag andTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *image = [UIImage imageWithColor:[UIColor blueColor]].circleImage;
    if (tag % 2 == 1) {
        btn.frame = CGRectMake(0, nowFrame.size.height / 2, nowFrame.size.width, nowFrame.size.height / 2);
    } else {
        btn.frame = CGRectMake(0, 0, nowFrame.size.width, nowFrame.size.height / 2);
    }
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    NSLog(@"第%ld个btn, %@ ,=======%@", tag, NSStringFromCGRect(btn.frame) , btn.titleLabel.text);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; // 文字左对齐
    [btn addTarget:self action:sel_registerName("titleClickFuncation:") forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    return btn;
}

// 按钮点击
- (void)titleClickFuncation:(UIButton *)sender
{
    if (self.titleClick) {
        self.titleClick(sender.titleLabel.text);
    }
}

// 结束减速时判断偏移量
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 如果偏移到第0个 回到最后一个
    if (self.scrollView.contentOffset.y == 0) {
        self.scrollView.contentOffset = CGPointMake(0, nowFrame.size.height);
    }
    // 如果偏移到最后一个 回到第一个
    if (self.scrollView.contentOffset.y >= nowFrame.size.height * (self.titles.count / 2)) {
        self.scrollView.contentOffset = CGPointMake(0, nowFrame.size.height);
    }
}

// 正在滚动中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 如果偏移到第0个 回到最后一个
    if (self.scrollView.contentOffset.y <= 0) {
        self.scrollView.contentOffset = CGPointMake(0, nowFrame.size.height);
    }
    // 如果偏移到最后一个 回到第一个
    if (self.scrollView.contentOffset.y > nowFrame.size.height * (self.titles.count / 2)) {
        self.scrollView.contentOffset = CGPointMake(0, nowFrame.size.height);
    }
}

// 当我们代码更改了偏移量 并且使用了动画的时候 会调用这个方法 不会调用结束减速的方法 我们可以手动调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:self.scrollView];
}

- (void)createTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerHander) userInfo:nil repeats:YES];
}

// 开始拖拽时继续定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 定时器没有提供暂停的方法 我们可以设置它在什么时间开启
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:MAXFLOAT]];
}

// 结束拖拽时继续定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

// 定时器方法
- (void)timerHander
{
    CGPoint offSet = self.scrollView.contentOffset;
    offSet.y += nowFrame.size.height;
    [self.scrollView setContentOffset:offSet animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
