//
//  RoadStatusController.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/6.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "RoadStatusController.h"
#import "MJRefresh.h"
#import "CityTableViewController.h"
#import "RoadStatusmodel.h"
#import "RoadStatusCell.h"

@interface RoadStatusController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *bottomView;   //下面的大的View
    UIScrollView *scrView;  //大的scrollView
    UITableView *nowRoadTableView;  //实时路况的tableView
    UITableView *speedRoadTableView;  //高速公路的tableView
    UITableView *roadTrafficTableView; //公路交通的tableView
    NSMutableArray *nowRoadDataArray;  //实时路况的dataArray
    NSMutableArray *speedRoadDataArray;  //高速公路的dataArray
    NSMutableArray *roadTrafficDataArray;  //公路交通的dataArray
    UILabel *scrLabel; //滑动的Label
    BOOL isScroll;    //scroll的bool值
    NSString *sizeString;
//    MJRefreshHeader *headerFresh; //刷新的header
//    MJRefreshFooter *footerFresh; //刷新的footer
    NSString *cityNum;  //城市number
}

@property UILabel *scrLabel1;
@end

@implementation RoadStatusController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    speedRoadDataArray = [[NSMutableArray alloc] init];
    [self addTiTle:@"- 实 时 路 况 - "];
    [self rightItemwithtitle:@"北京市"];
    [self createUI];
    cityNum =@"110100";
    [self requestDataCityid:cityNum type:@"2"];
}
-(void)rightItemwithtitle:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setImage:[UIImage imageNamed:@"下箭头"] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR(51, 51, 51) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -38, 0, 0)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [btn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
}
#pragma mark - RequestData
-(void)requestDataCityid:(NSString *)cityid type:(NSString *)type{
    //    初始化
    nowRoadDataArray = [[NSMutableArray alloc] init];
    NSString *UrlString = [Url RoadCondition:cityid andType:type];
    NSLog(@"%@",UrlString);
    [Netmanager GetRequestWithUrlString:UrlString finished:^(id responseobj) {
        NSLog(@"%@",responseobj);
        NSArray *array = responseobj[@"list"];
        for (NSDictionary *subdic in array) {
            RoadStatusmodel *model =[[RoadStatusmodel alloc] init];
            model.pkid =subdic[@"pkid"];
            model.status =subdic[@"status"];
            model.content =subdic[@"content"];
            model.time = subdic[@"time"];
            if ([type isEqual:@"1"]) {
               model.type =@"路况";
            }else{
               model.type =@"高速";
            }
            [nowRoadDataArray addObject:model];
        }
        NSLog(@"nowRoadArray:%@",nowRoadDataArray);
        [nowRoadTableView reloadData];
    } failed:^(NSString *errorMsg) {
        NSLog(@"error:%@",errorMsg);
    }];
}
#pragma mark - UIload
-(void)createUI{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(go_cityName:) name:@"go_cityName" object:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
//               创建三个btn
    NSArray *arr = @[@"实时路况",@"高速公路",@"公路交通"];
    for (NSInteger i=0; i<arr.count; i++) {
        UIButton *roadButton =[MyControl createButtonWithType:UIButtonTypeCustom Frame:CGRectMake(i*wid/arr.count, 0, wid/arr.count, 35) title:arr[i] titleColor:RGBCOLOR(51, 51, 51) imageName:nil bgImageName:nil target:self method:@selector(roadButtonClick:)];
        [roadButton setTitleColor:RGBCOLOR(137, 86, 85) forState:UIControlStateSelected];
        roadButton.tag=201590611+i;
        [self.view addSubview:roadButton];
    }
//          滑动的label
    scrLabel = [[UILabel alloc] initWithFrame:CGRectMake(wid/2-60/2, 36, 60, 4)];
    scrLabel.backgroundColor = RGBCOLOR(137, 86, 85);
    scrLabel.layer.masksToBounds = YES;
    scrLabel.layer.cornerRadius =2;
    [self.view addSubview:scrLabel];
//             nowRoadTableView
    if (!nowRoadTableView) {
        nowRoadTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0,50, wid,heigh-64-45) style:UITableViewStylePlain];
        nowRoadTableView.delegate = self;
        //    fansTabView.bounces = NO;
        nowRoadTableView.separatorStyle = NO; // 分割线
        nowRoadTableView.showsVerticalScrollIndicator = NO;
        nowRoadTableView.dataSource  =self;
        nowRoadTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
//        [nowRoadTableView setHeader:headerFresh];
        [self.view addSubview:nowRoadTableView];
    }
            __weak __typeof(self) weakSelf = self;
//             设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
            nowRoadTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [weakSelf loadNewData];
            }];
        // 马上进入刷新状态
        [nowRoadTableView.header beginRefreshing];
//        __weak __typeof(self) weakSelf = self;
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//        speedRoadTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            [weakSelf loadMoreData];
//        }];
//     或
//        speedRoadTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:<#(id)#> refreshingAction:<#(SEL)#>]
//        [self.view addSubview:speedRoadTableView];
//    }
}
#pragma mark - Click事件
-(void)rightItemClick{
    
    UIButton *nowRoadbtn =(UIButton *)[self.view viewWithTag:201590611];
    NSString *postType;
    if (nowRoadbtn.state == UIControlStateSelected) {
        postType =[NSString stringWithFormat:@"%ld",nowRoadbtn.tag-201590610];
    }
    UIButton *speedbtn =(UIButton *)[self.view viewWithTag:201590612];
    if (speedbtn.state == UIControlStateSelected) {
        postType =[NSString stringWithFormat:@"%ld",speedbtn.tag-201590610];
    }
    CityTableViewController *cityVC = [[CityTableViewController alloc] init];
    cityVC.postType = postType;
    UINavigationController *nvc =[[UINavigationController alloc]initWithRootViewController:cityVC];
    [self presentViewController:nvc animated:YES completion:nil];
}
-(void)go_cityName:(NSNotification *)note{
    NSString *cityName =[[note userInfo] objectForKey:@"cityName"];
    NSString *postType =[[note userInfo] objectForKey:@"postType"];
    cityNum =[[note userInfo] objectForKey:@"cityNum"];
    [self rightItemwithtitle:cityName];
    [self requestDataCityid:cityNum type:postType];
}
//         点击btn切换界面
-(void)roadButtonClick:(UIButton *)btn{
    for (NSInteger i=0; i<3; i++) {
        UIButton *btn =(UIButton *)[self.view viewWithTag:201590611+i];
        btn.selected = NO;
    }
    btn.selected = YES;

    [UIView animateWithDuration:0.3 animations:^{
        CGPoint point = btn.frame.origin;
        //         label滑动代码
        scrLabel.frame = CGRectMake(point.x+wid/3/2-60/2, 33, 60, 4);

        //         点击Btn实现scrollView切换
        if (isScroll == NO) {
            scrView.contentOffset =CGPointMake((btn.tag-201590611)*wid, 0);
        }
    }];
    
    [self requestDataCityid:cityNum type:[NSString stringWithFormat:@"%ld",btn.tag-201590610]];
    
}
#pragma mark － TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return nowRoadDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID;
    cellID =@"nowRoadTableViewCellID";
    RoadStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[RoadStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    RoadStatusmodel *model =nowRoadDataArray[indexPath.row];
    cell.roadStatusmodel = model;
    
    cell.backgroundColor= [UIColor clearColor];
    return cell;
}
//          返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RoadStatusmodel *model =nowRoadDataArray[indexPath.row];
    return 61+[self getTextSize:model.content]+10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - fresh downmore
- (void)loadNewData
{
    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [speedRoadDataArray insertObject:@"1" atIndex:0];
//    }
    
//     2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//         刷新表格
        [nowRoadTableView reloadData];
        
//         拿到当前的下拉刷新控件，结束刷新状态
        [nowRoadTableView.header endRefreshing];
    });
}
//- (void)loadMoreData
//{
    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [speedRoadDataArray addObject:@"qweq"];
//    }
//    
//    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [speedRoadTableView reloadData];
//        
//        // 拿到当前的上拉刷新控件，结束刷新状态
//        [speedRoadTableView.footer endRefreshing];
////        [speedRoadTableView.footer noticeNoMoreData];
////        speedRoadTableView.footer.automaticallyChangeAlpha = YES;
//        // 设置了底部inset
//        speedRoadTableView.contentInset = UIEdgeInsetsMake(0, 0, -30, 0);
//        // 忽略掉底部inset
//        speedRoadTableView.footer.ignoredScrollViewContentInsetBottom = -30;
//    });
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//   根据字数判断size
-(CGFloat)getTextSize:(NSString *)string{
    CGSize size = CGSizeMake(wid-20,999);//LableWight标签宽度，固定的
    //计算实际frame大小，并将label的frame变成实际大小
    UIFont *font =[UIFont systemFontOfSize:18 weight:50];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
   CGRect rect =  [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
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
