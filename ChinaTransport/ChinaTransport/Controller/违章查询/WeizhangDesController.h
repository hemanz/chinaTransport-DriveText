//
//  WeizhangDesController.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/19.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "RootViewController.h"

@interface WeizhangDesController : RootViewController


@property (nonatomic,copy)NSString *cityName;
@property (nonatomic,copy)NSString *carNo;
@property (nonatomic,copy)NSString *enginenoORclassno;   //只第三行时  可能是engineno也可能是classno
@property (nonatomic,copy)NSString *judgeClassno;  //第四行出现时  是classno
@property (nonatomic,copy)NSString *randCode;

@end
