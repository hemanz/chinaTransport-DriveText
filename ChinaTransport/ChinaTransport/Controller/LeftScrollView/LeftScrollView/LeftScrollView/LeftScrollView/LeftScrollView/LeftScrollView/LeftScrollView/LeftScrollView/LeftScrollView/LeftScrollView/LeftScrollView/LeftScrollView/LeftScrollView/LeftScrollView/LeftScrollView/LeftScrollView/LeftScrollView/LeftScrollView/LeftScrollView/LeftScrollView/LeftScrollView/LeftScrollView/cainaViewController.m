//
//  cainaViewController.m
//  RadioPlayReal
//
//  Created by shuainan on 15/9/18.
//  Copyright (c) 2015年 shuainan. All rights reserved.
//

#import "cainaViewController.h"
#import "Define.h"
#import "WXApi.h"
#import "WXApiObject.h"

#import "AboutusViewController.h"

#import "FeedbackViewController.h"
@interface cainaViewController ()


@end

@implementation cainaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * imgviw=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, wid, heigh) ];
    imgviw.image = [UIImage imageNamed:@"image"];
    [self.view addSubview:imgviw];
    
    dataTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, wid, 250) style:UITableViewStylePlain];
    dataTableView.delegate = self; //
    //    fansTabView.bounces = NO;
    dataTableView.showsVerticalScrollIndicator = NO; //
    dataTableView.dataSource  =self; //
    dataTableView.backgroundColor = [UIColor clearColor];
    
    //        nowRoadTableView.bounces = NO; //上下拖动
    [self.view addSubview:dataTableView];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark － TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID;
    cellID =@"nowRoadTableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row== 0) {
        cell.textLabel.text = @"首页";
        cell.imageView.image = [UIImage imageNamed:@"home"];
        cell.textLabel.textColor = RGBACOLOR(0, 0, 0, 1);
  
//    } else if(indexPath.row== 1){
//        cell.textLabel.text = @"微信登陆";
//        cell.imageView.image = [UIImage imageNamed:@"微信"];
//        cell.textLabel.textColor = RGBACOLOR(0, 0, 0, 1);
    }else if(indexPath.row== 1){
        cell.textLabel.text = @"意见与建议";
        cell.imageView.image = [UIImage imageNamed:@"意见与建议"];

    }else if(indexPath.row== 2){
        cell.textLabel.text = @"求好评";
        cell.imageView.image = [UIImage imageNamed:@"求好评"];

    }else if(indexPath.row== 3){
        cell.textLabel.text = @"关于我们";
        cell.imageView.image = [UIImage imageNamed:@"关于我们"];
 
    }
    
    
    return cell;
}
//          返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        
//    }else  if(indexPath.row == ){
//        
//        
    }else  if(indexPath.row == 1){
        FeedbackViewController * abv = [[FeedbackViewController alloc]init];
        UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:abv];
        [self presentViewController:loginNav animated:YES completion:nil];
    }else  if(indexPath.row == 2){
        [self jumpToCommentArea];
    }else  if(indexPath.row == 3){
        AboutusViewController * abv = [[AboutusViewController alloc]init];
        UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:abv];
        [self presentViewController:loginNav animated:YES completion:nil];
        
        
    }
    //昵称修改

    
}

-(void) jumpToCommentArea {
    //    NSString* strLoc = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1015204941";
    NSString * strLoc =@"itms-apps://itunes.apple.com/app/id1015204941";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strLoc]];
}


//weixin

//微信登陆调用微信接口
//- (void)sendAuthRequest
//{
//    SendAuthReq* req = [[SendAuthReq alloc] init];
//    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
//    req.state = @"xxx";
//    
//    [WXApi sendAuthReq:req viewController:self delegate:self];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
