//
//  DrivingTestViewController.m
//  ChinaTransport
//
//  Created by herr on 15/9/18.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "DrivingExamViewController.h"
#import "DBManager.h"

@implementation DrivingExamViewController{
    NSMutableArray *examDataMArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    examDataMArray=[[NSMutableArray alloc]initWithCapacity:10];
    self.view.backgroundColor = [UIColor whiteColor];
    [self queryExamDataFromDB];
    if ([examDataMArray count]>0) {
        [self addTiTle:[NSString stringWithFormat:@"共%ld题",[examDataMArray count]]];
        self.testScrollView = [[DrivingTestScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) withDrivingDataArray:examDataMArray];
        [self.view addSubview:self.testScrollView];
    }else{
        UIImageView *noDrivingDataImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"驾考试题"]];
        UILabel *noDrivingDataLabel=[[UILabel alloc]init];
        noDrivingDataLabel.text=@"未初始化数据";
        noDrivingDataLabel.font=[UIFont systemFontOfSize:12];
        noDrivingDataLabel.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:noDrivingDataImageView];
        [self.view addSubview:noDrivingDataLabel];
        
        [noDrivingDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@[self.view]);
            make.centerY.equalTo(self.view).with.offset(-10);
        }];
        [noDrivingDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@[self.view]);
            make.centerY.equalTo(self.view).with.offset(20);
            make.size.mas_equalTo(CGSizeMake(200, 30));
        }];
    }
    
}

-(void)queryExamDataFromDB{
    DBManager *dbmanager =[DBManager shareRecordingDBManager];
    examDataMArray =[dbmanager loadDrivingData:self.drivingModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
