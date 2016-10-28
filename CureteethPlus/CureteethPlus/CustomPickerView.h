//
//  CustomPickerView.h
//  WePlan
//
//  Created by candice on 12-12-26.
//  Copyright (c) 2012年 Higgses Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
/*!
 * PickerType 1日期 2自定义
 */
enum
{
  DatePicker = 1,
  NormalPicker
};
typedef NSInteger PickerType;


@class CustomPickerView;
@protocol CustomPickerViewDelegate <NSObject>

@optional
/*!
 *  picker点击确定后调用方法
 *
 *  @param index      选择索引
 *  @param pickerView 当前pickerView
 */
- (void)setPickerDoneCallback:(NSInteger)index PickerView:(CustomPickerView *)pickerView;

- (void)pickerDidDoIndexs:(NSArray *)indexs PickerView:(CustomPickerView *)pickerView;

/*!
 *  取消PickerView时调用方法
 */
- (void)setPickerCancelCallback;

/*!
 *  日期类型时，确定选择后调用方法
 *
 *  @param date       选择时间
 *  @param pickerView 当前pickerView
 */
- (void)getDatePickerDoneCallback:(NSString *)date PickerView:(CustomPickerView *)pickerView;

/**
 *  日期类型时，确定选择后调用方法
 *
 *  @param date       选择时间
 *  @param pickerView 当前pickerView
 */
- (void)datePickekerWithDate:(NSDate *)date PickerView:(CustomPickerView *)pickerView;

@end

/*!
 *  自定义控件PickerView
 */
@interface CustomPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, assign) id<CustomPickerViewDelegate> delegate;
@property (nonatomic)PickerType type;
@property (nonatomic)UIDatePickerMode pickerModel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (retain, nonatomic) UIDatePicker *datePickerView;
@property (nonatomic, assign) NSInteger selectIndex;

/**
 *  Picker列数
 */
@property (nonatomic, assign) NSInteger componentsNum;

/*!
 *  设置选择项
 */
@property (nonatomic, retain) NSArray *options;


/*!
 *  显示PickerView
 */
- (void)show;


- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

/*!
 *  设置Picker类型
 *
 *  @param type PickerType
 */
- (void)setType:(PickerType)type;

- (CustomPickerView *)initWithDelegate:(id<CustomPickerViewDelegate>)iDelegate;

+ (CustomPickerView *)instanceDatePickerViewWithDelegate:(id<CustomPickerViewDelegate>)delegate;
+ (CustomPickerView *)instanceNormalPickerViewWithDelegate:(id<CustomPickerViewDelegate>)delegate;

@end

