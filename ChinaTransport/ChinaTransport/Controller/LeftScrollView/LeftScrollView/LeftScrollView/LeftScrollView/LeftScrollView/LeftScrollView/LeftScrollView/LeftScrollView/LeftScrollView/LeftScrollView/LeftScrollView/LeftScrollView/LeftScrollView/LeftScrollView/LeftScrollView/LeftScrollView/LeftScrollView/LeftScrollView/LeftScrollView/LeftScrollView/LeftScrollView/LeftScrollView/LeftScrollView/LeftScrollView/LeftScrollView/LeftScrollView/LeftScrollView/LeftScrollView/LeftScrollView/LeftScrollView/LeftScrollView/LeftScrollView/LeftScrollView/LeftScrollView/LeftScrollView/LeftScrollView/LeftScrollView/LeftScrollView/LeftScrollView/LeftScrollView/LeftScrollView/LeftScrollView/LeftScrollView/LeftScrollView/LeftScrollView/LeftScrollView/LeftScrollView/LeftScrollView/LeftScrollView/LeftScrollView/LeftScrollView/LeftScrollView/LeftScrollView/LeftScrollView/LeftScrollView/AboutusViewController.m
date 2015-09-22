//
//  AboutusViewController.m
//  RadioPlayReal
//
//  Created by shuainan on 15/9/18.
//  Copyright (c) 2015年 shuainan. All rights reserved.
//

#import "AboutusViewController.h"
#import "AboutUsViewController.h"
#import "Define.h"
//#import "FeedbackViewController.h"
@interface AboutusViewController ()
{
    /**
     *  关于我们 页面的TableView
     */
    UITableView *_dataTableView;
    /**
     *  响应的参数
     */
    NSString * _resCode;
    /**
     *  app版本是不是最新版
     */
    NSString * _version;
    /**
     *  响应的消息
     */
    NSString * _resMsg;
    /**
     *  新版本
     */
    NSString * _newVersion;
    /**
     *服务端最新app下载地址
     */
    NSString * _downloadUrl;
}
@end

@implementation AboutusViewController

#pragma mark - view life cycle
- (void)viewDidLoad {
    
    /**
     *   页面nav bar按钮
     */
    [self addTiTle:@"关于我们"];
    [self addimage:[UIImage imageNamed:@"back"] title:nil selector:@selector(backClick) location:YES ];
    
    
    [self createUI];
    
    /**
     *  tableview的相关的定义
     */
//    _dataTableView.backgroundColor=RGBACOLOR(233, 245, 248, 1);
//    
//    _dataTableView.bounces = YES;
//    _dataTableView.scrollEnabled = NO;//设置tableview 不能滚动
    
    /**
     *  是否是最新版本
     */
    //    _version = [self updateVersion];
    [super viewDidLoad];
    
    /**
     *  tableview的相关的定义
     */
//    _dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180/wid*wid, wid, heigh)];
//    [_dataTableView setDelegate:self];
//    [_dataTableView setDataSource:self];
//    [self.view addSubview:_dataTableView];
//    
//    _dataTableView.backgroundColor=RGBACOLOR(233, 245, 248, 1);
//    self.view.backgroundColor=RGBACOLOR(233, 245, 248, 1);
//    _dataTableView.scrollEnabled = NO;
}
-(void)createUI
{
    /**
     logo 的图片
     */
    UIImageView  *logoImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
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

#pragma mark - Tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 19;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

/**
 *    tableview的headerview的背景颜色
 */
-(void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        UIView* content = castView.contentView;
        UIColor* color = RGBACOLOR(233, 245, 248, 1);; // substitute your color here
        content.backgroundColor = color;
    }
}

//       ROW的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 44;
    }
    return 44;
}

//       对cell的内容进行定义
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"AboutCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    NSMutableDictionary *sectionDictionary = self.dataSource[indexPath.section][indexPath.row];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
//    NSString *title = [sectionDictionary valueForKey:@"title"];
//    if (title) {
//        cell.textLabel.text = title;
//    }
    
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

//点击效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
//    if(indexPath.row == 0){
//        NSLog(@"意见反馈");
//        FeedbackViewController *feedbackVC = [[FeedbackViewController alloc]init];
//        [self.navigationController pushViewController:feedbackVC animated:YES];
//    } else{
//        NSLog(@"给软件评分");
//        [self jumpToCommentArea];
//    }
    
}
#pragma mark - self method
//对产品评价阿
-(void) jumpToCommentArea {
    //    NSString* strLoc = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1015204941";
    NSString * strLoc =@"itms-apps://itunes.apple.com/app/id1015204941";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strLoc]];
}

#pragma mark - button click or gesture event
//返回按钮的启动
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

