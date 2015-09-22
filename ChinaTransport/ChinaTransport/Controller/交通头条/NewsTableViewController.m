//
//  NewsTableViewController.m
//  ChinaTransport
//
//  Created by 张鹤楠 on 15/9/8.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "NewsTableViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "Netmanager.h"
#import "THeadLineNewsModel.h"
#import "HeadLineNewsCell.h"
#import "UIImageView+WebCache.h"
#import "Url.h"
#import "NewsWebView.h"



@interface NewsTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *newsTableView;
    NSMutableArray *scrollArray;
    THeadLineNewsModel *tempModel;
    UIPageControl *pagecontrol;

}

@property(nonatomic,strong) NSMutableArray *arrayList;
@property(nonatomic,assign)BOOL update;

@end

@implementation NewsTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    //    NSLog(@"bbbb");
    if (self.update == YES) {
//        [self.tableView header];
        self.update = NO;
    }
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"contentStart" object:nil]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wid, heigh)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.view addSubview:self.tableView];
    
//    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.footer beginRefreshing];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, wid, 150)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(wid,0);
    scrollView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = scrollView;
    scrollArray = [[NSMutableArray alloc] init];
    
    self.update = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - /************************* 刷新数据 ***************************/
// ------下拉刷新
- (void)loadData
{
    // http://c.m.163.com//nc/article/headline/T1348647853363/0-30.html
    NSString *allUrlstring = [Url GetTransportHeadLineURLWithPage:0 PageSize:@"10" ContentType:self.urlString];
    [self loadDataForType:1 withURL:allUrlstring];
}

// ------上拉加载
- (void)loadMoreData
{
    NSString *allUrlstring = [Url GetTransportHeadLineURLWithPage:(self.arrayList.count - self.arrayList.count%10) PageSize:@"5" ContentType:self.urlString];

    [self loadDataForType:2 withURL:allUrlstring];
}

- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring{

    [Netmanager GetRequestWithUrlString:allUrlstring finished:^(NSDictionary *responseObj){
        NSString *key = [responseObj.keyEnumerator nextObject];
        NSArray *temArray = responseObj[key];

        NSMutableArray *arrayM = [THeadLineNewsModel objectArrayWithKeyValuesArray:temArray];
        NSLog(@"dd:%@",arrayM);
        if (type == 1) {
            for (NSInteger i=0; i<[arrayM count]; i++) {
                tempModel = arrayM[i];
                if ([tempModel.flag isEqualToString:@"0501"]) {
                    [scrollArray addObject:tempModel];
                }
                
            }
            NSLog(@"scrollview:%@",scrollArray);
            self.arrayList = arrayM;
            if(!self.arrayList.count==0){
                [self createpic];
            }
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
        }else if(type == 2){
            [self.arrayList addObjectsFromArray:arrayM];
            
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
        }

        
        
    } failed:^(NSString *error){
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.arrayList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    THeadLineNewsModel *newsModel = self.arrayList[indexPath.row];
    return [HeadLineNewsCell heighForRow:newsModel];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    THeadLineNewsModel *newsModel = self.arrayList[indexPath.row];
    HeadLineNewsCell *cell = [[HeadLineNewsCell alloc] init];
    NSInteger reUseId = [HeadLineNewsCell idForRow:newsModel];
    cell = [tableView dequeueReusableCellWithIdentifier:@"textNewsCell"];

    if (cell == nil){
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"testCell" owner:self options:nil];
        cell = (HeadLineNewsCell *)[nibArray objectAtIndex:reUseId];
    
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.newsModel = newsModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    THeadLineNewsModel *newsModel = self.arrayList[indexPath.row];
    NewsWebView *webView = [[NewsWebView alloc] init];
    webView.url = newsModel.htmlurl;
    [self.navigationController pushViewController:webView animated:YES];
}

-(void)createpic{
    NSMutableArray*array = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i=0; i<scrollArray.count; i++) {
        THeadLineNewsModel *model =scrollArray[i];
        UIImageView *picImgView =[[UIImageView alloc] initWithFrame:CGRectMake(i*wid, 0,wid, 150)];
        UILabel *scrollLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 125, wid, 20)];
        [scrollLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        scrollLable.textColor = [UIColor whiteColor];
        scrollLable.text = model.title;
        picImgView.userInteractionEnabled = YES;
        picImgView.tag =1990+i;
        [picImgView setImage:[UIImage imageNamed:@"definePicture1.png"]];
        NSLog(@"model.litpic[0]:%@",model.litpic[0]);
        NSString *url = model.litpic[0];
        [picImgView sd_setImageWithURL:[NSURL URLWithString:url]placeholderImage:[UIImage imageNamed:@"definePicture2"]];
        [array addObject:picImgView];
        [picImgView addSubview:scrollLable];
        
    }
    //       小白点
    pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(2*wid-80, 88+28, 60, 10)];
    pagecontrol.numberOfPages = scrollArray.count;
    pagecontrol.pageIndicatorTintColor =[UIColor lightGrayColor];
    pagecontrol.currentPageIndicatorTintColor = [UIColor whiteColor];
    pagecontrol.tag = 600;
    
//    self.mainScorllView = [[CycleScrollView alloc]  initWithFrame:CGRectMake(wid, 10, wid, 120) animationDuration:4];
        self.mainScorllView = [[CycleScrollView alloc]  initWithFrame:CGRectMake(0, 0, wid, 150) animationDuration:4];

    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        if (pageIndex ==0) {
            pagecontrol.currentPage = scrollArray.count;
            
        }else{
            pagecontrol.currentPage = pageIndex-1;
            
        }
        return array[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return scrollArray.count;
    };
    //         点击事件
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        THeadLineNewsModel *model =scrollArray[pageIndex];
        NewsWebView *nwVC = [[NewsWebView alloc] init];
        nwVC.url = model.htmlurl;
        [self.navigationController pushViewController:nwVC animated:YES];
//        PicModel *model =PicArray[pageIndex];
//        RadPicTapController *radPicTapVC = [[RadPicTapController alloc] init];
        
        
        
    };
    [self.tableView.tableHeaderView addSubview:self.mainScorllView];
    [self.tableView.tableHeaderView addSubview:pagecontrol];
}

@end

