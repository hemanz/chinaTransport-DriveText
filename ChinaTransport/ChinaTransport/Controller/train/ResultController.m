//
//  ResultController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/15.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "ResultController.h"
#import "masonry.h"
#import "TrainQujianCell.h"
#import "TraunResultSecCell.h"
#import "TrainPriceModel.h"

@interface ResultController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *trainResultTableView;
    NSMutableArray *priceDataArray;
    NSMutableArray *QujianDataArray;

}
@end

@implementation ResultController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    priceDataArray = [[NSMutableArray alloc] init];
    QujianDataArray =[[NSMutableArray alloc] init];
    [self addTiTle:[NSString stringWithFormat:@"- %@ -",self.model.station_train_code]];
    [self createUI];
    [self requestDataPrice];
    [self requestDataQujian];
}
//   票价数据
-(void)requestDataPrice{
    
    
    NSArray *sitTypeNumArray =@[self.model.swz_num,self.model.zy_num,self.model.ze_num,self.model.yz_num,self.model.yw_num,self.model.wz_num,self.model.tz_num,self.model.rz_num,self.model.rw_num,self.model.qt_num,self.model.gr_num];
     NSArray *sitTypeArray =@[@"swz_num",@"zy_num",@"ze_num",@"yz_num",@"yw_num",@"wz_num",@"tz_num",@"rz_num",@"rw_num",@"qt_num",@"gr_num"];
    for (NSInteger i=0; i<11; i++) {
        TrainPriceModel *model = [[TrainPriceModel alloc] init];
        if (![sitTypeNumArray[i] isEqualToString:@"--"]) {
            model.sitNum =sitTypeNumArray[i];
            model.sitType = sitTypeArray[i];
            [priceDataArray addObject:model];
        }
    }
    NSLog(@"priceDataArray:%@",priceDataArray);
//    model.sitLevel =@"二等座";
//    model.price = @"￥234";
//    model.num = @"112张";
//    [priceDataArray addObject:model];
}
//   区间数据
-(void)requestDataQujian{
        NSString *checi =self.model.station_train_code;
        NSString *startDate =self.model.start_train_date;
        NSLog(@"startDate:%@",startDate);
        NSString *urlString =[Url queryTrainByCheci:checi date:self.model.start_train_date];
        [Netmanager GetRequestWithUrlString:urlString finished:^(id responseobj) {
            NSArray *arr =responseobj[@"trainQujianList"];
            for (NSDictionary *subdic  in arr) {
                TrainQujianModel *model = [[TrainQujianModel alloc] init];
                model.arrive_time =[self judgeDicEmpty:subdic str:@"arrive_time"];
                model.start_time =[self judgeDicEmpty:subdic str:@"start_time"];
                model.station_name =[self judgeDicEmpty:subdic str:@"station_name"];
                model.station_no =[self judgeDicEmpty:subdic str:@"station_no"];
                model.stopover_time =[self judgeDicEmpty:subdic str:@"stopover_time"];
                model.train_no =[self judgeDicEmpty:subdic str:@"train_no"];
                model.id =[self judgeDicEmpty:subdic str:@"id"];
                model.cellType=TrainQujianCellTypeUnselected;  //可选状态
                [QujianDataArray addObject:model];
            }
            
            TrainQujianModel *model = [[TrainQujianModel alloc] init];
            model.arrive_time=@"到达";
            model.start_time=@"发车";
            model.station_name=@"站名";
            model.station_no=@"站次";
            model.stopover_time=@"停留";
            model.cellType=TrainQujianCellTypeFirstRow; //第一行
            [QujianDataArray insertObject:model atIndex:0];
            
            self.model.zhanzhanArray = QujianDataArray;
            NSLog(@"%@",self.model.zhanzhanArray);
            [trainResultTableView reloadData];
            
            
        } failed:^(NSString *errorMsg) {
            NSLog(@"error:%@",errorMsg);
        }];
}
#pragma mark - UIload
-(void)createUI{
//    上面的车次信息
    //左边
    UILabel  *startStationLabel = [MyControl createLabelWithtext:self.model.from_station_name font:17 textcolor:RGBCOLOR(51, 51, 51) backgroundColor:nil];
    startStationLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:startStationLabel];
    UILabel  *startTimeLabel = [MyControl createLabelWithtext:self.model.start_time font:25 textcolor:RGBCOLOR(15, 141, 156) backgroundColor:nil];
    startTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:startTimeLabel];
    UILabel  *startDayLabel = [MyControl createLabelWithtext:self.model.start_train_date font:15 textcolor:RGBCOLOR(51, 51, 51) backgroundColor:nil];
    startDayLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:startDayLabel];
    //中间
    UIImageView *getImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"箭头"]];
    [self.view addSubview:getImageView];
    UILabel *typelabel = [MyControl createLabelWithtext:self.model.station_train_code font:12 textcolor:RGBCOLOR(24, 168, 185) backgroundColor:nil];
    [self.view addSubview:typelabel];
    UILabel *totalTimeLabel = [MyControl createLabelWithtext:[NSString stringWithFormat:@"耗时%@",self.model.lishi] font:13 textcolor:RGBCOLOR(102, 102, 102) backgroundColor:nil];
    [self.view addSubview:totalTimeLabel];
    //右边
    UILabel *endStationLabel = [MyControl createLabelWithtext:self.model.to_station_name font:17 textcolor:RGBCOLOR(51, 51, 51) backgroundColor:nil];
    [self.view addSubview:endStationLabel];
    UILabel *endTimeLabel =[MyControl createLabelWithtext:self.model.arrive_time font:25 textcolor:RGBCOLOR(15, 141, 146) backgroundColor:nil];
    [self.view addSubview:endTimeLabel];
    UILabel *endDayLabel =[MyControl createLabelWithtext:self.model.start_train_date font:15 textcolor:RGBCOLOR(51, 51, 51) backgroundColor:nil];
    [self.view addSubview:endDayLabel];
    //mas_make
    [typelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [getImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typelabel.mas_bottom).with.offset(2);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(101, 5));
    }];
    [totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(getImageView.mas_bottom).with.offset(16);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [startStationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(11);
        make.left.equalTo(self.view).with.offset(20);
//        make.size.mas_equalTo(CGSizeMake(70, 20));
        make.size.equalTo(@[startTimeLabel,startDayLabel]);
    }];
    [startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(startStationLabel.mas_bottom).with.offset(6);
       make.left.equalTo(self.view).with.offset(20);
    }];
    [startDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startTimeLabel.mas_bottom).with.offset(6);
        make.left.equalTo(self.view).with.offset(20);
    }];
    [endStationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.view).with.offset(11);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.size.equalTo(@[endTimeLabel,endDayLabel]);
    }];
    [endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(endStationLabel.mas_bottom).with.offset(6);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    [endDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(endTimeLabel.mas_bottom).with.offset(6);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    //      PriceTableView
    trainResultTableView =[[UITableView alloc] init];
    trainResultTableView.delegate =self;
    trainResultTableView.dataSource=self;
    trainResultTableView.separatorStyle = NO;
    trainResultTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    trainResultTableView.showsVerticalScrollIndicator = NO;
    trainResultTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:trainResultTableView];
    [trainResultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startDayLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];

}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return priceDataArray.count;
    }
    return self.model.zhanzhanArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID;
    if (indexPath.section ==0) {
        cellID=@"cellID";
        TraunResultSecCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[TraunResultSecCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        TrainPriceModel *model =priceDataArray[indexPath.row];
        cell.trainPriceModel = model;
        cell.backgroundColor = [UIColor clearColor];
    return cell;
    }else{
        cellID=@"cellid";
        TrainQujianCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[TrainQujianCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.backgroundColor = [UIColor clearColor];
        if (indexPath.row ==0) {
           cell.backgroundColor = RGBCOLOR(162, 149, 98);
        }
        if (indexPath.row==1) {
            TrainQujianModel *model = self.model.zhanzhanArray[indexPath.row];
            model.cellType = TrainQujianCellTypeStartStationRow;
            cell.trainQujianModel = model;
        }
        TrainQujianModel *model = self.model.zhanzhanArray[indexPath.row];
        cell.trainQujianModel = model;
        
//        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
    UIImageView *logoImgView =[MyControl createImageViewFrame:CGRectMake(15, 22, 15, 12) imageName:@"橙"];
    [headerView addSubview:logoImgView];
    UILabel *headLabel = [MyControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(logoImgView.frame)+10, 20, 100, 20) text:@"票价信息" font:16 textcolor:RGBCOLOR(102, 102, 102) textAlignment:0 backgroundColor:nil];
    [headerView addSubview:headLabel];
    if (section==1) {
        logoImgView.image =[UIImage imageNamed:@"蓝"];
        headLabel.text =@"时刻表";
        
    }
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
