//
//  kuaidiResultController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/12.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "kuaidiResultController.h"
#import "Masonry.h"
#import "KuaidiDetailCell.h"
#import "KuaidiDetailModel.h"
#import "UIToast.h"

@interface kuaidiResultController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *resultTableView;
    NSString *desStr;
    NSMutableArray *dataArray;
}
@end

@implementation kuaidiResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray =[[NSMutableArray alloc] init];
    [self addTiTle:@"- 查 询 结 果 -"];
    [self requestData];
    [self createUI];
}
#pragma mark - RequestData
-(void)requestData{
    
//     [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeNone];
    NSString *urlString =[Url queryKuaiDicom:self.com num:self.num];
    NSLog(@"kuaidiUrl:%@",urlString);
    [Netmanager GetRequestWithUrlString:urlString finished:^(id responseobj) {
        NSArray *resArray =responseobj[@"list"];
        for (NSDictionary *dic in resArray) {
            KuaidiDetailModel *model =[[KuaidiDetailModel alloc] init];
            model.context =[self judgeDicEmpty:dic str:@"context"];
            NSArray *arr =[[self judgeDicEmpty:dic str:@"time"] componentsSeparatedByString:@" "];
            model.day = arr[0];
            model.time =arr[1];
            [dataArray addObject:model];
        }
        [self createTableView];
        
        [resultTableView reloadData];
        
    } failed:^(NSString *errorMsg) {
        NSLog(@"error:%@",errorMsg);
    }];
//    [SVProgressHUD dismiss];
}
#pragma  mark - UIload
-(void)createUI{
    UIImageView *logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.logoImg]];
    logoImgView.layer.masksToBounds = YES;
    logoImgView.layer.cornerRadius = 22.5;
    [self.view addSubview:logoImgView];
    UILabel *logoLable = [[UILabel alloc] init];
    logoLable.text =[NSString stringWithFormat:@"%@  %@",self.name,self.num];
    logoLable.textAlignment =NSTextAlignmentCenter;
    logoLable.textColor =RGBCOLOR(0, 0, 0);
    logoLable.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:logoLable];
    
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.top.equalTo(self.view).with.offset(26);
        make.left.equalTo(self.view).with.offset(18);
        
    }];
    [logoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerX.equalTo(self.view);
        make.centerY.equalTo(logoImgView.mas_centerY);
        make.left.equalTo(logoImgView.mas_right).with.offset(22);
    }];
    
}
-(void)createTableView{
    NSLog(@"dataArray:%@",dataArray);
    if (dataArray.count>0) {
//    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    UILabel *hLabel =[[UILabel alloc] initWithFrame:CGRectMake(15, 91, wid-20, 1)];
    hLabel.backgroundColor= RGBACOLOR(200, 200, 200, 0.6);
    [self.view addSubview:hLabel];
//     创建TableView
    resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 91, wid, heigh-64-91) style:UITableViewStylePlain];
    resultTableView.delegate =self;
    resultTableView.dataSource =self;
    resultTableView.backgroundColor = [UIColor clearColor];
    resultTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:resultTableView];
    } else {
//        [SVProgressHUD showErrorWithStatus:@"加载失败 请重试"];
        UIView *noneView= [[UIView alloc] initWithFrame:CGRectMake(0, 71, wid, heigh-64-71)];
        [self.view addSubview:noneView];
        UILabel *showLabel =[MyControl createLabelWithFrame:CGRectMake(10, (heigh-64-71)/2-20, wid-20, 40) text:@"没有查到哎，请再试一次" font:18 textcolor:RGBCOLOR(51, 51, 51) textAlignment:1 backgroundColor:[UIColor whiteColor]];
        [noneView addSubview:showLabel];
    }
}
#pragma mark - uitableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID;
    if (indexPath.row==0) {
        cellID= @"cellID";
    }else{
    cellID= @"cellId";
    }
    KuaidiDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        if (indexPath.row==0) {
            
            cell = [[KuaidiDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID withType:@"section1"] ;
        }else{
            
            cell = [[KuaidiDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID withType:nil];
        }
    }
    cell.backgroundColor = [UIColor clearColor];
    KuaidiDetailModel *model =dataArray[indexPath.row];
    NSString *dayStr = model.day;
    NSString *timeStr = model.time;
    desStr =model.context;

    [cell configDay:dayStr time:timeStr des:desStr ];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"heigh:%lf",[self getTextSize:desStr]+50);
    return [self getTextSize:desStr]+50;
}
//   根据字数判断size
-(CGFloat)getTextSize:(NSString *)string{
    CGSize size = CGSizeMake(wid-10-74-5-17-5-10,999);//LableWight标签宽度，固定的
    //计算实际frame大小，并将label的frame变成实际大小
    UIFont *font =[UIFont systemFontOfSize:16 weight:50];
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
