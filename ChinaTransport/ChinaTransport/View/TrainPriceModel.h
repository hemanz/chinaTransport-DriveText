//
//  TrainPriceModel.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/16.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainPriceModel : NSObject

@property (nonatomic,copy)NSString *sitType;  //座位级别
@property (nonatomic,copy)NSString *price;  //票价
@property (nonatomic,copy)NSString *sitNum; //剩余张数

@property (nonatomic,copy)NSString *limitNum; //剩余张数Limit
@end
