//
//  RoadStatusCell.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/16.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoadStatusmodel.h"

@interface RoadStatusCell : UITableViewCell
{
    UIImageView *topImgView;
    UIImageView *logoImgView;
    UILabel *titleLabel;
    UILabel *typeLabel;
    UILabel *timeLable;
    UIImageView *botImgView;
    UILabel *sizeStringLabel;
}

@property (nonatomic,retain)RoadStatusmodel *roadStatusmodel;
@end
