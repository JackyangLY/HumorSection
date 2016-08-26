//
//  LYDetailWEBViewController.m
//  HumorSection
//
//  Created by 洋洋 on 16/8/12.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYDetailWEBViewController.h"

@interface LYDetailWEBViewController ()<UIWebViewDelegate>

@end

@implementation LYDetailWEBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
 
    UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webview];
    webview.delegate = self;
    NSURL *url = [NSURL URLWithString:self.StrURL];
       NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    [webview loadRequest:requset];
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonW = LYSCREEN_WIDTH *0.09;
    CGFloat buttonY = LYSCREEN_HEIGHT -buttonW-8;
    button.frame = CGRectMake(8, buttonY, buttonW, buttonW);
    [self.view addSubview:button];
    [button setImage:[UIImage imageNamed:@"主页org64x64"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ClickBtnAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)ClickBtnAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIWebViewDelegate
/** 开始加载 */
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('container')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('icon_0').style.display = 'none'"];
}
/** 已经完成加载 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
/** 加载失败 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@", error);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end
