//
//  LeftScrollController.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/1.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "LeftScrollController.h"
#import "BaseDataManager.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "RoadStatusController.h"
#import "FeedbackViewController.h"
#import "AboutusViewController.h"
#import "cainaViewController.h"
#import "PPRevealSideViewController.h"

@interface LeftScrollController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mineTableView;
}
@end

@implementation LeftScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    /**
     调取用户信息数据
     */
    self.userInfoData=[[[UserInfoData alloc]init] getUserDefault];
    self.dataSource = [[BaseDataManager sharedBaseDataManager] getMineBaseData];
    [self createTableView];
}
-(void)createTableView{
    //添加tableview
    mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wid-30, heigh)];
    [mineTableView setDelegate:self];
    [mineTableView setDataSource:self];
    mineTableView.showsHorizontalScrollIndicator=NO;
    mineTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIImageView *bgSlideView =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, wid-30, heigh)];
    [bgSlideView setImage:[UIImage imageNamed:@"slide_image1"]];
    mineTableView.backgroundView = bgSlideView;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    
    [mineTableView setTableFooterView:v];
    
    [self.view addSubview:mineTableView];

}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"self.dataSource.count::%ld",(unsigned long)self.dataSource.count);
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"[self.dataSource[section] count]::%ld",(unsigned long)[self.dataSource[section] count]);
    return [self.dataSource[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    UITableViewCellStyle cellStyle;
    cellStyle = UITableViewCellStyleDefault;
    
    //    if (indexPath.section == 0 ) {
    //        cellStyle = UITableViewCellStyleValue1;
    //    }else if(indexPath.section== 1){
    //        cellStyle = UITableViewCellStyleValue1;
    //    }
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:cellStyle reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor clearColor];
    NSLog(@"dataSource:%@",self.dataSource);
    //    NSMutableDictionary *sectionDictionary =self.dataSource[indexPath.section][indexPath.row];
    NSMutableDictionary *sectionDictionary = self.dataSource[indexPath.section][indexPath.row];
    NSString *title =[sectionDictionary objectForKey:@"title"];
    NSString *image =[sectionDictionary objectForKey:@"image"];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"MingLiU" size:1];
    if(title){
        cell.textLabel.text = title;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.imageView.image = [UIImage imageNamed:image];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
//cell点击的效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section == 0 &&indexPath.row == 0){
        
        //            InfoViewController *infoVC = [[InfoViewController alloc]init];
        //            infoVC.hidesBottomBarWhenPushed=YES;
        ////            infoVC.delegate=self;
        //            [self.navigationController pushViewController:infoVC animated:YES];
        [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
        
        
    }
    if (indexPath.section ==0 && indexPath.row ==1) {
        FeedbackViewController *feedBVC =[[FeedbackViewController alloc] init];
        UINavigationController *NVC =[[UINavigationController alloc] initWithRootViewController:feedBVC];
        [self presentViewController:NVC animated:YES completion:nil];
    }
    if (indexPath.section ==0 && indexPath.row ==2) {
        cainaViewController *cvc =[[cainaViewController alloc] init];
        UINavigationController *NVC =[[UINavigationController alloc] initWithRootViewController:cvc];
        [self presentViewController:NVC animated:YES completion:nil];
    }
    if (indexPath.section ==0 && indexPath.row ==3) {
        AboutusViewController *cvc =[[AboutusViewController alloc] init];
        UINavigationController *NVC =[[UINavigationController alloc] initWithRootViewController:cvc];
        [self presentViewController:NVC animated:YES completion:nil];
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
