//
//  WeizhangDesController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/19.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "WeizhangDesController.h"
#import "WeizhangDesModel.h"
#import "WeizhangDesCell.h"

#define kTextColor RGBCOLOR(51, 51, 51)
@interface WeizhangDesController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *weizhangDesTableView;
    NSMutableArray *dataArray;
    UIView *backView; //车辆信息背景View
}
@end

@implementation WeizhangDesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [[NSMutableArray alloc] init];
    [self addTiTle:@"-查 询 结 果-"];
    [self createUI];
    [self requestData];
}
#pragma mark - RequestData
-(void)requestData{
    NSString *UrlString;
    if (self.judgeClassno) {
         UrlString =[Url queryWeizhangNewWithCity:self.cityName carNo:self.carNo engineno:self.enginenoORclassno classno:self.judgeClassno rand:self.randCode];
    }else{
        UrlString =[Url queryWeizhangNewWithCity:self.cityName carNo:self.carNo engineno:self.enginenoORclassno classno:self.enginenoORclassno rand:self.randCode];
    }
    NSLog(@"UrlString:%@",UrlString);
     NSString *urlStr =[UrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [Netmanager GetRequestWithUrlString:urlStr finished:^(id responseobj) {
        if ([responseobj[@"resCode"] isEqualToString:@"00000"]) {
            NSDictionary *subdic = responseobj[@"WZInfo"];
//            NSString *ztStr1=[subdic objectForKey:@"ZT"];
//            NSString *CSYSStr =subdic[@"CSYS"];
//            NSString *YXQZStr =subdic[@"YXQZ"];
//            [WZArray addObject:[self judgeArrayEmpty:ztStr1]];
//            [WZArray addObject:[self judgeArrayEmpty:CSYSStr]];
//            [WZArray addObject:[self judgeArrayEmpty:YXQZStr]];
            
            NSArray *arr =subdic[@"WFXXList"];
            for (NSDictionary *subDic in arr) {
                WeizhangDesModel *model =[[WeizhangDesModel alloc] init];
                model.wfxw =[self judgeDicEmpty:subDic str:@"WFXW"];
                model.fxjg =[self judgeDicEmpty:subDic str:@"FXJG"];
                model.wfdz =[self judgeDicEmpty:subDic str:@"WFDZ"];
                model.wfsj =[self judgeDicEmpty:subDic str:@"WFSJ"];
                model.fkje =[self judgeDicEmpty:subDic str:@"FKJE"];
                model.kffs =[self judgeDicEmpty:subDic str:@"KFFS"];
                
                [dataArray addObject:model];
            }
            NSLog(@"%@",dataArray);
            [self createTableVIew];
        }else{
//            [SVProgressHUD dismiss];
            [self alertView:@"没查到结果，请稍后再试" cancle:@"OK"];
        }

    } failed:^(NSString *errorMsg) {
         NSLog(@"error:%@",errorMsg);
    }];
}
#pragma maek - uiload
-(void)createUI{
//    车辆信息
    UIImageView *logoImgView =[MyControl createImageViewFrame:CGRectMake(15, 13, 15, 12) imageName:@"蓝"];
    [self.view addSubview:logoImgView];
    UILabel *headLabel = [MyControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(logoImgView.frame)+10, 10, 100, 20) text:@"车辆信息" font:16 textcolor:RGBCOLOR(102, 102, 102) textAlignment:0 backgroundColor:nil];
    [self.view addSubview:headLabel];
    backView = [MyControl createUIViewWithFrame:CGRectMake(10, CGRectGetMaxY(headLabel.frame)+10, wid-20, 120-80) color:RGBCOLOR(255, 255, 255)];
    [self.view addSubview:backView];
    UILabel *hLaebl1 =[MyControl createLabelWithtext:nil font:0 textcolor:nil backgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]]];
    [backView addSubview:hLaebl1];
    UILabel *hLaebl2 =[MyControl createLabelWithtext:nil font:0 textcolor:nil backgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]]];
    [backView addSubview:hLaebl2];
    UILabel *carNumLabel =[MyControl createLabelWithtext:@"车牌号码:" font:17 textcolor:[UIColor blackColor] backgroundColor:nil];
    [backView addSubview:carNumLabel];
    UILabel *carNumDesLabel =[MyControl createLabelWithtext:self.carNo font:16 textcolor:kTextColor backgroundColor:nil];
    [backView addSubview:carNumDesLabel];
//    UILabel *YXQZlabel =[MyControl createLabelWithtext:@"有效期至:" font:17 textcolor:[UIColor blackColor] backgroundColor:nil];
//    [backView addSubview:YXQZlabel];
//    UILabel *YXQZDeslabel =[MyControl createLabelWithtext:@"2015-06-30" font:16 textcolor:kTextColor backgroundColor:nil];
//    [backView addSubview:YXQZDeslabel];
//    UILabel *carColorLabel =[MyControl createLabelWithtext:@"车辆颜色:" font:17 textcolor:[UIColor blackColor] backgroundColor:nil];
//    [backView addSubview:carColorLabel];
//    UILabel *carColorDesLabel =[MyControl createLabelWithtext:@"黑" font:16 textcolor:kTextColor backgroundColor:nil];
//    [backView addSubview:carColorDesLabel];
//    UILabel *jiancheLabel =[MyControl createLabelWithtext:@"(请及时检车)" font:16 textcolor:[UIColor orangeColor] backgroundColor:nil];
//    [backView addSubview:jiancheLabel];
    
    [carNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).with.offset(6);
        make.top.equalTo(backView).with.offset(10);
        make.centerY.equalTo(carNumDesLabel);
    }];
    [carNumDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(carNumLabel.mas_right).with.offset(15);
    }];
    [hLaebl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carNumLabel.mas_bottom).with.offset(10);
        make.left.equalTo(backView);
        make.size.mas_equalTo(CGSizeMake(wid-20, 1));
    }];
//    [YXQZlabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(backView).with.offset(6);
//        make.top.equalTo(hLaebl1.mas_bottom).with.offset(10);
//        make.centerY.equalTo(@[YXQZDeslabel,jiancheLabel]);
//    }];
//    [YXQZDeslabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(YXQZlabel.mas_right).with.offset(15);
//        
//    }];
//    [jiancheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(backView.mas_right).with.offset(-15);
//    }];
//    [hLaebl2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(YXQZlabel.mas_bottom).with.offset(10);
//        make.left.equalTo(backView);
//        make.size.mas_equalTo(CGSizeMake(wid-20, 1));
//    }];
//    [carColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(backView).with.offset(6);
//        make.top.equalTo(hLaebl2.mas_bottom).with.offset(10);
//        make.centerY.equalTo(carColorDesLabel);
//    }];
//    [carColorDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(carColorLabel.mas_right).with.offset(15);
//    }];

}
-(void)createTableVIew{
    weizhangDesTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 150, wid, heigh-150-64) style:UITableViewStylePlain];
    weizhangDesTableView.delegate =self;
    weizhangDesTableView.dataSource =self;
    weizhangDesTableView.backgroundColor = [UIColor clearColor];
    weizhangDesTableView.separatorStyle = NO;
    weizhangDesTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:weizhangDesTableView];
    [weizhangDesTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).with.offset(5);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID;
    cellID = @"cellID";
    WeizhangDesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[WeizhangDesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    WeizhangDesModel *model =dataArray[indexPath.row];
    cell.weizhangDesModel =model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeizhangDesModel *model =dataArray[indexPath.row];
    return 105+[self getTextSize:model.fxjg]+[self getTextSize:model.wfdz]+[self getTextSize:model.wfxw];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
    UIImageView *logoImgView =[MyControl createImageViewFrame:CGRectMake(15, 12, 15, 12) imageName:@"橙"];
    [headerView addSubview:logoImgView];
    UILabel *headLabel = [MyControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(logoImgView.frame)+10, 10, 100, 20) text:@"车辆状态" font:16 textcolor:RGBCOLOR(102, 102, 102) textAlignment:0 backgroundColor:nil];
    [headerView addSubview:headLabel];
    return headerView;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//   根据字数判断size
-(CGFloat)getTextSize:(NSString *)string{
    CGSize size = CGSizeMake(wid-110,999);//LableWight标签宽度，固定的
    //计算实际frame大小，并将label的frame变成实际大小
    UIFont *font =[UIFont systemFontOfSize:18 weight:50];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGRect rect =  [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
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
