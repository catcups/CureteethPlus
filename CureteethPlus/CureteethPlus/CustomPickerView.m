//
//  CustomPickerView.m
//  WePlan
//
//  Created by candice on 12-12-26.
//  Copyright (c) 2012年 Higgses Inc. All rights reserved.
//

#import "CustomPickerView.h"
#import "AppDelegate.h"
#define kTHEAPP  ((AppDelegate *)[[UIApplication sharedApplication] delegate])
/*!
 *  屏幕高
 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/*
 *  屏幕宽
 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface CustomPickerView()
{
	UIWindow *window;
	UIButton *maskBtn;
}
@end

@implementation CustomPickerView
@synthesize pickerView = _pickerView;
@synthesize selectIndex = _selectIndex;
@synthesize delegate = _delegate;
@synthesize options = _options;
@synthesize datePickerView = _datePickerView;
@synthesize type = _type;


+ (CustomPickerView *)instanceDatePickerViewWithDelegate:(id<CustomPickerViewDelegate>)delegate
{
    CustomPickerView *pickerView = [[CustomPickerView alloc] initWithDelegate:delegate];
    pickerView.type = DatePicker;
    pickerView.pickerModel = UIDatePickerModeDate;
    return pickerView;
}

+ (CustomPickerView *)instanceNormalPickerViewWithDelegate:(id<CustomPickerViewDelegate>)delegate
{
    CustomPickerView *pickerView = [[CustomPickerView alloc] initWithDelegate:delegate];
    pickerView.type = NormalPicker;
    return pickerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"CustomPickerView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
//		_pickerView.backgroundColor = kColorFromRGB(0xffffff);
    }
    return self;
}

- (void)show
{
	window = window ? window : [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	maskBtn = maskBtn ? maskBtn : [[UIButton alloc] initWithFrame:window.bounds];
//	maskBtn.backgroundColor = kColorRGBA(0, 0, 0, 0.5);
    [self setFrame:CGRectMake(0, SCREEN_HEIGHT - self.bounds.size.height, SCREEN_WIDTH, self.bounds.size.height)];
	[maskBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
	[window addSubview:maskBtn];
//	[window addSubview:self];
	[self showInView:window];
	[window makeKeyAndVisible];
//	_isShow = YES;
}

- (void)hide
{
	NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
	[windows removeObject:window];
	window = nil;
	[kTHEAPP.window makeKeyAndVisible];
}

- (void)setType:(PickerType)type
{
    _type = type;
    if (_type == DatePicker)
    {
        [self initDatePickerView];
    }
}

- (void)showInView:(UIView *)view
{
    if (_type == DatePicker) {
        _pickerView.hidden = YES;
        [self initDatePickerView];
        _datePickerView.hidden = NO;
    }
    else
    {
        _datePickerView.hidden = YES;
        _pickerView.hidden = NO;
    }
    
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"CustomPickerView"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);    
    [view addSubview:self];
}

-(void)showDatePickerView:(UIView *)view
{
}

-(void)initDatePickerView
{
    if (!_datePickerView) {
        _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_datePickerView];        
    }
    _datePickerView.datePickerMode = _pickerModel;
}

- (void)hideSelf
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"CustomPickerView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
	[self performSelector:@selector(hide) withObject:nil afterDelay:0.3];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    [_pickerView selectRow:selectIndex inComponent:0 animated:NO];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _componentsNum ?: 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_componentsNum > 1)
    {
        return [_options[component] count];
    }
    else
    {
        return [_options count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_componentsNum > 1)
    {
        return _options[component][row];
    }
    return [_options objectAtIndex:row];
}

//- (UIView *)pickerView:(UIPickerView *)pickerView
//            viewForRow:(NSInteger)row
//          forComponent:(NSInteger)component
//           reusingView:(UIView *)view
//{
//    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    tmpLabel.backgroundColor = kCOLOR_BG_177EFB;
//    return tmpLabel;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

- (IBAction)cancel:(id)sender
{
    [self hideSelf];
    if ([_delegate respondsToSelector:@selector(setPickerCancelCallback)]) {
        [_delegate setPickerCancelCallback];
    }
}

- (IBAction)done:(id)sender
{
    if (_type == DatePicker)
    {
        NSDate * selected = [_datePickerView date];//获取选取时间
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        NSString *formatStr = _datePickerView.datePickerMode == UIDatePickerModeDateAndTime ? @"yyyy-MM-dd HH:mm" : @"yyyy-MM-dd";
        dateFormat.dateFormat = formatStr;
        NSString *dateStr = [dateFormat stringFromDate:selected];
        if ([_delegate respondsToSelector:@selector(datePickekerWithDate:PickerView:)])
        {
            [_delegate datePickekerWithDate:selected PickerView:self];
        }
        else if ([_delegate respondsToSelector:@selector(getDatePickerDoneCallback:PickerView:)])
        {
            [_delegate getDatePickerDoneCallback:dateStr PickerView:self];
        }
    }
    else
	{
        NSArray *selectedIndex = [self getAllComponentSelectedIndexs];
        if (_componentsNum > 1)
        {
            [_delegate pickerDidDoIndexs:selectedIndex PickerView:self];
        }
        else
        {
            _selectIndex = [_pickerView selectedRowInComponent:0];
            [_delegate setPickerDoneCallback:_selectIndex PickerView:self];
        }
	}
    [self hideSelf];
}


- (NSArray *)getAllComponentSelectedIndexs
{
    NSMutableArray *tmpDt = [NSMutableArray array];
    for (int i = 0; i< _componentsNum; i++)
    {
        [tmpDt addObject:@([_pickerView selectedRowInComponent:i])];
    }
    return tmpDt;
}


- (CustomPickerView *)initWithDelegate:(id<CustomPickerViewDelegate>)iDelegate
{
	self = [self init];
	_delegate = iDelegate;
	return self;
}
@end
