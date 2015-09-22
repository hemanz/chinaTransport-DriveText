//
//  KuaidiController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/9.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "KuaidiController.h"
#import "KuaidiDetailController.h"
#import "DBManager.h"
#import "FMDB.h"
#import "kuaidiCell.h"

@interface KuaidiController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *kuaidiTableView;
    NSMutableArray *keysArray;
    NSMutableArray *littleArray;
    NSMutableArray *topidxArray;
}
@end

@implementation KuaidiController
//-(NSString*)uppercaseString {
//    
//}
-(void)addDataToDB{
    DBManager *dbmanager =[DBManager shareRecordingDBManager];
    NSMutableArray *arr =[dbmanager loadkuaidiData];
    NSLog(@"%@",arr[1]);
    NSLog(@"%@",[[arr[0] objectForKey:@"idxChar"] uppercaseString]);

    topidxArray= [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<arr.count; i++) {
        if ([[arr[i] objectForKey:@"topIdx"] integerValue]>0) {
            
            
            [topidxArray addObject:arr[i]];
        }
        
    }
    NSLog(@"%@",topidxArray);
//    NSArray
//    *sortedArray = [keysArray sortedArrayUsingSelector:@selector(compare:)];
//    NSLog(@"排序后:%@",sortedArray);


    for(char c = 'a';c<='z';c++){
        if (c=='v'||c=='w') {
            
        }else{
     littleArray =[[NSMutableArray alloc]init];
        for (NSInteger i=0; i<arr.count; i++) {
            if ([[arr[i] objectForKey:@"idxChar"] isEqualToString:[NSString stringWithFormat:@"%c",c]]) {
                NSLog(@"char:%@",[[arr[i] objectForKey:@"idxChar"] uppercaseString]);
        
                [littleArray addObject:arr[i]];
            }
        }
     [keysArray addObject:littleArray];
    }
    }
    NSLog(@"keysArray:%@",[keysArray[2][0] objectForKey:@"topidx"]);
    
    
    [keysArray insertObject:topidxArray atIndex:0];
    
}
- (void)viewDidLoad {
    keysArray=[[NSMutableArray alloc]initWithCapacity:1];
    
    [super viewDidLoad];
  
    [self addDataToDB];
    [self addTiTle:@"- 快 递 -"];
    [self createUI];
}
#pragma mark - UIload
-(void)createUI{
    
    kuaidiTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, wid, heigh-64) style:UITableViewStylePlain];
    kuaidiTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
    kuaidiTableView.delegate =self;
    kuaidiTableView.dataSource = self;
    kuaidiTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //改变索引选中的颜色
    kuaidiTableView.sectionIndexColor = [UIColor blackColor];
    kuaidiTableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    [self.view addSubview:kuaidiTableView];
}
#pragma mark - uitableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [keysArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [keysArray[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";

    kuaidiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[kuaidiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
 
    NSString *logoImage = [keysArray[indexPath.section][indexPath.row] objectForKey:@"number"];
    NSString *titleStr =[keysArray[indexPath.section][indexPath.row] objectForKey:@"name"];
    [cell config:logoImage andName:titleStr];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }
    return 25;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView =[MyControl createUIViewWithFrame:CGRectMake(0, 0, wid, 30) color:nil];
    UILabel *headerLabel =[MyControl createLabelWithFrame:CGRectMake(10, 5, wid-20, 20) text:[[keysArray[section][0] objectForKey:@"idxChar"] uppercaseString] font:15 textcolor:RGBCOLOR(51, 51, 51) textAlignment:0 backgroundColor:nil];
    if (section ==0) {
        headerLabel.text =@"常用快递";
    }
    [headerView addSubview:headerLabel];

    return headerView;
}
//  索引
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KuaidiDetailController *kuaidiSecVC =[[KuaidiDetailController alloc] init];
    kuaidiSecVC.logoimage =[keysArray[indexPath.section][indexPath.row] objectForKey:@"number"];
    kuaidiSecVC.name =[keysArray[indexPath.section][indexPath.row] objectForKey:@"name"];
    kuaidiSecVC.contact =[keysArray[indexPath.section][indexPath.row] objectForKey:@"contact"];
    kuaidiSecVC.com =[keysArray[indexPath.section][indexPath.row] objectForKey:@"number"];
    [self.navigationController pushViewController:kuaidiSecVC animated:YES];
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
    [toBeReturned addObject:@"#"];
    for(char c = 'A';c<='Z';c++)
        [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
    
    return toBeReturned;
    
}

#pragma mark - Click
-(void)titleBtnClick:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
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
