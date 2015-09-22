//
//  ResultController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/12.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "TrainQujianController.h"
#import "TrainQujianCell.h"
#import "TrainQujianModel.h"
#import "TrainModel.h"
#import "ResultController.h"

@interface TrainQujianController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *resultTableView;
    NSMutableArray *dataArray;
    UIButton *sureButton;
}
@end

@implementation TrainQujianController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArray = [[NSMutableArray alloc] init];
    [self addTiTle:[NSString stringWithFormat:@"- %@ -",self.checi]];
    [self requestData];
    
}
-(void)createUI{
    if (dataArray.count>1) {
//        [SVProgressHUD showSuccessWithStatus:@"加载成功"];

        resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wid, heigh-64-40) style:UITableViewStylePlain];
        resultTableView.delegate =self;
        resultTableView.dataSource =self;
    //    resultTableView.separatorStyle = NO;
        resultTableView.backgroundColor = [UIColor clearColor];
        resultTableView.tableFooterView =[[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:resultTableView];
    //    sureButton
        sureButton =[MyControl createButtonWithType:UIButtonTypeCustom Frame:CGRectMake(0, heigh-40-64,wid, 39) title:@"确定" titleColor:nil imageName:nil bgImageName:nil target:self method:nil];
         sureButton.backgroundColor=RGBCOLOR(178, 162, 162);
        [self.view addSubview:sureButton];
    }else {
//        [SVProgressHUD showErrorWithStatus:@"加载失败 请重试"];
        UIView *noneView= [[UIView alloc] initWithFrame:CGRectMake(0, 71, wid, heigh-64-71)];
        [self.view addSubview:noneView];
        UILabel *showLabel =[MyControl createLabelWithFrame:CGRectMake(10, (heigh-64-71)/2-20, wid-20, 40) text:@"没有查到哎，请再试一次" font:18 textcolor:RGBCOLOR(51, 51, 51) textAlignment:1 backgroundColor:[UIColor whiteColor]];
        [noneView addSubview:showLabel];
        
        //        UIToast *toast =[[UIToast alloc] init];
        //        [toast show:@"没有查到哎，请再试一次"];
        
        
    }

}
#pragma mark - RequestData
-(void)requestData{
//     [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeNone];
    NSString *urlString =[Url queryTrainByCheci:self.checi date:self.checiDate];
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
            model.station_code =[self judgeDicEmpty:subdic str:@"station_code"];
            model.cellType=TrainQujianCellTypeUnselected;  //可选状态
            [dataArray addObject:model];
        }
        TrainQujianModel *model = [[TrainQujianModel alloc] init];
        model.arrive_time=@"到达";
        model.start_time=@"发车";
        model.station_name=@"站名";
        model.station_no=@"站次";
        model.stopover_time=@"停留";
        model.cellType=TrainQujianCellTypeFirstRow; //第一行
        [dataArray insertObject:model atIndex:0];
        
        [self createUI];
        [resultTableView reloadData];
    } failed:^(NSString *errorMsg) {
        NSLog(@"error:%@",errorMsg);
    }];
//    [SVProgressHUD dismiss];
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
    TrainQujianCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[TrainQujianCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
        if (indexPath.row ==0) {
            cell.backgroundColor = RGBCOLOR(15, 141, 156);
        }
    TrainQujianModel *model =dataArray[indexPath.row];
    cell.trainQujianModel =model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TrainQujianModel *trainQujianModel=[dataArray objectAtIndex:indexPath.row];
    
    if (trainQujianModel.cellType!=TrainQujianCellTypeFirstRow && trainQujianModel.cellType!=TrainQujianCellTypeCannotSelected) {
        if ([self selectedCount]==2) {
            if (trainQujianModel.cellType==TrainQujianCellTypeUnselected) {
                return;
            }
        }
        if (trainQujianModel.cellType==TrainQujianCellTypeUnselected) {
            trainQujianModel.cellType=TrainQujianCellTypeSelected;
        }else{
            trainQujianModel.cellType=TrainQujianCellTypeUnselected;
        }
        [dataArray replaceObjectAtIndex:indexPath.row withObject:trainQujianModel];
        
        
        [self replaceCellType];
        [resultTableView reloadData];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)selectedCount{
    int i=0;
    for (TrainQujianModel *trainQujianModel in dataArray) {
        if (trainQujianModel.cellType==TrainQujianCellTypeSelected) {
            i++;
        }
    }
    return i;
}

-(void)replaceCellType{
    if ([self selectedCount]==2) {
        [self updateToUnSelected];
        //更改btn按钮为可用
        sureButton.backgroundColor= RGBCOLOR(152, 86, 85);
        [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }else{
        for (int i=0; i<[dataArray count]; i++)  {
            TrainQujianModel *trainQujianModel=[dataArray objectAtIndex:i];
            if (trainQujianModel.cellType==TrainQujianCellTypeCannotSelected) {
                trainQujianModel.cellType=TrainQujianCellTypeUnselected;
            }
        }
        //更改btn按钮为不可用
        sureButton.backgroundColor=RGBCOLOR(178, 162, 162);
        [sureButton removeTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];

    }
}

-(void)updateToUnSelected{
    
    BOOL flag=YES; //是否可开始置灰
    for (int i=0; i<[dataArray count]; i++) {
        TrainQujianModel *trainQujianModel=[dataArray objectAtIndex:i];
        if (trainQujianModel.cellType!=TrainQujianCellTypeFirstRow) {
            if (flag) {
                if (trainQujianModel.cellType==TrainQujianCellTypeSelected) {
                    flag=NO;
                }else{
                    trainQujianModel.cellType=TrainQujianCellTypeCannotSelected;
                    [dataArray replaceObjectAtIndex:i withObject:trainQujianModel];
                }
            }else{
                if (trainQujianModel.cellType==TrainQujianCellTypeSelected) {
                    flag=YES;
                }
            }
        }
    }
}

-(void)sureButtonClick{
//    TrainModel *model =[[TrainModel alloc] init];
    NSString *start_station_telecode;
    NSString *end_station_telecode;
    int j=0;
  
//    model.zhanzhanArray = dataArray;
//    model.station_train_code = self.checi;
    for (TrainQujianModel *trainQujianModel in dataArray) {
        if (trainQujianModel.cellType==TrainQujianCellTypeSelected) {
            j++;
            if (j==1) {
                start_station_telecode = trainQujianModel.station_code;
                trainQujianModel.cellType = TrainQujianCellTypeUnselected;
            }
            if (j==2) {
               end_station_telecode = trainQujianModel.station_code;
                trainQujianModel.cellType = TrainQujianCellTypeUnselected;
            }
            
        }
    }
    [self RequestResultDatafromStaCode:start_station_telecode toStaCode:end_station_telecode];
    
    
    
}
-(void)RequestResultDatafromStaCode:(NSString *)startCode toStaCode:(NSString *)endCode{
     ResultController *resultVC =[[ResultController alloc] init];
//    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeNone];
    NSString *urlString =[Url queryTrainByFromTo:startCode toStation:endCode date:self.checiDate];
    NSString *useUrlString =[urlString stringByAppendingString:[NSString stringWithFormat:@"&checi=%@",self.checi]];
    NSLog(@"%@",useUrlString);
    [Netmanager GetRequestWithUrlString:useUrlString finished:^(id responseobj) {
        NSDictionary *dic =responseobj[@"data"];
        NSLog(@"dic:%@",dic);
        
        NSDictionary *subdic =dic[@"queryLeftNewDTO"];
        NSLog(@"subdic:%@",subdic);
        
        TrainModel *model =[[TrainModel alloc]init];
        model.start_time =[self judgeDicEmpty:subdic str:@"start_time"];
         NSLog(@"self_result:%@",[self judgeDicEmpty:subdic str:@"start_time"]);
          NSLog(@"model.result:%@",model.start_time);
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

        resultVC.model = model;
        NSLog(@"resultVC.model:%@",resultVC.model);
        [self.navigationController pushViewController:resultVC animated:YES];
//        [SVProgressHUD dismiss];
    } failed:^(NSString *errorMsg) {
        NSLog(@"error:%@",errorMsg);
    }];

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
