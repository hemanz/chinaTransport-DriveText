//
//  TrainController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/12.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "TrainController.h"
#import "trainCell.h"
#import "PickCityController.h"
#import "TrainQujianController.h"
#import "ZhanzhanController.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "UIToast.h"

#define  kTypeButtontextColor  RGBCOLOR(24, 24, 24)
@interface TrainController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    UISegmentedControl *segment;
    UIScrollView *scrolView;
    UITableView *zhanTableView;
    UITableView *zhanTimeTableView;
    UITableView *checiTableView;
    NSString *from_sta_name;
    NSString *from_sta_code;
    NSString *to_sta_name;
    NSString *to_sta_code;
    BOOL isScroll;
    UITextField *textField;
    UIView *TrainTypeView ;
    UIView *checiView;
    NSString *checidateString; //checi出发日期
    NSString *zhandateString; //zhan出发日期
    UIView *trainHeaderZimuView;
}
@end

@implementation TrainController
-(void)addData{
    //获取系统时间
    NSDate * senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString * locationString=[dateformatter stringFromDate:senddate];
    NSString *todayLocationString = [locationString stringByAppendingString:@" 今天"];
    NSLog(@"locationString:%@",locationString);
    from_sta_name=@"北京";
    from_sta_code=@"BJP";
    to_sta_name =@"上海";
    to_sta_code =@"SHH";
    zhandateString =todayLocationString;
    checidateString =todayLocationString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTiTle:@"- 火 车 票 -"];
    [self addData];
    [self createUI];
    //建立观察键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)gotocityName:(NSNotification *)note{
    NSString *cityName =[[note userInfo] objectForKey:@"cityName"];
    NSString *cityCode =[[note userInfo] objectForKey:@"cityCode"];
    NSString *type =[[note userInfo] objectForKey:@"type"];
    if ([type isEqualToString:@"start"] ) {
        from_sta_name = cityName;
        from_sta_code = cityCode;
    }else{
        to_sta_name = cityName;
        to_sta_code = cityCode;
    }
    
    [zhanTableView reloadData];
}
#pragma mark - UILoad
-(void)createUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gotocityName:) name:@"train" object:nil];
//      segment
    NSArray *titleArray =@[@"站站",@"车次"];
    segment =[[UISegmentedControl alloc] initWithItems:titleArray];
    segment.frame=CGRectMake(34, 6, wid-68, 34);
    segment.selectedSegmentIndex =0;
    segment.tintColor = RGBCOLOR(15, 141, 156) ;
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    //改变segment的字体大小和颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:RGBCOLOR(15, 141, 156),NSForegroundColorAttributeName,[UIFont fontWithName:@"AppleGothic"size:16],NSFontAttributeName ,nil];
    //设置各种状态的字体和颜色
    [segment setTitleTextAttributes:dic forState:UIControlStateNormal];
    NSDictionary *selectdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"AppleGothic"size:16],NSFontAttributeName ,nil];
    //设置各种状态的字体和颜色
    [segment setTitleTextAttributes:selectdic forState:UIControlStateSelected];
//         创建整个大的scrollView
    scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, wid, heigh-104)];
    scrolView.contentSize = CGSizeMake(wid*2, 0);
    scrolView.showsHorizontalScrollIndicator = NO;
    scrolView.showsVerticalScrollIndicator = NO;
    scrolView.pagingEnabled = YES;
    scrolView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:scrolView];
//        站站的View
    UIView *zhanView =[MyControl createUIViewWithFrame:CGRectMake(0, 0, wid, heigh-104) color:[UIColor clearColor]];
    [scrolView addSubview:zhanView];
//    zhanTableView = [[UITableView alloc] initWithFrame:CGRectMake(25, 50, wid-25-36-18-10, 100) style:UITableViewStylePlain];
    zhanTableView = [[UITableView alloc] init];
    zhanTableView.delegate =self;
    zhanTableView.dataSource = self;
    zhanTableView.backgroundColor = [UIColor clearColor];
    [zhanView addSubview:zhanTableView];
    UIImageView *logoImgView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"交换按钮"]];
    logoImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *logoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLogoClick)];
    [logoImgView addGestureRecognizer:logoTap];
    [scrolView addSubview:logoImgView];
    zhanTimeTableView = [[UITableView alloc] init];
    zhanTimeTableView.delegate =self;
    zhanTimeTableView.dataSource = self;
    zhanTimeTableView.backgroundColor = [UIColor clearColor];
    [zhanView addSubview:zhanTimeTableView];
    
    UIButton *searchButton =[UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.backgroundColor= RGBCOLOR(152, 86, 85);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(zhanzhanSearch) forControlEvents:UIControlEventTouchUpInside];
    [zhanView addSubview:searchButton];
//        车次的View
    checiView =[MyControl createUIViewWithFrame:CGRectMake(wid, 0, wid, 50) color:[UIColor clearColor]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [checiView addGestureRecognizer:tap];
    [scrolView addSubview:checiView];
    UIView *checiBotmView =[MyControl createUIViewWithFrame:CGRectMake(wid, 150, wid, 85) color:[UIColor clearColor]];
    UITapGestureRecognizer *gap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [checiBotmView addGestureRecognizer:gap];
    [scrolView addSubview:checiBotmView];
    checiTableView = [[UITableView alloc] initWithFrame:CGRectMake(wid+25, 50, wid-50,100 ) style:UITableViewStylePlain];
    checiTableView.delegate =self;
    checiTableView.dataSource = self;
    checiTableView.backgroundColor = [UIColor clearColor];
    [scrolView addSubview:checiTableView];
    UIButton *searchCheciButton =[UIButton buttonWithType:UIButtonTypeCustom];
    searchCheciButton.backgroundColor= RGBCOLOR(152, 86, 85);
    [searchCheciButton addTarget:self action:@selector(zhanchiSearch) forControlEvents:UIControlEventTouchUpInside];
    [searchCheciButton setTitle:@"搜索" forState:UIControlStateNormal];
    [scrolView addSubview:searchCheciButton];

    
    [zhanTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(zhanView.mas_left).with.offset(25);
        make.top.greaterThanOrEqualTo(scrolView.mas_bottom).with.offset(30);
        make.right.equalTo(zhanView.mas_right).with.offset(-36-18-10);
        make.size.mas_equalTo(CGSizeMake(10, 100));
        make.top.lessThanOrEqualTo(scrolView.mas_bottom).with.offset(50);
    }];
    [zhanTimeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zhanTableView.mas_bottom).with.offset(1);
        make.left.equalTo(zhanView.mas_left).with.offset(25);
        make.right.equalTo(zhanView.mas_right).with.offset(-25);
        make.size.mas_equalTo(CGSizeMake(10, 50));
    }];
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(zhanTableView.mas_centerY);
        make.right.equalTo(zhanView.mas_right).with.offset(-18);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(zhanTimeTableView.mas_bottom).with.offset(85);
        make.centerX.equalTo(zhanView.mas_centerX);
        make.left.equalTo(zhanView.mas_left).with.offset(34);
        make.right.equalTo(zhanView.mas_right).with.offset(-34);
        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom).with.offset(-110);
    }];
    [searchCheciButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(checiTableView.mas_bottom).with.offset(85);
        make.centerX.equalTo(checiTableView.mas_centerX);
        make.left.equalTo(checiTableView.mas_left).with.offset(34-25);
        make.right.equalTo(checiTableView.mas_right).with.offset(-34+25);
        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom).with.offset(-110);
    }];
    
//      uiView
    trainHeaderZimuView = [MyControl createUIViewWithFrame:CGRectMake(wid, heigh, wid, 126) color:RGBCOLOR(235, 235, 235)];
    [scrolView addSubview:trainHeaderZimuView];
    UIButton *typeG_Button = [MyControl createButtontitle:@"G 高铁" titleColor:kTypeButtontextColor target:self method:@selector(typeButtonClick:)];
    UIButton *typeD_Button = [MyControl createButtontitle:@"D 动车" titleColor:kTypeButtontextColor target:self method:@selector(typeButtonClick:)];
    UIButton *typeC_Button = [MyControl createButtontitle:@"C 城际" titleColor:kTypeButtontextColor target:self method:@selector(typeButtonClick:)];
    UIButton *typeZ_Button = [MyControl createButtontitle:@"Z 直达" titleColor:kTypeButtontextColor target:self method:@selector(typeButtonClick:)];
    UIButton *typeT_Button = [MyControl createButtontitle:@"T 特快" titleColor:kTypeButtontextColor target:self method:@selector(typeButtonClick:)];
    UIButton *typeK_Button = [MyControl createButtontitle:@"K 快速" titleColor:kTypeButtontextColor target:self method:@selector(typeButtonClick:)];
    [trainHeaderZimuView addSubview:typeG_Button];
    [trainHeaderZimuView addSubview:typeD_Button];
    [trainHeaderZimuView addSubview:typeC_Button];
    [trainHeaderZimuView addSubview:typeZ_Button];
    [trainHeaderZimuView addSubview:typeT_Button];
    [trainHeaderZimuView addSubview:typeK_Button];
    [typeG_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(trainHeaderZimuView).with.offset(10);
        make.top.equalTo(trainHeaderZimuView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(90, 40));
        make.size.mas_equalTo(@[typeD_Button,typeC_Button,typeZ_Button,typeT_Button,typeK_Button]);
        make.centerY.equalTo(@[typeD_Button,typeC_Button]);
    }];
    [typeD_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(trainHeaderZimuView.mas_centerX);
    }];
    [typeC_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(trainHeaderZimuView.mas_right).with.offset(-10);
    }];
    [typeZ_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(trainHeaderZimuView).with.offset(10);
        make.top.equalTo(typeG_Button.mas_bottom).with.offset(15);
        make.centerY.equalTo(@[typeT_Button,typeK_Button]);
    }];
    
    [typeT_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(trainHeaderZimuView.mas_centerX);
    }];
    [typeK_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(trainHeaderZimuView.mas_right).with.offset(-10);
    }];
    
}
#pragma ScrollView
//         滑动切换界面
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        if (scrollView.contentOffset.x <wid/2) {
            segment.selectedSegmentIndex =0;
            isScroll =YES;
        }
        if (scrollView.contentOffset.x>wid/2 && scrollView.contentOffset.x<wid) {
            segment.selectedSegmentIndex =1;
            isScroll =YES;
        }
        isScroll =NO;
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == zhanTimeTableView) {
        return 1;
    }else{
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID;
    if (tableView ==zhanTableView) {
        cellID = @"cellID";
    }else if(tableView ==zhanTimeTableView){
        cellID = @"timeCell";
    }else{
        cellID = @"checiCell";
    }
    trainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[trainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (tableView ==zhanTableView) {
        NSArray *titleArray = @[@"出发城市",@"到达城市"];
        switch (indexPath.row) {
            case 0:
                [cell config:titleArray[indexPath.row] andName:from_sta_name];
                break;
            case 1:
                [cell config:titleArray[indexPath.row] andName:to_sta_name];
                break;
            default:
                break;
        }
    }else if(tableView == zhanTimeTableView){
//        NSString *timeStr =@"9月8日 周二(明天)";
        [cell config:@"出发日期" andName:zhandateString];
    }else{
        NSArray *titleArray = @[@"车次",@"出发日期"];
        if (indexPath.row ==0) {
            textField = [MyControl createTextFieldFrame:CGRectMake(80, 15, wid-130, 20) placeholder:@"如：D1" bgImageName:nil leftView:nil rightView:nil isPassWord:NO];
//            textField.placeholder=@"haa";
            textField.returnKeyType = UIReturnKeyDone;
            textField.keyboardType =UIKeyboardTypeNumberPad;
            textField.delegate =self;
            [cell addSubview:textField];
             [cell config:titleArray[indexPath.row] andName:textField.text];
        }else{
            [cell config:titleArray[indexPath.row] andName:checidateString];
        }
    }
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
#pragma mark - Click事件
-(void)segmentClick:(UISegmentedControl *)seg{
    if (isScroll == NO) {
        scrolView.contentOffset =CGPointMake(seg.selectedSegmentIndex*wid, 0);
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PickCityController *picCityVC = [[PickCityController alloc] init];
    if (tableView ==zhanTableView) {
        if (indexPath.row==0) {
            picCityVC.type =@"start";
            [self.navigationController pushViewController:picCityVC animated:YES];
        }else{
            picCityVC.type =@"end";
            [self.navigationController pushViewController:picCityVC animated:YES];
        }
    }else if (tableView == zhanTimeTableView) {
            [self CalendarView];
    }else{
        if (indexPath.row == 1) {
            [self CalendarView];
        }

    }
}
-(void)CalendarView{
    CalendarHomeViewController *calendarVC;
    if (!calendarVC) {
        calendarVC = [[CalendarHomeViewController alloc]init];
        calendarVC.calendartitle = @"选择日期";
        //火车初始化方法
        NSArray *dateArray =[zhandateString componentsSeparatedByString:@" "];
        [calendarVC setTrainToDay:60 ToDateforString:dateArray[0]];
    }
    calendarVC.calendarblock = ^(CalendarDayModel *model){
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[model getWeek]);
        NSLog(@"2字符串 %@",[model toString]);
        NSLog(@"3节日  %@",model.holiday);
        if (model.holiday) {
            zhandateString =[NSString stringWithFormat:@"%@ %@",[model toString],model.holiday];
            checidateString =[NSString stringWithFormat:@"%@ %@",[model toString],model.holiday];
            [zhanTimeTableView reloadData];
            [checiTableView reloadData];
        }else{
            zhandateString = [NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]];
            checidateString =[NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]];
            [zhanTimeTableView reloadData];
            [checiTableView reloadData];
        }
    };
    [self.navigationController pushViewController:calendarVC animated:YES];
}
-(void)tapClick{
     [textField resignFirstResponder];
}
-(void)zhanzhanSearch{
    ZhanzhanController *zhanVC =[[ZhanzhanController alloc] init];
    zhanVC.from_sta_code =from_sta_code;
    zhanVC.to_sta_code = to_sta_code;
    zhanVC.zhanDate = zhandateString;
    zhanVC.from_sta_name = from_sta_name;
    zhanVC.to_sta_name = to_sta_name;
    [self.navigationController pushViewController:zhanVC animated:YES];
}
-(void)zhanchiSearch{
    TrainQujianController *CheciVC = [[TrainQujianController alloc] init];
    NSArray *postDateStr = [checidateString componentsSeparatedByString:@" "];
    CheciVC.checiDate = postDateStr[0];
    if (![self isBlankString:textField.text]) {
        CheciVC.checi =textField.text;
        [self.navigationController pushViewController:CheciVC animated:YES];
    }else{
        UIToast *toast =[[UIToast alloc] init];
        [toast show:@"你还没有输入车次"];
    }
}
-(void)typeButtonClick:(id )sender{
    UIButton *btn=(UIButton *)sender;
    NSLog(@"%ld",btn.tag);
    textField.text = [btn.titleLabel.text substringToIndex:1];
}
-(void)tapLogoClick{
    NSString *changeStr =from_sta_name;
    from_sta_name =to_sta_name;
    to_sta_name = changeStr;
    [zhanTableView reloadData];
}
#pragma mark - textfield
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self tapClick];
    return YES;
}
#pragma mark - keyBoard
//        监测键盘的事件
-(void)showKeyboard:(NSNotification *)notification{
    
    //    计算键盘高度
    float y =[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size.height;
    NSLog(@"%lf",y);
    //    界面移动
    [UIView animateWithDuration:1 animations:^{
        trainHeaderZimuView.frame = CGRectMake(wid, heigh-y-226, wid,126);
    }];
    
}
- (void)hideKeyboard:(NSNotification *)notification
{
    [UIView animateWithDuration:1.5 animations:^{
        trainHeaderZimuView.frame = CGRectMake(wid, heigh, wid,126);
        //logoImageView.transform = CGAffineTransformMakeScale(1, 1);
    }];
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
