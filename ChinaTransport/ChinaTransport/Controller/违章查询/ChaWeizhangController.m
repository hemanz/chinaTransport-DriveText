//
//  ChaWeizhangController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/14.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "ChaWeizhangController.h"
#import "ChaWeizhanModel.h"
#import "ChaWeizhangCell.h"
#import "WeizhangDesController.h"
#import "GetCityNameController.h"
#import "UIImageView+WebCache.h"
#import "UIToast.h"

@interface ChaWeizhangController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *weizhangTopTableView;  //违章的tableView
    NSString *cityName;  // che查询城市
    UITextField *carNumField;
    NSMutableArray *dataArray;
    NSString *abbrStr; //省份标示
    UIButton *carButton; //省份简写Btn
    UIImageView *randImgView; //验证码图片
    UITextField *randTextField;//验证码textField
}
@end

@implementation ChaWeizhangController
-(void)giveValue{
    cityName =@"北京";
    abbrStr =@"京";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    dataArray = [[NSMutableArray alloc] init];
    [self addTiTle:@"- 查 违 章 -"];
    [self giveValue];
    
    
    [self createUI];
    [self requestData];
    [self imageViewtapClick];
}
#pragma mark - RequestData
-(void)requestData{
     dataArray = [[NSMutableArray alloc] init];
    
    NSString *urlString =[Url queryCityWZInfoCity:cityName];
    NSString *UrlStr =[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",UrlStr);
    [Netmanager GetRequestWithUrlString:UrlStr finished:^(id responseobj) {
        ChaWeizhanModel *model =[[ChaWeizhanModel alloc] init];
        model.isenabled =responseobj[@"isenabled"];
        if (responseobj[@"isenabled"]) {
            [carButton setImage:nil forState:UIControlStateNormal];
            [carButton setTitle:nil forState:UIControlStateNormal];
            abbrStr =responseobj[@"abbr"];
            if ([responseobj[@"engine"] isEqualToString:@"1"]) {
                
                model.isenabled =responseobj[@"isenabled"];
                model.engine =responseobj[@"engine"];
                model.engineno =responseobj[@"engineno"];
                model.classa=@"0";
                [dataArray addObject:model];
            }
            else if ([responseobj[@"classa"]isEqualToString:@"1"]) {
                ChaWeizhanModel *model =[[ChaWeizhanModel alloc] init];
                model.isenabled =responseobj[@"isenabled"];
                model.engine =@"0";
                model.classa = responseobj[@"classa"];
                model.classno =responseobj[@"classno"];
                [dataArray addObject:model];
            }
            
        }
        [self createTableView];
        NSLog(@"dataArray::%@",dataArray);
        [weizhangTopTableView reloadData];
    } failed:^(NSString *errorMsg) {
        
    }];
}
#pragma mark - UILoad
-(void)createTableView{
    weizhangTopTableView.frame =CGRectMake(0, 0, wid, 60*(dataArray.count+2));
}
-(void)createUI{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getcityName:) name:@"chaWeizhang" object:nil];
    
    weizhangTopTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, wid, 60*3) style:UITableViewStylePlain];
    weizhangTopTableView.delegate =self;
    weizhangTopTableView.dataSource =self;
    weizhangTopTableView.backgroundColor = [UIColor clearColor];
    weizhangTopTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:weizhangTopTableView];
//      验证码

    UILabel *randLabel =[MyControl createLabelWithtext:@"验证码" font:19 textcolor:RGBCOLOR(0, 0, 0) backgroundColor:nil];
    [self.view addSubview:randLabel];
    randTextField =[[UITextField alloc] init];
    randTextField.placeholder=@"输入验证码";
//    randTextField.backgroundColor =RGBCOLOR(200, 200, 200) ;
    randTextField.returnKeyType = UIReturnKeyDone;
//    randTextField.layer.masksToBounds =YES;
//    randTextField.layer.cornerRadius =8;
    randTextField.delegate =self;
    [self.view addSubview:randTextField];
    randImgView =[[UIImageView alloc] init];
    randImgView.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewtapClick)];
    [randImgView addGestureRecognizer:tap];
    [self.view addSubview:randImgView];
    
    [randLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(weizhangTopTableView.mas_bottom).with.offset(5);
    }];
    [randTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weizhangTopTableView.mas_bottom).with.offset(5);
        make.left.equalTo(self.view.mas_centerX).with.offset(-50);
        make.right.equalTo(self.view.mas_centerX).with.offset(50);
        make.height.equalTo(randLabel.mas_height);
    }];
    [randImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weizhangTopTableView.mas_bottom).with.offset(6);
        make.left.equalTo(randTextField.mas_right).with.offset(20);
        make.right.equalTo(self.view).with.offset(-10);
        
    }];
    
    
//      搜索的按钮
    UIButton *searchCheciButton =[UIButton buttonWithType:UIButtonTypeCustom];
    searchCheciButton.backgroundColor= RGBCOLOR(152, 86, 85);
    [searchCheciButton addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchCheciButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.view addSubview:searchCheciButton];
    [searchCheciButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(36);
        make.right.equalTo(self.view).with.offset(-36);
        make.top.greaterThanOrEqualTo(weizhangTopTableView.mas_bottom).with.offset(50);
        make.bottom.greaterThanOrEqualTo(self.view).with.offset(-100);
    }];
}
#pragma  mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 2+dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<2) {
        static NSString *cellid =@"cellid";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
             cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        }
        cell.backgroundColor = [UIColor clearColor];
        //先删除该cell的subview，防止由于循环利用cell导致不断addsubview头像所在

        for(UIView * view in cell.subviews){
            if([view isKindOfClass:[UITextField class]])
            {
                [view removeFromSuperview];
            }
        }
        NSArray *textArray =@[@"查询城市",@"车牌号码"];
        cell.textLabel.text = textArray[indexPath.row];
        if (indexPath.row ==0) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = cityName;
            cell.detailTextLabel.textColor =RGBCOLOR(102, 102, 102);
        }
        else {
            carButton =[MyControl createButtonWithType:UIButtonTypeCustom Frame:CGRectMake(wid/2-20, 20, 40, 20) title:abbrStr titleColor:RGBCOLOR(51, 51, 51) imageName:@"时钟" bgImageName:nil target:self method:nil];
            [cell addSubview:carButton];
            carNumField =[MyControl createTextFieldFrame:CGRectMake(wid/2+45, 15, wid/2, 30) placeholder:nil bgImageName:nil leftView:nil rightView:nil isPassWord:NO];
            carNumField.placeholder =@"请输入车牌号";
            carNumField.font = [UIFont systemFontOfSize:16];
            carNumField.returnKeyType = UIReturnKeyDone;
            carNumField.delegate =self;
            [cell addSubview:carNumField];
        }
        return cell;
    }else{
        static NSString *cellID;
        cellID = @"cellID";
        ChaWeizhangCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[ChaWeizhangCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell.backgroundColor = [UIColor clearColor];
        ChaWeizhanModel *model =dataArray[indexPath.row-2];
        cell.chaWeizhanModel = model;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == weizhangTopTableView) {
        if (indexPath.row==0) {
            GetCityNameController *getCityNameVC =[[GetCityNameController alloc] init];
            [self.navigationController pushViewController:getCityNameVC animated:YES];
        }
    }
}
-(void)getcityName:(NSNotification *)note{
    cityName =[[note userInfo] objectForKey:@"cityName"];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [weizhangTopTableView reloadRowsAtIndexPaths: [NSArray arrayWithObjects:indexPath,nil]
 withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"%@",cityName);
    [self requestData];
}
-(void)searchBtnClick{
    if (![self isBlankString:carNumField.text] ) {
        if (![self isBlankString:randTextField.text]) {
            WeizhangDesController *weizhangDesVC =[[WeizhangDesController alloc] init];
            weizhangDesVC.cityName = cityName;
            weizhangDesVC.carNo = [abbrStr stringByAppendingString:carNumField.text];
            if (dataArray.count>0) {
                for (NSInteger i=0; i<dataArray.count; i++) {
                    if (i==0) {
                        ChaWeizhangCell *cell =(ChaWeizhangCell *)[weizhangTopTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i+2 inSection:0]];
                        weizhangDesVC.enginenoORclassno = cell.carNumField.text;
                    }
                    if (i==1) {
                        ChaWeizhangCell *cell =(ChaWeizhangCell *)[weizhangTopTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i+2 inSection:0]];
                        weizhangDesVC.judgeClassno = cell.carNumField.text;
                    }
                }
            }
            weizhangDesVC.randCode = randTextField.text;
            if (![self isBlankString:weizhangDesVC.enginenoORclassno]) {
                //        NSLog(@"%@,%@,%@,%@",weizhangDesVC.cityName,weizhangDesVC.carNo,weizhangDesVC.engineno,weizhangDesVC.randCode);
                [self.navigationController pushViewController:weizhangDesVC animated:YES];

            }else{
                UIToast *toast = [[UIToast alloc] init];
                [toast show:@"请按要求输入完整信息"];
            }
            
        }else{
            
        }
    }else{
        UIToast *toast = [[UIToast alloc] init];
        [toast show:@"你还没有输入车牌号"];
    }
}
//验证码
-(void)imageViewtapClick{
    NSString *urlString=[Url getRandCode];
    NSLog(@"%@",urlString);
  
    UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    [randImgView setImage:image];
    
}
#pragma mark - textfield
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self tapClick];
    return YES;
}
-(void)tapClick{
    [carNumField resignFirstResponder];
    [randTextField resignFirstResponder];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
