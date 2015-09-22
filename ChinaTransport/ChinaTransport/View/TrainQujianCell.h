//
//  TrainResultCell.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/12.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainQujianModel.h"




@interface TrainQujianCell : UITableViewCell
{
//    时刻信息
    UILabel *stationNoLabel;
    UILabel *stationNameLabel;
    UILabel *arriveTimeLabel;
    UILabel *startTimeLabel;
    UILabel *stopoverTimeLabel;
}
@property(nonatomic,retain) TrainQujianModel *trainQujianModel;
@end
