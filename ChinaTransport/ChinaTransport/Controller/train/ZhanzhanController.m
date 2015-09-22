//
//  ZhanzhanController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/15.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "ZhanzhanController.h"
#import "TrainResultFirstCell.h"
#import "ResultController.h"
#import "masonry.h"
#import "TrainModel.h"

@interface ZhanzhanController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *zhantableView;
    NSMutableArray *dataArray;
    UILabel *timeLabel;
}
@end

@implementation ZhanzhanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray =[[NSMutableArray alloc] init];
    [self addTiTle:[NSString stringWithFormat:@"%@-%@ ",self.from_sta_name,self.to_sta_name]];
    [self requestData];
    [self createUI];
    
}
#pragma mark - RequestData
-(void)requestData{
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeNone];
    NSArray *postDateStr = [self.zhanDate componentsSeparatedByString:@" "];
    NSString *dateStr = postDateStr[0];
    NSString *urlString =[Url queryTrainByFromTo:self.from_sta_code toStation:self.to_sta_code date:dateStr];
    
    [Netmanager GetRequestWithUrlString:urlString finished:^(id responseobj) {
        NSArray *arr =responseobj[@"data"];
        for (NSDictionary *dic in arr) {
            NSDictionary *subdic =dic[@"queryLeftNewDTO"];
            TrainModel *model =[[TrainModel alloc] init];
            model.start_time =[self judgeDicEmpty:subdic str:@"start_time"];
            model.arrive_time =[self judgeDicEmpty:subdic str:@"arrive_time"];
            model.from_station_name =[self judgeDicEmpty:subdic str:@"from_station_name"];
            model.to_station_name =[self judgeDicEmpty:subdic str:@"to_station_name"];
            model.start_station_name =[self judgeDicEmpty:subdic str:@"start_station_name"];
            model.end_station_name =[self judgeDicEmpty:subdic str:@"end_station_name"];
            model.station_train_code =[self judgeDicEmpty:subdic str:@"station_train_code"];
            model.lishi =[self judgeDicEmpty:subdic str:@"lishi"];
            model.start_train_date =[self judgeDicEmpty:subdic str:@"start_train_date"];
            
            model.canWebBuy =[self judgeDicEmpty:subdic str:@"canWebBuy"];
            model.swz_num = [self judgeDicEmpty:subdic str:@"swz_num"];
            model.zy_num = [self judgeDicEmpty:subdic str:@"zy_num"];
            model.ze_num = [self judgeDicEmpty:subdic str:@"ze_num"];
            model.yz_num = [self judgeDicEmpty:subdic str:@"yz_num"];
            model.yw_num = [self judgeDicEmpty:subdic str:@"yw_num"];
            model.wz_num = [self judgeDicEmpty:subdic str:@"wz_num"];
            model.tz_num = [self judgeDicEmpty:subdic str:@"tz_num"];
            model.rz_num = [self judgeDicEmpty:subdic str:@"rz_num"];
            model.rw_num = [self judgeDicEmpty:subdic str:@"rw_num"];
            model.qt_num = [self judgeDicEmpty:subdic str:@"qt_num"];
            model.gr_num = [self judgeDicEmpty:subdic str:@"gr_num"];
            [dataArray addObject:model];
        }
        [self createTableView];
        [zhantableView reloadData];

        
    } failed:^(NSString *errorMsg) {
        NSLog(@"error:%@",errorMsg);
    }];
    //    [SVProgressHUD dismiss];
    
}

-(void)createUI{
    timeLabel =[MyControl createLabelWithtext:self.zhanDate font:15 textcolor:RGBCOLOR(15, 141, 156) backgroundColor:nil];
    [self.view addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).with.offset(15);
    }];
}
-(void)createTableView{
    if (dataArray.count>0) {
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        zhantableView = [[UITableView alloc] init];
        zhantableView.delegate =self;
        zhantableView.dataSource =self;
        zhantableView.separatorStyle = NO;
        zhantableView.backgroundColor = [UIColor clearColor];
        zhantableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:zhantableView];
        [zhantableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(timeLabel.mas_bottom).with.offset(5);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }else {
        [SVProgressHUD showErrorWithStatus:@"加载失败 请重试"];
        UIView *noneView= [[UIView alloc] initWithFrame:CGRectMake(0, 71, wid, heigh-64-71)];
        [self.view addSubview:noneView];
        UILabel *showLabel =[MyControl createLabelWithFrame:CGRectMake(10, (heigh-64-71)/2-20, wid-20, 40) text:@"没有查到哎，请再试一次" font:18 textcolor:RGBCOLOR(51, 51, 51) textAlignment:1 backgroundColor:[UIColor whiteColor]];
        [noneView addSubview:showLabel];
        
        //        UIToast *toast =[[UIToast alloc] init];
        //        [toast show:@"没有查到哎，请再试一次"];
        
        
    }

}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID;
    cellID = @"cellID";
    TrainResultFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[TrainResultFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];

    TrainModel *model =dataArray[indexPath.row];
    cell.trainModel=model;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TrainModel *model =dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    ResultController *resultVC =[[ResultController alloc] init];
    resultVC.model = model;
    
    [self.navigationController pushViewController:resultVC animated:YES];
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
