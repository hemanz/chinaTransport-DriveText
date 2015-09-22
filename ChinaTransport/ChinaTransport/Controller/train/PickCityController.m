//
//  PickCityController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/12.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "PickCityController.h"
#import "DBManager.h"

@interface PickCityController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *cityTableView;
    NSMutableArray *dataArray;
    NSMutableArray *littleArray;
}
@end

@implementation PickCityController
-(void)addDBData{
    DBManager *dbmanager =[DBManager shareRecordingDBManager];
    NSMutableArray *arr =[dbmanager loadtrainData];
    for(char c = 'a';c<='z';c++){
            littleArray =[[NSMutableArray alloc]init];
            for (NSInteger i=0; i<arr.count; i++) {
                if ([[[arr[i] objectForKey:@"sta_code_first"] substringToIndex:1] isEqualToString:[NSString stringWithFormat:@"%c",c]]) {
                    [littleArray addObject:arr[i]];
                }
            }
            [dataArray addObject:littleArray];
        }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    dataArray =[[NSMutableArray alloc]initWithCapacity:1];
    [self addDBData];
    [self addTiTle:@"-选 择 城 市-"];
    [self createUI];
}
-(void)createUI{
    cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wid, heigh-64) style:UITableViewStylePlain];
    cityTableView.delegate =self;
    cityTableView.dataSource =self;
    cityTableView.backgroundColor = [UIColor clearColor];
    cityTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //改变索引选中的颜色
    cityTableView.sectionIndexColor = [UIColor blackColor];
    cityTableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    [self.view addSubview:cityTableView];
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [dataArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID;
    cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text =[dataArray[indexPath.section][indexPath.row] objectForKey:@"sta_name"];;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView =[MyControl createUIViewWithFrame:CGRectMake(0, 0, wid, 30) color:nil];
    UILabel *headerLabel =[MyControl createLabelWithFrame:CGRectMake(10, 5, wid-20, 20) text:[[[dataArray[section][0] objectForKey:@"sta_code_first"] substringToIndex:1] uppercaseString] font:15 textcolor:RGBCOLOR(51, 51, 51) textAlignment:0 backgroundColor:nil];
    [headerView addSubview:headerLabel];
    
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *stationCode = [dataArray[indexPath.section][indexPath.row] objectForKey:@"sta_code"];
    NSString *stationName = [dataArray[indexPath.section][indexPath.row] objectForKey:@"sta_name"];
    NSDictionary *dic;
    if ([self.type isEqualToString:@"start"]) {
        dic = @{@"cityName":stationName,@"cityCode":stationCode,@"type":@"start"};
         [[NSNotificationCenter defaultCenter]postNotificationName:@"train" object:self userInfo:dic];
    }else{
        dic = @{@"cityName":stationName,@"cityCode":stationCode,@"type":@"end"};
         [[NSNotificationCenter defaultCenter]postNotificationName:@"train" object:self userInfo:dic];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//  索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
    for(char c = 'A';c<='Z';c++)
        [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
    return toBeReturned;
    
}


-(void)testBtnClick{
    
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
