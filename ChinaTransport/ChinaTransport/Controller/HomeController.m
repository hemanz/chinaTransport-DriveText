//
//  HomeController.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/1.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "HomeController.h"
#import "PPRevealSideViewController.h"
#import "LeftScrollController.h"
#import "RoadStatusController.h"
#import "KuaidiController.h"
#import "HomeImageModel.h"
#import "UIImageView+WebCache.h"
#import "TrainController.h"
#import "JiaoguanjuDailController.h"
#import "ChaWeizhangController.h"
#import "WebViewController.h"
#import "TransprotHeadlineViewController.h"
#import "DrivingHomeViewController.h"
#import "UIToast.h"

#define kjueduiUrl  @"0701"
#define kxiangduiUrl  @"0702"

@interface HomeController ()
{
    UIScrollView *botScrollView;
    NSMutableArray *picArray;
}
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    picArray = [[NSMutableArray alloc] init];
    
    [self createNavbar];
    [self createUI];
    [self RequestData];
}
//     导航条
-(void)createNavbar {
    [self addimage:nil title:@"设置" selector:@selector(MineItem) location:YES];
    [self addTiTle:@"- 首 页 -"];
}
#pragma mark - requestData
-(void)RequestData{
    NSString *urlString = [Url mainTimeImageView];
    [Netmanager GetRequestWithUrlString:urlString finished:^(id responseobj) {
        NSArray *array = responseobj[@"list"];
        for (NSDictionary *subdic in array) {
            HomeImageModel *model = [[HomeImageModel alloc] init];
            model.begin =[self judgeDicEmpty:subdic str:@"begin"];
            model.des =[self judgeDicEmpty:subdic str:@"des"];
            model.end =[self judgeDicEmpty:subdic str:@"end"];
            model.img = [self judgeDicEmpty:subdic str:@"img"];
            model.status =[self judgeDicEmpty:subdic str:@"status"];
            model.type =[self judgeDicEmpty:subdic str:@"type"];
            model.url =[self judgeDicEmpty:subdic str:@"url"];
            [picArray addObject:model];
        }
        [self createPic];
        NSLog(@"picArray:%@",picArray);
    } failed:^(NSString *errorMsg) {
        
    }];
    
}
#pragma mark - UIload
-(void)createPic{
//           上面的View
//           轮播图
    NSMutableArray*array = [NSMutableArray arrayWithCapacity:1];
    for (NSInteger i=0; i<4; i++) {
        HomeImageModel *model =picArray[i];
        UIImageView *picImgView =[[UIImageView alloc] initWithFrame:CGRectMake(i*wid, 0,wid, 155)];
        picImgView.userInteractionEnabled = YES;
//        picImgView.contentMode=UIViewContentModeScaleToFill;
        picImgView.tag =1990+i;
        if (picArray.count>0) {
            NSString *url =[Url GetImageWithUrl:model.img];
            [picImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"胡歌"]];

        }else{
             picImgView.image = [UIImage imageNamed:@"胡歌"];
        }
        //               广告Title
//        UILabel *titleLabel = [MyControl createLabelWithFrame:CGRectMake(12, 145-20, wid-40, 20) text:model.des font:15 textcolor:[UIColor whiteColor] textAlignment:0 backgroundColor:[UIColor clearColor]];
//        [picImgView addSubview:titleLabel];
        [array addObject:picImgView];
    }
    //                小白点
    UIPageControl *pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(wid-70, 140, 60, 10)];
    pagecontrol.numberOfPages = 4;
    pagecontrol.pageIndicatorTintColor =[UIColor lightGrayColor];
    pagecontrol.currentPageIndicatorTintColor = [UIColor whiteColor];
    pagecontrol.tag = 600;
    
    self.mainScorllView = [[CycleScrollView alloc]  initWithFrame:CGRectMake(0, 0, wid, 155) animationDuration:4];
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        if (pageIndex ==0) {
            pagecontrol.currentPage = 4;
            
        }else{
            pagecontrol.currentPage = pageIndex-1;
            
        }
        return array[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return 4;
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        HomeImageModel *model = picArray[pageIndex];
        WebViewController *webVC = [[WebViewController alloc] init];
        if ([model.type isEqualToString:kjueduiUrl]) {
            webVC.urlString = model.url;
            UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:webVC];
            nav.hidesBottomBarWhenPushed =YES;

            [self presentViewController:nav animated:YES completion:nil];
        }
        if ([model.type isEqualToString:kxiangduiUrl]) {
            webVC.urlString =[kHostAddr stringByAppendingString:model.url];
            UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:webVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
    };
    [botScrollView addSubview:self.mainScorllView];
    [botScrollView addSubview:pagecontrol];
}
-(void)createUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    botScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, wid, heigh-64)];
    botScrollView.backgroundColor= RGBCOLOR(211, 211, 211);
    botScrollView.contentSize = CGSizeMake(0, (wid-66)/4+wid/3*2+384-125);
    botScrollView.showsVerticalScrollIndicator = NO;
    botScrollView.bounces = NO;
    [self.view addSubview:botScrollView];
//       中间的View
    UIView *fourView =[MyControl createUIViewWithFrame:CGRectMake(0, 155, wid, (wid-24-14*3)/4+30+30) color:[UIColor whiteColor]];
    [botScrollView addSubview:fourView];
     NSArray *fourArray =@[@"交通头条",@"查违章",@"路况",@"交通电台"];
    NSArray *fourTitleArray =@[@"交通头条",@"违章查询",@"实时路况",@"交通电台"];
    for (NSInteger i=0; i<fourArray.count; i++) {
        UIButton *fourButton =[MyControl createButtonWithType:UIButtonTypeCustom Frame:CGRectMake(12+((wid-24-14*3)/4+14)*i, 155+15, (wid-24-14*3)/4, (wid-24-14*3)/4) title:nil titleColor:nil imageName:fourArray[i] bgImageName:nil target:self method:@selector(fourButtonClick:)];
        fourButton.tag =2015090715+i;
        UILabel *fourLabel =[MyControl createLabelWithFrame:CGRectMake(12+((wid-24-14*3)/4+14)*i, 155+15+(wid-24-14*3)/4+10, (wid-24-14*3)/4, 20) text:fourTitleArray[i] font:15 textcolor:RGBCOLOR(51, 51, 51) textAlignment:1 backgroundColor:nil];
        [botScrollView addSubview:fourButton];
        [botScrollView addSubview:fourLabel];
    }
//       下面的View
    UIView *titleView =[MyControl createUIViewWithFrame:CGRectMake(0, 155+15+(wid-24-14*3)/4+45, wid, 15+10+20) color:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundColor"]]];
    UILabel *titleLabel = [MyControl createLabelWithFrame:CGRectMake(15, 15, 200, 20) text:@"实用工具" font:18 textcolor:RGBCOLOR(51, 51, 51) textAlignment:0 backgroundColor:[UIColor clearColor]];
    [titleView addSubview:titleLabel];
    [botScrollView addSubview:titleView];
    
    NSArray *gongjuTitleArray = @[@"火车票查询",@"驾考试题",@"快递查询",@"驾驶证查询",@"交管局热线",@"航班查询"];
    NSArray *gongjuImageArray = @[@"火车",@"驾考试题",@"快递",@"驾驶证查询",@"交管局",@"飞机"];
    for (NSInteger i=0; i<2; i++) {
        for (NSInteger j=0; j<3; j++) {
            UIButton *gongjuButton = [MyControl createButtonWithType:UIButtonTypeCustom Frame:CGRectMake(j*wid/3,CGRectGetMaxY(titleView.frame)+wid/3*i+0.5, wid/3-0.5, wid/3-0.5) title:gongjuTitleArray[3*i+j] titleColor:RGBCOLOR(51, 51, 51) imageName:gongjuImageArray[3*i+j] bgImageName:nil target:self method:@selector(gongjuButton:)];
            [gongjuButton setImageEdgeInsets:UIEdgeInsetsMake(-20, 22.5, 0, 10)];
            if (wid>320&&wid<400) {
                 [gongjuButton setImageEdgeInsets:UIEdgeInsetsMake(-20, 30.5, 0, 11)];
            }
            if (wid>400) {
                 [gongjuButton setImageEdgeInsets:UIEdgeInsetsMake(-20, 41.5, 0, 12)];
            }
            [gongjuButton setTitleEdgeInsets:UIEdgeInsetsMake(3, -45, -60, 0)];
            gongjuButton.titleLabel.font = [UIFont systemFontOfSize:13];
            gongjuButton.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundColor"]];
            gongjuButton.tag =2015090815+3*i+j;
            [botScrollView addSubview:gongjuButton];
        }
    }
////      地图
//    UIImageView *mapImgView = [MyControl createImageViewFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame)+2*wid/3, wid, 125) imageName:@"地图"];
//    [botScrollView addSubview:mapImgView];
}
#pragma mark - DataRequest

#pragma mark - Click事件
-(void)MineItem{
    NSLog(@"MineLeftItem");
//    LeftScrollController *leftScrollVC =[[LeftScrollController alloc] init];
//    [self.revealSideViewController pushViewController:leftScrollVC onDirection:PPRevealSideDirectionLeft animated:YES];
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

-(void)fourButtonClick:(UIButton *)btn{
    if (btn.tag == 2015090717) {
        RoadStatusController *roadStatusVC =[[RoadStatusController alloc] init];
        [self.navigationController pushViewController:roadStatusVC animated:YES];

    }else if (btn.tag == 2015090716) {
        ChaWeizhangController *chaweizhangVC =[[ChaWeizhangController alloc] init];
        [self.navigationController pushViewController:chaweizhangVC animated:YES];
        
    }else if (btn.tag == 2015090715){
        TransprotHeadlineViewController *tvc = [[TransprotHeadlineViewController alloc] init];
        [self.navigationController pushViewController:tvc animated:YES];
    }else{
        [self unGetFunction];
    }
    
}
-(void)gongjuButton:(UIButton *)btn{
    TrainController *trainVC =[[TrainController alloc] init];
     KuaidiController *kuaidiVC = [[KuaidiController alloc] init];
//    JiaoguanjuDailController *dailVC = [[JiaoguanjuDailController alloc] init];
    DrivingHomeViewController *drivingVC=[[DrivingHomeViewController alloc]init];
    switch (btn.tag) {
        case 2015090815:
            [self.navigationController pushViewController:trainVC animated:YES];
            break;
        case 2015090816:
            [self.navigationController pushViewController:drivingVC animated:YES];
            break;
        case 2015090817:
            [self.navigationController pushViewController:kuaidiVC animated:YES];
            break;
        case 2015090818:
            [self unGetFunction];
            break;
        case 2015090819:
//            [self.navigationController pushViewController:dailVC animated:YES];
            [self unGetFunction];
            break;
       
        case 2015090820:
            [self unGetFunction];
            break;
       

        default:
            break;
    }
}
-(void)unGetFunction{
    UIToast *toast = [[UIToast alloc] init];
    [toast show:@"该功能正在开发中,敬请期待!"];
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
