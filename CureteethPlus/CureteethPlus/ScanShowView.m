//
//  ScanShowView.m
//  最新扫描Demo
//
//  Created by 孙云 on 16/1/4.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "ScanShowView.h"

@implementation ScanShowView
+(instancetype)createView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ScanShowView" owner:nil options:nil] lastObject];
}
-(void)awakeFromNib
{
    //让文本框不能编辑
    self.resultText.editable = NO;
}
/**
 *  数据接收
 *
 *  @param message <#message description#>
 */
-(void)reMessage:(NSString *)message
{
    self.dataStr = message;
    
    //截取获取的字符串
    NSString *headerStr = [self.dataStr substringWithRange:NSMakeRange(0, 4)];
    if ([message isEqualToString:@"获取失败"]) {
        self.scanResult.text = @"错误提醒";
        self.resultText.textAlignment = NSTextAlignmentCenter;
        self.resultText.text = @"请选择正确的二维码图片";
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.okBtn setTitle:@"确定" forState:UIControlStateNormal];
    }else if ([headerStr isEqualToString:@"http"]) {
        self.scanResult.text = @"温馨提醒";
        self.resultText.textAlignment = NSTextAlignmentCenter;
        self.resultText.text = [NSString stringWithFormat:@"可能存在风险，是否打开链接?\n %@",self.dataStr];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.okBtn setTitle:@"打开链接" forState:UIControlStateNormal];
    }else
    {
        self.scanResult.text = @"扫描结果";
        //字符的设置
        NSString *resultScan = [NSString stringWithFormat:@"扫描到以下内容\n %@",self.dataStr];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:resultScan];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 7)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.600 alpha:1.000] range:NSMakeRange(0, string.length)];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentCenter;//设置对齐方式
        [string addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, string.length)];
        
        self.resultText.attributedText = string;
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.okBtn setTitle:@"复制内容" forState:UIControlStateNormal];
    }
    
}
/**
 *  取消
 */
- (IBAction)clickCancel {
    if ([self.delegate respondsToSelector:@selector(cancelThing:)]) {
        [self.delegate cancelThing:self.scanResult.text];
    }
}
/**
 *  确定
 */
- (IBAction)clickOk {
    if ([self.delegate respondsToSelector:@selector(okThing:context:)]) {
        [self.delegate okThing:self.scanResult.text context:self.dataStr];
    }
}
@end
