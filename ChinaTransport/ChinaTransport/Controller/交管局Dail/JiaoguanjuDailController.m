//
//  JiaoguanjuDailController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/14.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "JiaoguanjuDailController.h"

@interface JiaoguanjuDailController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *dailTableView; //交管局热线的tableView
}
@end

@implementation JiaoguanjuDailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTiTle:@"- 交 管 局 热 线 -"];
    [self createUI];
}
#pragma mark - UILoad
-(void)createUI{
    dailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wid, heigh-64) style:UITableViewStylePlain];
    dailTableView.delegate =self;
    dailTableView.dataSource =self;
    dailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    dailTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:dailTableView];
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID;
    cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text =@"     北京     122";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self alertView];
}
-(void)alertView{
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"18801454649"]]];

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
