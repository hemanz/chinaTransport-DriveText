//
//  ResultController.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/12.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "RootViewController.h"
#import "TrainQujianModel.h"

@interface TrainQujianController : RootViewController

@property(nonatomic,retain)TrainQujianModel *trainQujianModel;

@property (nonatomic,copy)NSString *checi;
@property (nonatomic,copy)NSString *checiDate;

@end
