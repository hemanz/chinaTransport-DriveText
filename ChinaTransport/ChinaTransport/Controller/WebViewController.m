//
//  WebViewController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/16.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
{
    UIWebView *webView;
    
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backClick) location:YES];
    [self WebView];
}
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - UIload
-(void)WebView{
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, wid, heigh)];
    NSURL *url =[NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate =self;
    //     加着句话是为了让webView能播放声音
    webView.mediaPlaybackRequiresUserAction=NO;
    [self.view addSubview:webView];
    
    
}
#pragma mark - WebViewDelegate

-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"start");
   
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finished");

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"failed");
    [self alertView:@"加载失败,请重试" cancle:@"确定"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
