//
//  KuaidiDetailController.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/9.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "KuaidiDetailController.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "kuaidiResultController.h"

@interface KuaidiDetailController ()<UIAlertViewDelegate,UITextFieldDelegate>
{
    UITextField *textField;
}
@end

@implementation KuaidiDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTiTle:[NSString stringWithFormat:@"- %@ -",self.name]];
    [self createUI];
}
-(void)createUI{
//      快递的Logo
//    UIImageView *logoImgView = [MyControl createImageViewFrame:CGRectMake(wid/2-72/2, 36*wid/320, 72, 72) imageName:@"shunfeng"];
    UIImageView *logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.logoimage]];
    logoImgView.layer.masksToBounds = YES;
    logoImgView.layer.cornerRadius = 36;
    [self.view addSubview:logoImgView];
//    UILabel *logoLable =[MyControl createLabelWithFrame:CGRectMake(wid/2-50, CGRectGetMaxY(logoImgView.frame)+15, 100, 20) text:@"顺丰查询" font:15 textcolor:RGBCOLOR(51, 51, 51) textAlignment:1 backgroundColor:nil];
    UILabel *logoLable = [[UILabel alloc] init];
    logoLable.text =self.name;
    logoLable.textAlignment =NSTextAlignmentCenter;
    logoLable.textColor =RGBCOLOR(51, 51, 51);
    logoLable.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:logoLable];
//      输入查询号
    UIImage *image =[UIImage imageNamed:@"输入框"];
    UIImageView *searchImgView =[[UIImageView alloc] initWithImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 100)]];
//    [searchImgView setContentStretch:CGRectMake(0.5f, 0.5f, 0.f, 0.f)];
    searchImgView.userInteractionEnabled = YES;
   
    [self.view addSubview:searchImgView];
    UIButton *camaraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [camaraButton setBackgroundImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
    [camaraButton addTarget:self action:@selector(camabtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchImgView addSubview:camaraButton];
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [searchImgView addSubview:searchButton];
    textField =[[UITextField alloc] init];
    textField.placeholder =@"请输入快递单号";
    textField.delegate =self;
    [searchImgView addSubview:textField];
    
//     电话
    UIButton *dailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dailButton setBackgroundImage:[UIImage imageNamed:@"电话"] forState:UIControlStateNormal];
    [dailButton addTarget:self action:@selector(dailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dailButton];
    UILabel *dailLable = [[UILabel alloc] init];
    dailLable.text =@"服务热线:";
    dailLable.textAlignment =NSTextAlignmentCenter;
    dailLable.textColor =RGBCOLOR(51, 51, 51);
    [self.view addSubview:dailLable];
    UIButton *numbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [numbutton setTitle:self.contact forState:UIControlStateNormal];
    [numbutton setTitleColor:RGBCOLOR(137, 86, 85) forState:UIControlStateNormal];
    [numbutton addTarget:self action:@selector(dailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:numbutton];
    
    
    
    
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(72, 72));
        make.top.greaterThanOrEqualTo(self.view).with.offset(36);
        make.top.lessThanOrEqualTo(self.view).with.offset(50);
        
    }];
    [logoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.greaterThanOrEqualTo(logoImgView.mas_bottom).with.offset(15);
        make.top.lessThanOrEqualTo(logoImgView.mas_bottom).with.offset(30);
    }];
    
    [searchImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(222, 37));
        make.top.greaterThanOrEqualTo(logoLable.mas_bottom).with.offset(45);
        make.top.lessThanOrEqualTo(logoLable.mas_bottom).with.offset(100);
        make.left.equalTo(self.view).with.offset(49);
        make.right.equalTo(self.view).with.offset(-49);

    }];
    [camaraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.greaterThanOrEqualTo(searchImgView.mas_right).with.offset(-45);
         make.size.mas_greaterThanOrEqualTo(CGSizeMake(23, 20));
        make.centerY.equalTo(searchImgView);
    }];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.greaterThanOrEqualTo(searchImgView.mas_right).with.offset(-8);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(22, 22));
        make.centerY.equalTo(searchImgView);
    }];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImgView.mas_left).with.offset(3);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(150, 37));
        make.centerY.equalTo(searchImgView);
        
    }];
    [dailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(searchImgView.mas_bottom).with.offset(125);
//        make.left.greaterThanOrEqualTo(self.view).with.offset(82);
//        make.right.equalTo(dailLable.mas_left).offset(-15);
        make.right.equalTo(self.view).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 27));
        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom).with.offset(-110);
    }];
    [dailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(40);
//        make.right.equalTo(self.view.mas_centerX).with.offset(-5);
        make.centerY.equalTo(dailButton);
        
    }];
    [numbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dailButton);
        make.left.equalTo(dailLable.mas_right).with.offset(15);
    }];
    
}
-(void)camabtnClick{
    NSLog(@"nidaye");
}
-(void)searchButtonClick{
    kuaidiResultController *resultVC =[[kuaidiResultController alloc] init];
    resultVC.logoImg =self.logoimage;
    resultVC.name = self.name;
    resultVC.com = self.com;
    resultVC.num = textField.text;
    [self.navigationController pushViewController:resultVC animated:YES];
}
-(void)dailButtonClick{
    [self alertView];
}
-(void)alertView{
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.contact]]];
        
    }
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
