//
//  FeedbackViewController.m
//  RadioHost
//
//  Created by shuainan on 15/5/26.
//  Copyright (c) 2015年 国广高通（北京）传媒 科技有限公司. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UserInfoData.h"
#import "NetManager.h"


@interface FeedbackViewController (){
    UITextView *_feedbackTextView;      //反馈的内容textview
    UITextField *_mphoneTF;             //输入电话号码的textview
    UILabel *_placeholderLabel;         //默认显示的东西
}

@end

@implementation FeedbackViewController

#pragma mark - view life cycle
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTiTle:@"- 意 见 反 馈 -"];
    [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backBtnClick) location:YES ];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    [self creatUI];
}

-(void)creatUI{
    /**
     反馈的textfield
     */
    _feedbackTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, wid, 100)];
    _feedbackTextView.backgroundColor = [UIColor whiteColor];
    _feedbackTextView.font =   [UIFont fontWithName:@"Arial" size:18.0];
    _feedbackTextView.delegate=self;
    [self.view addSubview:_feedbackTextView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /**
     输入手机号的textfield
     */
    _mphoneTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 120, wid, 50)];
    _mphoneTF.placeholder = @"请填写您的联系方式";
    _mphoneTF.backgroundColor = [UIColor whiteColor];
    
    
    /**
     左边空出5
     
     :returns: 新的手机号格式
     */
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    _mphoneTF.leftViewMode = UITextFieldViewModeAlways;
    _mphoneTF.leftView = leftView;
    [self.view addSubview:_mphoneTF];
    
    /**
     默认显示“请意见反馈的”
     */
    _placeholderLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, wid, 40)];
    _placeholderLabel.text = @"请填写意见反馈...";
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    _placeholderLabel.textColor = [UIColor colorWithWhite:0.55 alpha:0.5];
    
    
    
    /**
     *  提交按钮
     */
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(15,heigh-120-64, wid-30, 40);
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(feedbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.backgroundColor=RGBCOLOR(152, 86, 85);
    [self.view addSubview:submitBtn];
    [self.view addSubview:_placeholderLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  控制textview的默认显示内容是否显示
 *
 *  @param textView 需要控制的tv
 */
-(void)textViewDidChange:(UITextView *)textView
{
    _feedbackTextView.text =  textView.text;
    if (textView.text.length == 0) {
        _placeholderLabel.text = @"请填写反馈意见...";
    }else{
        _placeholderLabel.text = @"";
    }
}

#pragma mark - button click or gesture event

/**
 *  提交反馈信息
 */
-(void)feedbackBtnClick{
    NSString* mphone = [_mphoneTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * URLString = [Url FeedBackUrl:mphone withFeedBack:_feedbackTextView.text];
//由于意见等可能会带有中文，需进行URLENCODER
    URLString =[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if(![UserInfoData isBlankString: _feedbackTextView.text]){
        [Netmanager GetRequestWithUrlString:URLString finished:^(id responseobj) {
            NSString * resCode= responseobj[@"resCode"];
            NSString * resMsg= responseobj[@"resMsg"];
            
            if ([resCode isEqualToString:@"0000"]) {
                [self.navigationController popViewControllerAnimated:YES];
                [self showAlertView:@"意见反馈成功"];
            }else{
                [self showAlertView:[NSString stringWithFormat:@"意见反馈失败:%@",resMsg]];
            }

        } failed:^(NSString *errorMsg) {
            
        }];
        
//        [NetManager requestWithString:URLString finished:^(id responseObj) {
//            NSString * resCode= responseObj[@"resCode"];
//            NSString * resMsg= responseObj[@"resMsg"];
//            
//            if ([resCode isEqualToString:RESCODE_OK]) {
//                [self.navigationController popViewControllerAnimated:YES];
//                [self showAlertView:@"意见反馈成功"];
//            }else{
//                [self showAlertView:[NSString stringWithFormat:@"意见反馈失败:%@",resMsg]];
//            }
//            
//        } failed:^(NSString *errorMsg) {
//            [self showAlertView:@"网络连接失败"];
//        }];
        
    }else{
        [self showAlertView:@"请填写反馈意见"];
    }
}

-(void)showAlertView:(NSString *)resMsg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",resMsg] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


-(void)backBtnClick{
       [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  点击屏幕收起键盘
 *
 */
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

@end
