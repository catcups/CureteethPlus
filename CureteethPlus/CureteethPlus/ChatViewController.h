//
//  ChatViewController.h
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCell.h"
#import "Message.h"
#import "MSPlaceHolderTextView.h"
#import "BaseViewController.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface ChatViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_DataArray;
    Message *_message;
    UIView *_toobarView;
}
@property (nonatomic,strong)MSPlaceHolderTextView *textView;
@property (nonatomic,strong)UIButton *btn2;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) CGFloat oldContentOffsetY;
@property (nonatomic, assign) CGFloat currentContentOffsetY;

@property (nonatomic,strong)NSString *advisoryId;
@end
