//
//  ChatViewController.m
//  CureTeeth
//
//  Created by Denny on 16/7/16.
//  Copyright © 2016年 Denny. All rights reserved.
//

#import "ChatViewController.h"
#import <SRWebSocket.h>
#import "ChatListReq.h"
#import "ReplyReq.h"
#import "ReserveViewController.h"
@interface ChatViewController ()<SRWebSocketDelegate,MessageCellDelegate>
@property (nonatomic,strong)Message *infoModel;
@property (nonatomic,strong)SRWebSocket *webSocket;
@property (nonatomic,strong)NSURL *userPhotoUrl;
@property (nonatomic,strong)NSURL *doctorPhotoUrl;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"咨询";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-45-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentOffset = CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
    [self.view addSubview:_tableView];
    [self createBttomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeText:) name:UITextViewTextDidChangeNotification object:self.textView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];    // Do any additional setup after loading the view from its nib.
    [self connectWebSocket];
    ChatListReq *req = [[ChatListReq alloc]init];
    req.advisoryId = self.advisoryId;
    [SVProgressHUD show];
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        self.userPhotoUrl = responseObject[@"userPhoto"];
        self.doctorPhotoUrl = responseObject[@"doctorsphoto"];
        CGFloat contentOffSet = 0.;
        for (Message *message in responseObject[@"dataSourceArray"]) {
            contentOffSet += message.frame.size.height + 25;
            if (message.info) {
                self.infoModel = message;
            }
        }
        _DataArray = [NSMutableArray arrayWithArray:responseObject[@"dataSourceArray"]];
        if(contentOffSet > 200){
            [_tableView setContentOffset:CGPointMake(0, contentOffSet) animated:YES];

        }
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark -----------UI
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _DataArray.count;
}

-(void)createBttomView {
    _toobarView = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenH-45-64, kScreenW, 45)];
    _toobarView.backgroundColor = [UIColor whiteColor];
    _toobarView.layer.borderWidth = 0.5;
    _toobarView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_toobarView];
    self.textView = [[MSPlaceHolderTextView alloc] initWithFrame:CGRectMake(15, 6, kScreenW - 47 - 65, 33)];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.idelegate = nil;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    self.textView.layer.cornerRadius = 5.0f;
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.textColor = [UIColor grayColor];
    self.textView.tintColor = KMainColor;
    self.textView.placeholder = @"请输入回复内容";
    self.textView.alwaysBounceVertical = NO;
    self.textView.textContainerInset = UIEdgeInsetsMake(5, 2, 4, 2);
    self.textView.contentInset = UIEdgeInsetsMake(4, 0, 4, 0);
    self.textView.delegate = self;
    [_toobarView addSubview:self.textView];
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn2 setTitle:@"回复" forState:UIControlStateNormal];
    self.btn2.layer.cornerRadius = 5;
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.btn2 addTarget:self action:@selector(onBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.btn2 setBackgroundColor:KMainColor];
    self.btn2.frame = CGRectMake(kScreenW-60, 5, 50, 35);
    [_toobarView addSubview:self.btn2];
}

-(void)onBtn2{
    [self handMessageContent];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    Message *message =_DataArray[indexPath.row];
    cell.delegate = self;
    cell.message = message;
    if (message.isSelf) {
        [cell.headImage sd_setImageWithURL:self.userPhotoUrl];
    }else{
        [cell.headImage sd_setImageWithURL:self.doctorPhotoUrl];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = _DataArray[indexPath.row];
    CGFloat height = message.frame.size.height;
    return height + 65;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    self.oldContentOffsetY = targetContentOffset->y;
    [self.textView resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
   return [self handMessageContent];
}

-(void)keyboardWillShow:(NSNotification *)obj {
    NSDictionary* userInfo = [obj userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:self.view.superview];
    if (_tableView.contentSize.height >  CGRectGetHeight(_tableView.frame) - keyboardRect.size.height) {
        CGFloat tmpOffSetY = _tableView.contentSize.height - CGRectGetHeight(_tableView.frame) + keyboardRect.size.height ;
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.contentOffset = CGPointMake(0, tmpOffSetY);
            self.currentContentOffsetY = tmpOffSetY;
        }];
    }
}


- (void)keyboardWillHide:(NSNotification *)obj {
    if(_tableView.contentSize.height > self.view.bounds.size.height){
        _tableView.contentOffset = CGPointMake(0, _tableView.contentSize.height - _tableView.frame.size.height);
    }
    if(_tableView.contentSize.height <= self.view.bounds.size.height){
        _tableView.contentOffset = CGPointMake(0, self.oldContentOffsetY);
    }
}

- (void)keyboardFrameChanged:(NSNotification *)noti {
    CGRect keyboardFrame = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = [UIScreen mainScreen].bounds.size.height - keyboardFrame.origin.y;
    [self keyboardWillChangeToHeight:@(keyboardHeight)];
}

- (void)textViewDidChangeText:(NSNotification *)noti{
    self.btn2.enabled = self.textView.text.length > 0 && ![self isBlankString:self.textView.text];
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (void)keyboardWillChangeToHeight:(NSNumber *)height {
    CGFloat keyboardHeight = [height floatValue];
    __block CGRect inputViewFrame = _toobarView.frame;
    inputViewFrame.origin.y = self.view.frame.size.height - keyboardHeight - _toobarView.frame.size.height;
    self.keyboardHeight = keyboardHeight;
    _toobarView.frame = inputViewFrame;
}
- (BOOL)handMessageContent{
    self.textView.text = [self.textView.text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    self.textView.text = [self.textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    self.textView.text = [self.textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (self.textView.text.length == 0) {
        return NO;
    }
    ReplyReq *req = [[ReplyReq alloc]init];
    req.toId = self.infoModel.doctorId;
    req.fromId = self.infoModel.customerId;
    req.advisoryId = self.advisoryId;
    req.message = self.textView.text;
    [req request:^(NSURLSessionDataTask *task, id responseObject) {
        ;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
    Message *message1 = [[Message alloc]init];
    message1.isSelf = YES;
    message1.chatTime = [StringUtils timeChange:[StringUtils getCurrentSpTime]];
    message1.advisoryId = self.advisoryId;
    message1.fromId = self.infoModel.customerId;
    message1.toId = self.infoModel.doctorId;
    message1.content = self.textView.text;
    [_DataArray addObject:message1];
    [_tableView reloadData];
    self.textView.text = @"";
    CGFloat height = message1.frame.size.height + 55 + 30;
    [UIView animateWithDuration:0.15 animations:^{
        [_tableView setContentOffset:CGPointMake(0, self.currentContentOffsetY + height)];
    }completion:^(BOOL finished) {
        self.currentContentOffsetY = self.currentContentOffsetY + height;
    }];
    return YES;
}
#pragma mark - 单机窗口键盘隐藏
//说明：其实是选中到单元格了
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //直接调用隐藏键盘的方法即可
    [self.textView resignFirstResponder];
}

#pragma mark - 滑动窗口时，键盘隐藏
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //直接调用隐藏键盘的方法即可
    [self.textView resignFirstResponder];
}
#pragma mark -----------MessageCellDelegate
-(void)MessageCellDelegateOnclikeReseverButton:(MessageCell *)cell model:(Message *)model {
    ReserveViewController *resever = [[ReserveViewController alloc]init];
    resever.doctorId = model.toId;
    [self.navigationController pushViewController:resever animated:YES];
}
#pragma mark -------------SRWebSocket
- (void)connectWebSocket {
    self.webSocket.delegate = nil;
    self.webSocket = nil;
    NSString *urlString = @"http://www.msduorourou.com:9502";
    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    self.webSocket .delegate = self;
    
    [self.webSocket open];
    [self webSocketDidOpen:self.webSocket];
}

- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
    //    webSocket = newWebSocket;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [self connectWebSocket];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [self connectWebSocket];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    //    self.messagesTextView.text = [NSString stringWithFormat:@"%@\n%@", self.messagesTextView.text, message];
}

@end
