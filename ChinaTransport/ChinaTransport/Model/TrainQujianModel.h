//
//  TrainQujianModel.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/15.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TrainQujianCellType){
    /**
     *  未选中但可选状态（黑）
     */
    TrainQujianCellTypeUnselected= 0,
    /**
     *  选中状态（红）
     */
    TrainQujianCellTypeSelected = 1,
    /**
     *  不可选状态（灰）
     */
    TrainQujianCellTypeCannotSelected = 2,
    /**
     *  首行内容（白色）
     */
    TrainQujianCellTypeFirstRow = 3,
    /**
     *  首行内容（白色）
     */
    TrainQujianCellTypeStartStationRow = 4,
};


@interface TrainQujianModel : NSObject
@property (nonatomic,copy)NSString *id;  //id
@property (nonatomic,copy)NSString *arrive_time;  //到达时间
@property (nonatomic,copy)NSString *start_time;  //出发时间
@property (nonatomic,copy)NSString *station_name; //站名
@property (nonatomic,copy)NSString *station_code; //站名
@property (nonatomic,copy)NSString *station_no;// 站序
@property (nonatomic,copy)NSString *stopover_time;//经停事件
@property (nonatomic,copy)NSString *train_no;//火车编号


@property (nonatomic,assign)TrainQujianCellType cellType;

@end
