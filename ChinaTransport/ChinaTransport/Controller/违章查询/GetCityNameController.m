//
//  GetCityNameController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/19.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "GetCityNameController.h"
#import "BaseDataManager.h"
#import "DBManager.h"

@interface GetCityNameController ()<UITableViewDataSource,UITableViewDelegate>
{
     UITableView *leftProvinceTableView;
    NSMutableArray *provinceDataArray;
    UITableView *rightCityTableView;
    NSMutableArray *cityDataArray;
    NSMutableArray *firstCityArray;
    NSString *values;
}
@end

@implementation GetCityNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    provinceDataArray = [[BaseDataManager sharedBaseDataManager] getWeizhangProvinceData];
    cityDataArray = [[BaseDataManager sharedBaseDataManager] getWeizhangCityProvinceAndCiteDatawithValue:values];
    [self addTiTle:@"- 选 择 城 市 - "];
    [self createUI];
}
-(void)createUI{
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
        cityDataArray=[[BaseDataManager sharedBaseDataManager] getWeizhangCityProvinceAndCiteDatawithValue:values];
        [rightCityTableView reloadData];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSDictionary *dic = @{@"cityName":[cityDataArray[indexPath.row] objectForKey:@"name"]};
        NSLog(@"%@",dic);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chaWeizhang" object:self userInfo:dic];
        [self.navigationController popViewControllerAnimated:YES];
    }

//    NSDictionary *dic = @{@"cityName":[provinceDataArray[indexPath.row] objectForKey:@"name"]};
//    NSLog(@"%@",dic);
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"chaWeizhang" object:self userInfo:dic];
//    [self.navigationController popViewControllerAnimated:YES];
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
