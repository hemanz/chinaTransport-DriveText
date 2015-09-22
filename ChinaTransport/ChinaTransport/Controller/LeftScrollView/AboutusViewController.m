//
//  AboutusViewController.m
//  RadioPlayReal
//
//  Created by shuainan on 15/9/18.
//  Copyright (c) 2015年 shuainan. All rights reserved.
//

#import "AboutusViewController.h"

@interface AboutusViewController ()
@end

@implementation AboutusViewController

#pragma mark - view life cycle
- (void)viewDidLoad {
    [self addTiTle:@"- 关 于 我 们 -"];
    [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backClick) location:YES ];
    
    [self createUI];
    [super viewDidLoad];
}
-(void)createUI
{
    /**
     logo 的图片
     */
    UIImageView  *logoImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon120"]];
    logoImgView.frame=CGRectMake(wid/2-35, 80/wid*wid, 70, 70);
    [self.view addSubview:logoImgView];
    //    logo的版本信息
    UILabel * versionLabl=[[UILabel alloc]initWithFrame:CGRectMake(wid/2-50, 150/wid*wid, 100, 30)];
    versionLabl.text =[NSString stringWithFormat:@"%.1f",kCURRENT_APP_VERSION];
    versionLabl.textAlignment = NSTextAlignmentCenter;
    versionLabl.textColor = RGBACOLOR(29, 166, 192, 1);
    versionLabl.font = [UIFont boldSystemFontOfSize:15];
    
    [self.view addSubview:versionLabl];
    
    
    UILabel * enterpriseLabl=[[UILabel alloc]initWithFrame:CGRectMake(30, 60+150/wid*wid, wid-60, 30)];
    enterpriseLabl.text =@"国广通途(北京)传媒科技有限公司";
    enterpriseLabl.textAlignment = NSTextAlignmentCenter;
    enterpriseLabl.textColor = RGBACOLOR(29, 166, 192, 1);
    enterpriseLabl.font = [UIFont boldSystemFontOfSize:15];
    
    [self.view addSubview:enterpriseLabl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -click
//返回按钮的启动
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

