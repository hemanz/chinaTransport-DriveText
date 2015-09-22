//
//  CityTableViewController.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/7.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "CityTableViewController.h"
#import "BaseDataManager.h"
#import "DBManager.h"

@interface CityTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *leftProvinceTableView;
    UITableView *rightCityTableView;
    NSMutableArray *provinceDataArray;
    NSMutableArray *cityDataArray;
    NSMutableArray *firstCityArray;
    NSString *values;
}
@end

@implementation CityTableViewController
//-(void)addDBData{
//    provinceDataArray =[[NSMutableArray alloc] init];
//    cityDataArray = [[NSMutableArray alloc] init];
//    DBManager *dbmanager =[DBManager shareRecordingDBManager];
//    NSMutableArray *arr =[dbmanager loadregionData];
//    firstCityArray =[[NSMutableArray alloc] init];
//    for (NSInteger i=0; i<arr.count; i++)  {
//        if ([[arr[i] objectForKey:@"level"] isEqualToString:@"1"]) {
//            [provinceDataArray addObject:arr[i]];
//        }
//        if ([[arr[i] objectForKey:@"level"] isEqualToString:@"2"]) {
//            [firstCityArray addObject:arr[i]];
//        }
//    }
//    
//    values =@"11";
//    [self getCiteDatawithValue:values];
//    NSLog(@"%@",cityDataArray);
//    
//}
//-(NSMutableArray *)getCiteDatawithValue:(NSString *)value{
//    for (NSDictionary* dic in firstCityArray) {
//        if ([[[dic objectForKey:@"number"] substringToIndex:2] isEqualToString:value]) {
//            [cityDataArray addObject:dic];
//
//        }
//    }
//    return cityDataArray;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    provinceDataArray = [[BaseDataManager sharedBaseDataManager] getProvinceData];
    cityDataArray = [[BaseDataManager sharedBaseDataManager] getProvinceAndCiteDatawithValue:values];
    
//    [self addDBData];
    [self addTiTle:@"- 实 时 路 况 - "];
    [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backClick) location:YES];
    [self createTableView];
}
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    leftProvinceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wid/3, heigh-64) style:UITableViewStylePlain];
    leftProvinceTableView.delegate = self;
    leftProvinceTableView.dataSource =self;
    leftProvinceTableView.separatorStyle = NO;
    leftProvinceTableView.backgroundColor = RGBCOLOR(231, 216, 187);
    [self tableView:leftProvinceTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [leftProvinceTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];  //选中第0行
    [self.view addSubview:leftProvinceTableView];
    
    rightCityTableView = [[UITableView alloc] initWithFrame:CGRectMake(wid/3, 0, wid/3*2, heigh-64) style:UITableViewStylePlain];
    rightCityTableView.backgroundColor = [UIColor clearColor];
    rightCityTableView.delegate = self;
    rightCityTableView.dataSource =self;
    rightCityTableView.separatorStyle = NO;
    [self.view addSubview:rightCityTableView];
}
#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == leftProvinceTableView) {
        return [provinceDataArray count];
    }else{
        NSLog(@"rowsS:%ld",[cityDataArray count]);
        return [cityDataArray count];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID;
    if (tableView == leftProvinceTableView) {
        cellID = @"leftTableViewCellID";
    }else{
        cellID = @"rightTableViewCellId";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    if (tableView == leftProvinceTableView) {
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        UIView *aView = [[UIView alloc] initWithFrame:cell.contentView.frame];
        aView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
        cell.selectedBackgroundView = aView;
        NSString *province=[provinceDataArray[indexPath.row] objectForKey:@"name"];
        cell.textLabel.text=province;
        
    }else{
        NSString *city=[cityDataArray[indexPath.row] objectForKey:@"name"];
        cell.textLabel.text=city;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==leftProvinceTableView) {
        values=[[provinceDataArray[indexPath.row] objectForKey:@"number"] substringToIndex:2];
        cityDataArray=[[BaseDataManager sharedBaseDataManager] getProvinceAndCiteDatawithValue:values];
        [rightCityTableView reloadData];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSDictionary *dic = @{@"cityName":[cityDataArray[indexPath.row] objectForKey:@"name"],@"cityNum":[cityDataArray[indexPath.row] objectForKey:@"number"],@"postType":self.postType};
        NSLog(@"%@",dic);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"go_cityName" object:self userInfo:dic];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
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
