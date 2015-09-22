//
//  TrainResultFirstCell.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/14.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainModel.h"

@interface TrainResultFirstCell : UITableViewCell
{
//    站站cell
    UILabel *startTimeLabel;
    UILabel *arriveTimeLabel;
    UILabel *fromStationLabel;
    UILabel *toStationLabel;
    UILabel *cheCiLabel;
    UILabel *lishiLabel;
    UILabel *saleLabel;
    UILabel *numLabel;
    UIImageView *isStartImg;
    UIImageView *isEndImg;
}

@property(nonatomic,retain) TrainModel *trainModel;

@end
