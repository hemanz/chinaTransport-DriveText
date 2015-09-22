//
//  DrivingHomeViewController.m
//  ChinaTransport
//
//  Created by herr on 15/9/18.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "DrivingHomeViewController.h"
#import "DrivingModel.h"
#import "DrivingExamViewController.h"
#import "DBManager.h"

@interface DrivingHomeViewController ()
{
    UIScrollView *botScrollView;
    DrivingModel *drivingModel;
}
@end


@implementation DrivingHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    drivingModel=[[DrivingModel alloc]init];
    [self createUI];
}

-(void)createUI{
    [self addTiTle:@"- 试 题 选 择 -"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    botScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, wid, heigh-64)];
    botScrollView.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
    botScrollView.contentSize = CGSizeMake(0, (wid-66)/4+wid/3*2+384);
    botScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:botScrollView];
    
    //添加一、车型选择所有ui
    UIView *firstTitleView =[MyControl createUIViewWithFrame:CGRectMake(0, 0, wid, 45) color:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]]];
    UILabel *firstTitleLabel = [MyControl createLabelWithFrame:CGRectMake(15, 15, 200, 15) text:@"一、车型选择" font:15 textcolor:RGBCOLOR(51, 51, 51) textAlignment:0 backgroundColor:[UIColor clearColor]];
    [firstTitleView addSubview:firstTitleLabel];
    [botScrollView addSubview:firstTitleView];
    
    NSArray *carTypeTitleArray = @[@"小车(C1/C2)",@"客车(A1/B1)",@"货车(A2/B2)"];
    NSArray *carTypeImageArray = @[@"小车",@"客车",@"货车"];
    for (NSInteger i=0; i<3; i++) {
        UIButton *carTypeButton = [MyControl createButtonWithType:UIButtonTypeCustom Frame:CGRectMake(i*wid/3,CGRectGetMaxY(firstTitleView.frame)+0.5, wid/3-0.5, wid/3+10) title:carTypeTitleArray[i] titleColor:RGBCOLOR(51, 51, 51) imageName:carTypeImageArray[i] bgImageName:nil target:self method:@selector(carTypeButton:)];
        carTypeButton.backgroundColor=[UIColor clearColor];
        
        [carTypeButton setImageEdgeInsets:UIEdgeInsetsMake(-40, (wid/3-65)/2, 0, (wid/3-65)/2)];
        //wid/3 为每个格子大小，65为图片width，左右间隙各为剩余的一半
        [carTypeButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -65, 0, 0)];
        carTypeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        carTypeButton.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
        
        if (i==0) {
            UIImageView *im=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"carTypeCheck"]];
            im.frame=CGRectMake(65-17, 65-17, 17, 17);
            [carTypeButton.imageView addSubview:im];
            [carTypeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            drivingModel.carType=i;
        }
        
        carTypeButton.tag =2015091815+i;
        [botScrollView addSubview:carTypeButton];
    }
    
    UIView *secTitleView =[MyControl createUIViewWithFrame:CGRectMake(0, CGRectGetMaxY(firstTitleView.frame)+(wid/3+10)+1, wid, 45) color:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]]];
    UILabel *secTitleLabel = [MyControl createLabelWithFrame:CGRectMake(15, 15, 200, 15) text:@"二、科目和类别选择" font:15 textcolor:RGBCOLOR(51, 51, 51) textAlignment:0 backgroundColor:[UIColor clearColor]];
    [secTitleView addSubview:secTitleLabel];
    [botScrollView addSubview:secTitleView];
    
    //二、添加考试类别选择UI
    NSArray *arr = @[@"科目一",@"科目四"];
    for (NSInteger i=0; i<arr.count; i++) {
        UIButton *examTypeBtn =[MyControl createButtonWithType:UIButtonTypeCustom Frame:CGRectMake(i*wid/arr.count+10, CGRectGetMaxY(secTitleView.frame), wid/arr.count-20, 35) title:arr[i] titleColor:RGBCOLOR(51, 51, 51) imageName:nil bgImageName:nil target:self method:@selector(examTypeButtonClick:)];

        examTypeBtn.tag=201592011+i;
        if (i==0) {
            [examTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [examTypeBtn setBackgroundColor:RGBCOLOR(15, 141, 156)];
            drivingModel.examType=i;
        }else{
            [examTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [examTypeBtn setBackgroundColor:RGBCOLOR(233, 224, 195)];
        }
        [botScrollView addSubview:examTypeBtn];
        
    }
    
    //下面考试类型选择
    NSArray *testTypeTitleArray = @[@"顺序练习",@"随机练习",@"模拟考试"];
    NSArray *testTypeImageArray = @[@"顺序练习",@"随机练习",@"模拟考试"];
    for (NSInteger i=0; i<3; i++) {
        UIButton *testTypeButton = [MyControl createButtonWithType:UIButtonTypeCustom Frame:CGRectMake(i*wid/3,CGRectGetMaxY(secTitleView.frame)+35+0.5, wid/3, wid/3+10) title:testTypeTitleArray[i] titleColor:RGBCOLOR(51, 51, 51) imageName:testTypeImageArray[i] bgImageName:nil target:self method:@selector(testTypeButton:)];
        testTypeButton.backgroundColor=[UIColor clearColor];
//        [testTypeButton.layer setBorderWidth:0.5]; //边框宽度
        
        [testTypeButton setImageEdgeInsets:UIEdgeInsetsMake(-40, (wid/3-43)/2, 0, (wid/3-43)/2)];
        //wid/3 为每个格子大小，65为图片width，左右间隙各为剩余的一半
        [testTypeButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -43, 0, 0)];
        testTypeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        testTypeButton.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
        testTypeButton.tag =2015092212+i;
        [botScrollView addSubview:testTypeButton];
    }
    
}


-(void)carTypeButton:(UIButton *)btn{
    for (NSInteger i=0; i<3; i++) {
        UIButton *carTypeBtn=(UIButton *)[botScrollView viewWithTag:2015091815+i];
        [carTypeBtn setTitleColor:RGBCOLOR(51, 51, 51) forState:UIControlStateNormal];
        for(UIView * view in carTypeBtn.imageView.subviews){
            if([view isKindOfClass:[UIImageView class]])
            {
                [view removeFromSuperview];
            }
        }
    }
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    UIImageView *im=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"carTypeCheck"]];
    im.frame=CGRectMake(65-17, 65-17, 17, 17);
    [btn.imageView addSubview:im];
    drivingModel.carType= btn.tag-2015091815;
}

-(void)examTypeButtonClick:(UIButton *)btn{
    for (NSInteger i=0; i<2; i++) {
        UIButton *examTypeBtn=(UIButton *)[botScrollView viewWithTag:201592011+i];
        [examTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [examTypeBtn setBackgroundColor:RGBCOLOR(233, 224, 195)];
    }
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:RGBCOLOR(15, 141, 156)];
    drivingModel.examType=btn.tag-201592011;
}

-(void)testTypeButton:(UIButton *)btn{
    drivingModel.testType=btn.tag-2015092212;
    if ([self queryHasDataFromDB]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"开始做题"
                                                        message:@"上次做过练习，是否继续？"
                                                       delegate:self
                                              cancelButtonTitle:@"继续做"
                                              otherButtonTitles:@"重新做",nil];
        [alert show];
    }else{
        [self goToDrivingExamViewController];
    }
    
}

#pragma mark - uialertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            //重新做，则重置sqlite的作答数据
            [self resetExamDataFromDB];
            break;
        default:
            break;
    }
    //跳转到做题页面
    [self goToDrivingExamViewController];
}

-(void)goToDrivingExamViewController{
    DrivingExamViewController *examVC=[[DrivingExamViewController alloc]init];
    examVC.drivingModel=drivingModel;
    [self.navigationController pushViewController:examVC animated:YES];
}

-(BOOL)queryHasDataFromDB{
    DBManager *dbmanager =[DBManager shareRecordingDBManager];
    NSInteger count =[dbmanager queryDrivingChooseAnswerCount];
    return count>0;
}

-(BOOL)resetExamDataFromDB{
    DBManager *dbmanager =[DBManager shareRecordingDBManager];
    return [dbmanager resetDrivingChooseAnswer];
}

@end
