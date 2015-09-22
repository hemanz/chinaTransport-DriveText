//
//  DrivingTestViewController.h
//  ChinaTransport
//
//  Created by herr on 15/9/18.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "RootViewController.h"
#import "DrivingModel.h"
#import "DrivingTestScrollView.h"
@interface DrivingExamViewController : RootViewController

@property(nonatomic,retain)DrivingModel *drivingModel;

@property(nonatomic,strong)DrivingTestScrollView *testScrollView;
@end
