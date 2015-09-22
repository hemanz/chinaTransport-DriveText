//
//  TrainModel.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/15.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainModel : NSObject

@property (nonatomic,copy)NSString *start_time;  //出发时间
@property (nonatomic,copy)NSString *arrive_time;  //到达时间
@property (nonatomic,copy)NSString *start_station_name; //始发站
@property (nonatomic,copy)NSString *start_station_telecode;//始发站telecode
@property (nonatomic,copy)NSString *end_station_name;// 终点站
@property (nonatomic,copy)NSString *end_station_telecode;//终点站telecode
@property (nonatomic,copy)NSString *start_train_date;// 发车日期
@property (nonatomic,copy)NSString *station_train_code;// 列车车次
@property (nonatomic,copy)NSString *from_station_name;// 出发站
@property (nonatomic,copy)NSString *from_station_no;//出发站 的序列
@property (nonatomic,copy)NSString *from_station_telecode;//出发站的telecode
@property (nonatomic,copy)NSString *to_station_name;//到达站
@property (nonatomic,copy)NSString *to_station_no;//到达站序列
@property (nonatomic,copy)NSString *to_station_telecode;//to 车站名
@property (nonatomic,copy)NSString *train_no;//
@property (nonatomic,copy)NSString *lishi;  //total time
@property (nonatomic,copy)NSString *tz_num;//特等座
@property (nonatomic,copy)NSString *wz_num;//无座
@property (nonatomic,copy)NSString *gr_num;//高级软卧
@property (nonatomic,copy)NSString *yw_num;//硬卧
@property (nonatomic,copy)NSString *yz_num;//硬座
@property (nonatomic,copy)NSString *ze_num;//二等座
@property (nonatomic,copy)NSString *zy_num;//一等座
@property (nonatomic,copy)NSString *rw_num;//软卧
@property (nonatomic,copy)NSString *rz_num;//软座
@property (nonatomic,copy)NSString *swz_num;//商务座
@property (nonatomic,copy)NSString *qt_num;//其他
@property (nonatomic,copy)NSString *canWebBuy;//能否购买

@property (nonatomic,strong)NSArray *zhanzhanArray;   //站站数据Array


@end
