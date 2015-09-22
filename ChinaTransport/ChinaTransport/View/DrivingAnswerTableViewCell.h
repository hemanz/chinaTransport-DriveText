//
//  DrivingAnswerTableViewCell.h
//  ChinaTransport
//
//  Created by herr on 15/9/18.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrivingAnswerModel.h"

@interface DrivingAnswerTableViewCell : UITableViewCell{
    UILabel *answerLabel;
    UIImageView *flagImageView;
}

@property (nonatomic,retain)  DrivingAnswerModel *drivingAnswerModel;

@end